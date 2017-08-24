//
//  LXDeatilViewControllerModel.h
//  iWeather
//
//  Created by helloworld on 2017/8/22.
//  Copyright © 2017年 topkid. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXDeatilViewControllerModel : NSObject

- (instancetype)initWithDic:(NSDictionary *)dic andDate:(NSInteger)date;

@property (strong, nonatomic)NSString *rainfallRate;
@property (strong, nonatomic)NSString *daytimeWeather;
@property (strong, nonatomic)NSString *nightWeather;
@property (strong, nonatomic)NSString *minToMaxTmp;
@property (strong, nonatomic)NSString *sunupTime;
@property (strong, nonatomic)NSString *sundownTime;
@property (strong, nonatomic)NSString *humidity;
@property (strong, nonatomic)NSString *pcpn;
@property (strong, nonatomic)NSString *airPressure;
@property (strong, nonatomic)NSString *wind1;
@property (strong, nonatomic)NSString *wind2;
@property (strong, nonatomic)NSString *wind3;
@property (strong, nonatomic)NSString *wind4;
@property (strong, nonatomic)NSString *airGrade;
@property (strong, nonatomic)NSString *pm25;
@property (strong, nonatomic)NSString *NO2;
@property (strong, nonatomic)NSString *pm10;
@property (strong, nonatomic)NSString *CO;
@property (strong, nonatomic)NSString *O3;
@property (strong, nonatomic)NSString *SO2;

@end
