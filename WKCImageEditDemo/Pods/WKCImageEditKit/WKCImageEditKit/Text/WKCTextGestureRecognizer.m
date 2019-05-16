//
//  WKCTextGestureRecognizer.m
//  ddasd
//
//  Created by WeiKunChao on 2019/5/14.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import "WKCTextGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

@interface WKCTextGestureRecognizer()

@property (nonatomic, strong) UIView * anchorView;

@end

@implementation WKCTextGestureRecognizer

- (instancetype)initWithTarget:(id)target
                        action:(SEL)action
                    anchorView:(UIView *)anchorView
{
    self = [super initWithTarget:target
                          action:action];
    if (self)
    {
        _anchorView = anchorView;
    }
    return self;
}


#pragma mark GestureHandle
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([[event touchesForGestureRecognizer:self] count] > 1)
    {
        self.state = UIGestureRecognizerStateFailed;
    }
}


- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.state == UIGestureRecognizerStatePossible)
    {
        self.state = UIGestureRecognizerStateBegan;
    }
    else
    {
        self.state = UIGestureRecognizerStateChanged;
    }
    
    UITouch *touch = [touches anyObject];
    CGPoint anchorViewCenter = self.anchorView.center;
    CGPoint currentPoint = [touch locationInView:self.anchorView.superview];
    CGPoint previousPoint = [touch previousLocationInView:self.anchorView.superview];
    
    CGFloat currentRotation = atan2f((currentPoint.y - anchorViewCenter.y), (currentPoint.x - anchorViewCenter.x));
    CGFloat previousRotation = atan2f((previousPoint.y - anchorViewCenter.y), (previousPoint.x - anchorViewCenter.x));
    
    CGFloat currentRadius = [self distanceBetweenFirstPoint:currentPoint secondPoint:anchorViewCenter];
    CGFloat previousRadius = [self distanceBetweenFirstPoint:previousPoint secondPoint:anchorViewCenter];
    CGFloat scale = currentRadius / previousRadius;
    
    [self setRotation:(currentRotation - previousRotation)];
    [self setScale:scale];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.state == UIGestureRecognizerStateChanged)
    {
        self.state = UIGestureRecognizerStateEnded;
    }
    else
    {
        self.state = UIGestureRecognizerStateFailed;
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.state = UIGestureRecognizerStateFailed;
}

- (CGFloat)distanceBetweenFirstPoint:(CGPoint)first
                         secondPoint:(CGPoint)second
{
    CGFloat deltaX = second.x - first.x;
    CGFloat deltaY = second.y - first.y;
    return sqrt(deltaX * deltaX + deltaY * deltaY);
}

- (void)reset
{
    self.rotation = 0;
    self.scale = 1;
}


@end
