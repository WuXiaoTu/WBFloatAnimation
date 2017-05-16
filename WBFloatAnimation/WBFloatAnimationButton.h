//
//  WBFloatAnimationButton.h
//  WBFloatAnimation
//
//  Created by Transuner on 2017/5/16.
//  Copyright © 2017年 M哦得了 QQ:299814. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBFloatAnimationButton : UIButton


@property (nonatomic, assign) CGFloat maxLeft; /* 最大向左漂浮 默认 30 */
@property (nonatomic, assign) CGFloat maxRight; /* 最大向右漂浮 默认 25 */
@property (nonatomic, assign) CGFloat maxHeight; /* 最大漂浮高度 默认 320 */
@property (nonatomic, assign) CGFloat duration; /* 漂浮时长  默认 6 */
@property (nonatomic, strong) NSArray * images; /* 漂浮图片的数组 */


/* 启动随机动画 */
- (void) startRandom;
@end
