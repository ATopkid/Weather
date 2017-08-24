//
//  LXScrollViewContentView.m
//  iWeather
//
//  Created by helloworld on 2017/8/21.
//  Copyright © 2017年 topkid. All rights reserved.
//

#import "LXScrollViewContentView.h"

#define kHEIGHT [UIScreen mainScreen].bounds.size.height
#define kWIDTH [UIScreen mainScreen].bounds.size.width

@implementation LXScrollViewContentView

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:nil options:nil] lastObject];
        self.backgroundColor = [UIColor clearColor];
//        CAGradientLayer *gradientLayer= [CAGradientLayer layer];;
//        gradientLayer.frame = self.bounds;
//        
//        [self.layer addSublayer:gradientLayer];
//        
//        gradientLayer.startPoint = CGPointMake(0, 0);
//        gradientLayer.endPoint = CGPointMake(0, 1);
//        
//        gradientLayer.colors = @[(__bridge id)[UIColor clearColor].CGColor,
//                                 (__bridge id)[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3].CGColor];
//        
//        gradientLayer.locations = @[@(0.5f), @(1.0f)];
        [self changeUI];
    }
    
    return self;
}

- (void)changeUI {
    self.rainfallRateLabel.layer.cornerRadius = 6;
    self.airGradeLabel.layer.cornerRadius = 10;
    self.windMillImageView.layer.cornerRadius = 10;
    self.windMillImageView.clipsToBounds = YES;
    self.daytimeImageView.contentMode = UIViewContentModeScaleToFill;
    self.nightImageView.contentMode = UIViewContentModeScaleToFill;
}

@end
