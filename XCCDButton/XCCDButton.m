//
//  SQhiChatAnimationView.m
//  CDa
//
//  Created by 孙西纯 on 2019/1/3.
//  Copyright © 2019 孙西纯. All rights reserved.
//

#import "XCCDButton.h"

typedef NS_ENUM(NSInteger,XCCDButtonState) {
    XCCDButtonState_Normal,
    XCCDButtonState_Cool,
};

@interface XCCDButton()

@property (nonatomic,assign) CGFloat duration;
@property (nonatomic,strong) CALayer *bgLayer;
@property (nonatomic,strong) CALayer *shadowLayer;
@property (nonatomic,strong) CAShapeLayer *shadowMaskLayer;

@property (nonatomic,assign) XCCDButtonState CDState;

@end


@implementation XCCDButton

#pragma mark -- lazy init --

- (CALayer *)bgLayer
{
    if (!_bgLayer) {
        _bgLayer = [CALayer layer];
        _bgLayer.frame = self.bounds;
    }
    return _bgLayer;
}

- (CALayer *)shadowLayer
{
    if (!_shadowLayer) {
        _shadowLayer = [CALayer layer];
        _shadowLayer.frame = self.bounds;
    }
    return _shadowLayer;
}

- (CAShapeLayer *)shadowMaskLayer
{
    if (!_shadowMaskLayer) {
        CGFloat width = self.frame.size.width;
        CGFloat height = self.frame.size.height;
        CGPoint centerPoint = CGPointMake(width * 0.5f, height * 0.5f);
        CGFloat radius = width < height ? height * 0.5f : width * 0.5f;
        UIBezierPath *bgPath = [self shadowPath:centerPoint radius:radius];
        
        _shadowMaskLayer = [CAShapeLayer layer];
        _shadowMaskLayer.fillColor   = [UIColor clearColor].CGColor;
        _shadowMaskLayer.strokeColor = [UIColor lightGrayColor].CGColor;
        _shadowMaskLayer.strokeStart = 0.0f;
        _shadowMaskLayer.strokeEnd   = 1.0f;
        _shadowMaskLayer.zPosition   = 1;
        _shadowMaskLayer.lineWidth   = radius * 2.0f;
        _shadowMaskLayer.path        = bgPath.CGPath;
        _shadowLayer.mask = _shadowMaskLayer;
    }
    return _shadowMaskLayer;
}

- (UIBezierPath *)shadowPath:(CGPoint)center radius:(CGFloat)radius
{
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center
                                                        radius:radius
                                                    startAngle:M_PI_2 * 3
                                                      endAngle:-M_PI_2
                                                     clockwise:NO];
    return path;
}

#pragma mark -- init --

- (instancetype)initWithFrame:(CGRect)frame
                      bgImage:(UIImage *)bgImage
                    maskImage:(UIImage *)maskImage
                     duration:(CGFloat)duration
{
    self = [super initWithFrame:frame];
    if (self) {
        _duration = duration;

        [self.layer addSublayer:self.bgLayer];
        self.bgLayer.contents = (id)bgImage.CGImage;

        [self.layer addSublayer:self.shadowLayer];
        self.shadowLayer.contents = (id)maskImage.CGImage;
        
        self.shadowLayer.mask = self.shadowMaskLayer;
        self.shadowMaskLayer.hidden = YES;
    }
    return self;
}

#pragma mark -- control delegate --

- (void)endTrackingWithTouch:(nullable UITouch *)touch withEvent:(nullable UIEvent *)event
{
    self.CDState = XCCDButtonState_Cool;
    [self strokeAnimation];
    return [super endTrackingWithTouch:touch withEvent:event];
}

#pragma mark -- stroke animation --

- (void)strokeAnimation
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration  = self.duration;
    animation.fromValue = @1.0f;
    animation.toValue   = @0.0f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.delegate = (id <CAAnimationDelegate>)self;
    [self.shadowMaskLayer addAnimation:animation forKey:@"strokeEndAnimation"];
}

#pragma mark -- animation delegate --

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    self.CDState = XCCDButtonState_Normal;
}

#pragma mark -- state --

- (void)setCDState:(XCCDButtonState)CDState
{
    _CDState = CDState;
    
    switch (CDState) {
        case XCCDButtonState_Normal:
        {
            self.shadowMaskLayer.hidden = YES;
            self.enabled = YES;
        }
            break;
        case XCCDButtonState_Cool:
        {
            self.shadowMaskLayer.hidden = NO;
            self.enabled = NO;
        }
            break;
            
        default:
            break;
    }
}

@end
