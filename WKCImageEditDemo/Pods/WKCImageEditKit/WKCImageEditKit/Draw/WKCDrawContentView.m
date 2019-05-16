//
//  WKCDrewContentView.m
//  ddasd
//
//  Created by WeiKunChao on 2019/5/14.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import "WKCDrawContentView.h"

typedef struct CGPath *CGMutablePathRef;
typedef enum CGBlendMode CGBlendMode;

@interface WKCStorke : NSObject

@property (nonatomic) CGMutablePathRef path;
@property (nonatomic, assign) CGBlendMode blendMode;
@property (nonatomic, assign) CGFloat strokeWidth;
@property (nonatomic, strong) UIColor *lineColor;

- (void)strokeWithContext:(CGContextRef)context;

@end

@implementation WKCStorke

- (void)strokeWithContext:(CGContextRef)context
{
    CGContextSetStrokeColorWithColor(context, [_lineColor CGColor]);
    CGContextSetLineWidth(context, _strokeWidth);
    CGContextSetBlendMode(context, _blendMode);
    CGContextBeginPath(context);
    CGContextAddPath(context, _path);
    CGContextStrokePath(context);
}

@end





@interface WKCDrawContentView()
{
    CGMutablePathRef currentPath;//路径
}

//是否擦除
@property (nonatomic, assign) BOOL isEarse;
//存储所有的路径
@property (nonatomic, strong) NSMutableArray *stroks;

@end


@implementation WKCDrawContentView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _stroks = [[NSMutableArray alloc] initWithCapacity:1];
        self.backgroundColor = [UIColor clearColor];
        self.lineColor = UIColor.yellowColor;
        self.lineWidth = 5;
        self.userInteractionEnabled = YES;
        UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(actionPan:)];
        pan.minimumNumberOfTouches = 1;
        [self addGestureRecognizer:pan];
    }
    
    return self;
}

- (void)actionPan:(UIPanGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        currentPath = CGPathCreateMutable();
        WKCStorke * stroke = [[WKCStorke alloc] init];
        stroke.path = currentPath;
        stroke.blendMode = _isEarse ? kCGBlendModeDestinationIn : kCGBlendModeNormal;
        stroke.strokeWidth = _isEarse ? 20.0 : _lineWidth;
        stroke.lineColor = _isEarse ? [UIColor clearColor] : _lineColor;
        [_stroks addObject:stroke];
        CGPoint point = [sender locationInView:self];
        CGPathMoveToPoint(currentPath, NULL, point.x, point.y);
    }
    else if (sender.state == UIGestureRecognizerStateChanged)
    {
        CGPoint point = [sender locationInView:self];
        CGPathAddLineToPoint(currentPath, NULL, point.x, point.y);
        [self setNeedsDisplay];
    }
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (WKCStorke *stroke in _stroks)
    {
        [stroke strokeWithContext:context];
    }
}


- (void)clear
{
    _isEarse = NO;
    [_stroks removeAllObjects];
    [self setNeedsDisplay];
}

- (void)revoke
{
    _isEarse = NO;
    [_stroks removeLastObject];
    [self setNeedsDisplay];
}

- (void)erase
{
    self.isEarse = YES;
}

- (void)setLineColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
    
    _isEarse = NO;
}

- (void)setLineWidth:(CGFloat)lineWidth
{
    _lineWidth = lineWidth;
    
    _isEarse = NO;
}

- (void)dealloc
{
    CGPathRelease(currentPath);
}

@end
