//
//  LXWeatherDetailView.m
//  iWeather
//
//  Created by helloworld on 2017/8/19.
//  Copyright © 2017年 topkid. All rights reserved.
//

#import "LXWeatherDetailView.h"
#import <Masonry.h>

@implementation LXWeatherDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:nil options:nil].lastObject;
        self.timeLabel.textColor = self.weatherLabel.textColor = self.temperatureLabel.textColor = [UIColor whiteColor];
        self.timeLabel.font = [UIFont systemFontOfSize:14];
        self.weatherLabel.font = self.temperatureLabel.font = [UIFont systemFontOfSize:10];
        self.timeLabel.textAlignment = self.weatherLabel.textAlignment = self.temperatureLabel.textAlignment = NSTextAlignmentCenter;
        [self setFrame:frame];
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

@end
