//
//  ViewController.m
//  WBFloatAnimation
//
//  Created by Transuner on 2017/5/16.
//  Copyright © 2017年 M哦得了 QQ:299814. All rights reserved.
//

#import "ViewController.h"
#import "WBFloatAnimationButton.h"
@interface ViewController ()
@property (nonatomic, strong) WBFloatAnimationButton * floatAnimationButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.floatAnimationButton = [[WBFloatAnimationButton alloc]init];
    self.floatAnimationButton.frame = CGRectMake(100, 500, 45, 45);
    self.floatAnimationButton.images = @[[UIImage imageNamed:@"heart1"],
                                         [UIImage imageNamed:@"heart2"],
                                         [UIImage imageNamed:@"heart3"]];
    [self.view addSubview:self.floatAnimationButton];
    
    NSTimer*_timera = [NSTimer scheduledTimerWithTimeInterval:.3f target:self
                                                     selector:@selector(startHeart) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timera forMode:NSRunLoopCommonModes];

}


- (void) startHeart {
    [self.floatAnimationButton startRandom];
}


@end
