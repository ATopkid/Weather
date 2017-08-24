//
//  LXDeatilViewControllerModel.m
//  iWeather
//
//  Created by helloworld on 2017/8/22.
//  Copyright © 2017年 topkid. All rights reserved.
//

#import "LXDeatilViewControllerModel.h"

@implementation LXDeatilViewControllerModel

- (instancetype)initWithDic:(NSDictionary *)dic andDate:(NSInteger)date{
    self = [super init];
    
    if (self) {
        NSString *rainfallRate = dic[@"HeWeather5"][0][@"daily_forecast"][date][@"pop"];
        self.rainfallRate = [NSString stringWithFormat:@"降雨量%@%%", rainfallRate];
        self.daytimeWeather = dic[@"HeWeather5"][0][@"daily_forecast"][date][@"cond"][@"txt_d"];
        self.nightWeather = dic[@"HeWeather5"][0][@"daily_forecast"][date][@"cond"][@"txt_n"];
        NSMutableString *minTmp = dic[@"HeWeather5"][0][@"daily_forecast"][date][@"tmp"][@"min"];
        NSMutableString *maxTmp = dic[@"HeWeather5"][0][@"daily_forecast"][date][@"tmp"][@"max"];
        self.minToMaxTmp = [NSString stringWithFormat:@"%@～%@℃", minTmp, maxTmp];
        self.sunupTime = dic[@"HeWeather5"][0][@"daily_forecast"][date][@"astro"][@"sr"];
        self.sundownTime = dic[@"HeWeather5"][0][@"daily_forecast"][date][@"astro"][@"ss"];
        NSString *humidity = dic[@"HeWeather5"][0][@"daily_forecast"][date][@"hum"];
        self.humidity = [humidity stringByAppendingString:@"%"];
        NSString *pcpn = dic[@"HeWeather5"][0][@"daily_forecast"][date][@"pcpn"];
        self.pcpn = [pcpn stringByAppendingString:@"mm"];
        NSString *airPressure = dic[@"HeWeather5"][0][@"daily_forecast"][date][@"pres"];
        self.airPressure = [airPressure stringByAppendingString:@"hPa"];
        self.wind1 = dic[@"HeWeather5"][0][@"daily_forecast"][date][@"wind"][@"dir"];
        NSString *wind2 = dic[@"HeWeather5"][0][@"daily_forecast"][date][@"wind"][@"sc"];
        self.wind2 = [NSString stringWithFormat:@"风力：%@", wind2];
        NSString *wind3 = dic[@"HeWeather5"][0][@"daily_forecast"][date][@"wind"][@"spd"];
        self.wind3 = [NSString stringWithFormat:@"风速：%@kmph", wind3];
        NSString *wind4 = dic[@"HeWeather5"][0][@"daily_forecast"][date][@"wind"][@"deg"];
        self.wind4 = [NSString stringWithFormat:@"风向：%@", wind4];
        NSString *aqi = dic[@"HeWeather5"][0][@"aqi"][@"city"][@"aqi"];
        NSString *qlty = dic[@"HeWeather5"][0][@"aqi"][@"city"][@"qlty"];
        self.airGrade = [NSString stringWithFormat:@"%@  %@", aqi, qlty];
        NSString *pm25 = dic[@"HeWeather5"][0][@"aqi"][@"city"][@"pm25"];
        self.pm25 = [pm25 stringByAppendingString:@" ug/m³"];
        NSString *NO2 = dic[@"HeWeather5"][0][@"aqi"][@"city"][@"no2"];
        self.NO2 = [NO2 stringByAppendingString:@" ug/m³"];
        NSString *pm10 = dic[@"HeWeather5"][0][@"aqi"][@"city"][@"pm10"];
        self.pm10 = [pm10 stringByAppendingString:@" ug/m³"];
        NSString *CO = dic[@"HeWeather5"][0][@"aqi"][@"city"][@"co"];
        self.CO = [CO stringByAppendingString:@" ug/m³"];
        NSString *O3 = dic[@"HeWeather5"][0][@"aqi"][@"city"][@"o3"];
        self.O3 = [O3 stringByAppendingString:@" ug/m³"];
        NSString *so2 = dic[@"HeWeather5"][0][@"aqi"][@"city"][@"so2"];
        self.SO2 = [so2 stringByAppendingString:@" ug/m³"];
    }
    
    return self;
}

@end
