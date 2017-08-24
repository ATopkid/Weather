//
//  LXHorizontalPickerView.m
//  iWeather
//
//  Created by helloworld on 2017/8/19.
//  Copyright © 2017年 topkid. All rights reserved.
//

#import "LXHorizontalPickerView.h"
#import "LXWeatherDetailView.h"

#define kHEIGHT [UIScreen mainScreen].bounds.size.height
#define kWIDTH [UIScreen mainScreen].bounds.size.width

@implementation LXHorizontalPickerView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
//        self.pagingEnabled = YES;
        self.contentSize = CGSizeMake(1000, 150);
    }
    
    return self;
}

@end
