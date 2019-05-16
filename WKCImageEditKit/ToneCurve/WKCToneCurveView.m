//
//  WKCToneCurveView.m
//  ddasd
//
//  Created by WeiKunChao on 2019/5/14.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import "WKCToneCurveView.h"
#import "WKCControlPointView.h"
#import "WKCSplineInterpolator.h"

@interface WKCToneCurveView()

@property (nonatomic, strong, readonly) CIVector * point0;
@property (nonatomic, strong, readonly) CIVector * point1;
@property (nonatomic, strong, readonly) CIVector * point2;
@property (nonatomic, strong, readonly) CIVector * point3;
@property (nonatomic, strong, readonly) CIVector * point4;


@end

@implementation WKCToneCurveView
{
    NSArray <WKCControlPointView *>* _controlPoints;
    CGSize _pointSize;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _pointSize = CGSizeMake(10, 10);
        [self setupProperty];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame pointSize:(CGSize)pointSize
{
    if (self = [super initWithFrame:frame])
    {
        _pointSize = pointSize;
        [self setupProperty];
    }
    
    return self;
}

- (void)setupProperty
{
    self.backgroundColor = UIColor.clearColor;
    self.gridColor = UIColor.blackColor;
    self.gridWidth = 1;
    self.lineColor = UIColor.blackColor;
    self.lineWidth = 1;
    self.pointColor = UIColor.blackColor;
    
    NSMutableArray * tmp = [NSMutableArray array];
    for (NSInteger index = 0; index < 5; index ++)
    {
        [tmp addObject:[self controlPoint]];
    }
    
    _controlPoints = tmp.mutableCopy;
    [self resetPoints];
    self.userInteractionEnabled = YES;
}

- (WKCControlPointView *)controlPoint
{
    WKCControlPointView * view = [[WKCControlPointView alloc] initWithFrame:CGRectMake(0, 0, _pointSize.width * 3, _pointSize.height * 3)];
    view.backgroundColor = UIColor.clearColor;
    view.layoutFrame = self.frame;
    
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panControlPoint:)];
    pan.maximumNumberOfTouches = 1;
    [view addGestureRecognizer:pan];
    
    [self addSubview:view];
    
    return view;
}



- (void)panControlPoint:(UIPanGestureRecognizer *)sender
{
    static CGPoint initialPoint;
    if(sender.state == UIGestureRecognizerStateBegan)
    {
        initialPoint = [sender locationInView:self];
    }
    
    CGPoint point = [sender translationInView:self];
    NSInteger index = [_controlPoints indexOfObject:(WKCControlPointView *)sender.view];
    
    point.x = (initialPoint.x + point.x) / CGRectGetWidth(self.frame);
    point.y = (initialPoint.y + point.y) / CGRectGetHeight(self.frame);
    
    [self setControlPoint:point atIndex:index];
    
    [self setNeedsDisplay];
    if(sender.state == UIGestureRecognizerStateEnded)
    {
        [self postDelegate];
    }
}

- (void)resetPoints
{
    for(NSInteger i=0; i<_controlPoints.count; ++i)
    {
        CGFloat x = i/(CGFloat)(_controlPoints.count-1);
        WKCControlPointView *point = _controlPoints[i];
        point.controlPoint = [CIVector vectorWithCGPoint:CGPointMake(x, x)];
    }
    
    [self setNeedsDisplay];
    [self postDelegate];
}

- (void)setControlPoint:(CGPoint)point atIndex:(NSInteger)index
{
    if(index>=0 && index < _controlPoints.count)
    {
        WKCControlPointView * prev = (index==0) ? nil : _controlPoints[index-1];
        WKCControlPointView * target = _controlPoints[index];
        WKCControlPointView * next = (index+1<_controlPoints.count) ? _controlPoints[index+1] : nil;
        
        CGFloat left_limit  = (prev==nil) ? 0 : prev.controlPoint.X + 0.05;
        CGFloat right_limit = (next==nil) ? 1 : next.controlPoint.X - 0.05;
        
        point.x = MAX(left_limit, MIN(point.x, right_limit));
        point.y = MAX(0, MIN(1 - point.y, 1));
        
        target.controlPoint = [CIVector vectorWithCGPoint:point];
    }
}

