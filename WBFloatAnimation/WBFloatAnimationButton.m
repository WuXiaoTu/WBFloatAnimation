//
//  WBFloatAnimationButton.m
//  WBFloatAnimation
//
//  Created by Transuner on 2017/5/16.
//  Copyright © 2017年 M哦得了 QQ:299814. All rights reserved.
//

#import "WBFloatAnimationButton.h"

@interface WBFloatAnimationButton ()<CAAnimationDelegate>

@property (nonatomic, strong) NSMutableArray * layerArray;
@property (nonatomic, strong) NSMutableSet   * layerSets;
@property (nonatomic, assign) CGFloat          maxWidth;
@property (nonatomic, assign) CGPoint          startPoint;
@end

@implementation WBFloatAnimationButton

- (NSMutableArray *) layerArray {
    if (!_layerArray) {
        _layerArray = [[NSMutableArray alloc]init];
    }
    return _layerArray;
}

- (NSMutableSet *) layerSets {
    if (!_layerSets) {
        _layerSets = [[NSMutableSet alloc]init];
    }
    return _layerSets;
}

- (instancetype) init {
    
    if (self = [super init]) {
        [self initValue];
    }
    return self;
}

- (instancetype) initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self initValue];
    }
    return self;
}


/* 设置默认值 */
- (void) initValue {
    _maxLeft = 30;
    _maxRight = 25;
    _maxHeight = 320;
    _duration = 6;
}

- (void) startRandom {
    CALayer * layer = [CALayer layer];
    if (self.layerSets.count > 0) {
        layer = [self.layerSets anyObject];
        [self.layerSets removeObject:layer];
    } else {
        UIImage * image = self.images[arc4random() % self.images.count];
        layer = [self layerWithImage:image];
    }
    [self.layer addSublayer:layer];
    [self createFloatWithLayer:layer];
}

- (void) createFloatWithLayer:(CALayer *)layer {
    
    _maxWidth = _maxLeft + _maxRight;
    
    _startPoint = CGPointMake(self.frame.size.width / 2, 0);
    
    CGPoint endPoint   = CGPointMake(_maxWidth * [self randomFloat] - _maxLeft, -_maxHeight);
    CGPoint controlPoint1 =
    CGPointMake(_maxWidth * [self randomFloat] - _maxLeft, -_maxHeight * 0.2);
    CGPoint controlPoint2 =
    CGPointMake(_maxWidth * [self randomFloat] - _maxLeft, -_maxHeight * 0.6);
    
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    CGPathMoveToPoint(curvedPath, NULL, _startPoint.x, _startPoint.y);
    CGPathAddCurveToPoint(curvedPath, NULL, controlPoint1.x, controlPoint1.y, controlPoint2.x, controlPoint2.y, endPoint.x, endPoint.y);
    
    
    CAKeyframeAnimation *keyFrame = [CAKeyframeAnimation animation];
    keyFrame.keyPath = @"position";
    keyFrame.path = CFAutorelease(curvedPath);
    keyFrame.duration = self.duration;
    keyFrame.calculationMode = kCAAnimationPaced;
    
    [layer addAnimation:keyFrame forKey:@"keyframe"];
    
    CABasicAnimation *scale = [CABasicAnimation animation];
    scale.keyPath = @"transform.scale";
    scale.toValue = @1;
    scale.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 0.1)];
    scale.duration = 0.5;
    
    CABasicAnimation *alpha = [CABasicAnimation animation];
    alpha.keyPath = @"opacity";
    alpha.fromValue = @1;
    alpha.toValue = @0.1;
    alpha.duration = self.duration * 0.4;
    alpha.beginTime = self.duration - alpha.duration;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[keyFrame, scale, alpha];
    group.duration = self.duration;
    group.delegate = self;
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    [layer addAnimation:group forKey:@"group"];
    
    [self.layerArray addObject:layer];
}

- (CALayer *) layerWithImage:(UIImage *)image {
    CGFloat scale   = [UIScreen mainScreen].scale;
    CALayer * layer = [CALayer layer];
    layer.frame     = CGRectMake(0, 0, image.size.width / scale, image.size.height / scale);
    layer.contents  = (__bridge id)image.CGImage;;
    return layer;
}

- (CGFloat)randomFloat{
    return (arc4random() % 100)/100.0f;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (flag) {
        CALayer *layer = [self.layerArray firstObject];
        [layer removeAllAnimations];
        [layer removeFromSuperlayer];
        [self.layerArray removeObject:layer];
        [self.layerSets addObject:layer];
    }
}
@end
