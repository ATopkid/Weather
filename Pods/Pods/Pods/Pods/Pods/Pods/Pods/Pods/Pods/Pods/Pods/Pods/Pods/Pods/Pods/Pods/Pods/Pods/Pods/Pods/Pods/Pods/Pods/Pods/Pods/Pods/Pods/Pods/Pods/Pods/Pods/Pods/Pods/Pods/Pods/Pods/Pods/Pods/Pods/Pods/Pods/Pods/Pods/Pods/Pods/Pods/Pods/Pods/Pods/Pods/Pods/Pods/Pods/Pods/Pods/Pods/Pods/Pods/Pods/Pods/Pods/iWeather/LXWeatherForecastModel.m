//
//  LXWeatherForecastModel.m
//  iWeather
//
//  Created by helloworld on 2017/8/20.
//  Copyright © 2017年 topkid. All rights reserved.
//

#import "LXWeatherForecastModel.h"

@implementation LXWeatherForecastModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    
    if (self) {
        self.today_now_Dic = dic[@"HeWeather5"][0][@"now"];
        self.tomorrowDic = dic[@"HeWeather5"][0][@"daily_forecast"][1];
        self.theDayAfterTomorrowDic = dic[@"HeWeather5"][0][@"daily_forecast"][2];
        self.todayDic = dic[@"HeWeather5"][0][@"daily_forecast"][0];
        self.AQIDic = dic[@"HeWeather5"][0][@"aqi"][@"city"];
    }
    
    return self;
}

@end