- (CGPoint)convertControlPointToViewPoint:(CIVector *)controlPoint
{
    CGFloat X = MAX(0, MIN(controlPoint.X, 1));
    CGFloat Y = MAX(0, MIN(controlPoint.Y, 1));
    return CGPointMake(X * self.frame.size.width, (1 - Y) * self.frame.size.height);
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGRect rct = self.bounds;
    rct.origin.x += 1;
    rct.origin.y += 1;
    rct.size.width  -= 2;
    rct.size.height -= 2;

    CGContextSetStrokeColorWithColor(context, self.gridColor.CGColor);
    CGContextSetLineWidth(context, self.gridWidth);
    
    CGContextBeginPath(context);
    CGFloat dW = 0;
    for(int i = 0; i < 5; ++i)
    {
        CGContextMoveToPoint(context, rct.origin.x+dW, rct.origin.y);
        CGContextAddLineToPoint(context, rct.origin.x+dW, rct.origin.y+rct.size.height);
        dW += rct.size.width/4;
    }
    
    dW = 0;
    for(int i = 0; i < 5; ++i)
    {
        CGContextMoveToPoint(context, rct.origin.x, rct.origin.y+dW);
        CGContextAddLineToPoint(context, rct.origin.x+rct.size.width, rct.origin.y+dW);
        dW += rct.size.height/4;
    }
    CGContextStrokePath(context);
    
    NSMutableArray *points = [NSMutableArray array];
    for(WKCControlPointView *view in _controlPoints)
    {
        [points addObject:view.controlPoint];
    }
    
    WKCSplineInterpolator *spline = [[WKCSplineInterpolator alloc] initWithPoints:points];
    
    UIBezierPath *curve = [UIBezierPath bezierPath];
    CGContextSetStrokeColorWithColor(context, self.lineColor.CGColor);
    [curve setLineWidth:self.lineWidth];
    
    const NSInteger L = 100;
    
    [curve moveToPoint:[self convertControlPointToViewPoint:[CIVector vectorWithCGPoint:CGPointMake(0, self.point0.Y)]]];
    for(NSInteger i = 0; i < L; ++i)
    {
        double t = i / (double)(L-1);
        CIVector *point = [spline interpolatedPoint:t];
        [curve addLineToPoint:[self convertControlPointToViewPoint:point]];
    }
    [curve addLineToPoint:[self convertControlPointToViewPoint:[CIVector vectorWithCGPoint:CGPointMake(1, self.point4.Y)]]];
    [curve stroke];
}

#pragma mark -Setter、Getter
- (void)setPointColor:(UIColor *)pointColor
{
    _pointColor = pointColor;
    
    for (WKCControlPointView * view in _controlPoints)
    {
        view.bgColor = pointColor;
    }
}

- (void)setUserInteractionEnabled:(BOOL)userInteractionEnabled
{
    [super setUserInteractionEnabled:userInteractionEnabled];
    
    for (WKCControlPointView * view in _controlPoints)
    {
        view.userInteractionEnabled = userInteractionEnabled;
    }
}

- (CIVector *)point0
{
    return [_controlPoints[0] controlPoint];
}

- (CIVector *)point1
{
    return [_controlPoints[1] controlPoint];
}

- (CIVector *)point2
{
   return [_controlPoints[2] controlPoint];
}

- (CIVector *)point3
{
   return [_controlPoints[3] controlPoint];
}

- (CIVector *)point4
{
  return [_controlPoints[4] controlPoint];
}



- (void)postDelegate
{
    UIImage * origin = [self.delegate toneCurveViewOriginImage:self];
    UIImage * newImage = [self filteredImage:origin];
    [self.delegate toneCurveView:self didtoneCurved:newImage];
}

- (UIImage*)filteredImage:(UIImage*)image
{
    CIImage *ciImage = [[CIImage alloc] initWithImage:image];
    CIFilter *filter = [CIFilter filterWithName:@"CIToneCurve" keysAndValues:kCIInputImageKey, ciImage, nil];

    [filter setDefaults];
    [filter setValue:self.point0 forKey:@"inputPoint0"];
    [filter setValue:self.point1 forKey:@"inputPoint1"];
    [filter setValue:self.point2 forKey:@"inputPoint2"];
    [filter setValue:self.point3 forKey:@"inputPoint3"];
    [filter setValue:self.point4 forKey:@"inputPoint4"];
    
    CIContext *context = [CIContext contextWithOptions:@{kCIContextUseSoftwareRenderer : @(NO)}];
    CIImage *outputImage = [filter outputImage];
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
    
    UIImage *result = [UIImage imageWithCGImage:cgImage];
    
    CGImageRelease(cgImage);
    
    return result;
}

@end
