//
//  LXWeatherForecastModel.h
//  iWeather
//
//  Created by helloworld on 2017/8/20.
//  Copyright © 2017年 topkid. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXWeatherForecastModel : NSObject

@property (strong, nonatomic) NSMutableDictionary *todayDic;
@property (strong, nonatomic) NSMutableDictionary *tomorrowDic;
@property (strong, nonatomic) NSMutableDictionary *theDayAfterTomorrowDic;
@property (strong, nonatomic) NSMutableDictionary *today_now_Dic;
@property (strong, nonatomic) NSMutableDictionary *AQIDic;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
