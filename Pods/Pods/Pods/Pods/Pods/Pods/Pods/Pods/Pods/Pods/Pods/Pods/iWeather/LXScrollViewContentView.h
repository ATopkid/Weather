//
//  LXScrollViewContentView.h
//  iWeather
//
//  Created by helloworld on 2017/8/21.
//  Copyright © 2017年 topkid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXScrollViewContentView : UIView
@property (weak, nonatomic) IBOutlet UILabel *rainfallRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *daytimeWeatherLabel;
@property (weak, nonatomic) IBOutlet UILabel *nightWeatherLabel;
@property (weak, nonatomic) IBOutlet UILabel *minToMaxTmpLabel;
@property (weak, nonatomic) IBOutlet UILabel *sunupTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *sundownTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *humidityLabel;
@property (weak, nonatomic) IBOutlet UILabel *pcpnLabel;
@property (weak, nonatomic) IBOutlet UILabel *airPressureLabel;
@property (weak, nonatomic) IBOutlet UILabel *windLabel1;
@property (weak, nonatomic) IBOutlet UILabel *windLabel2;
@property (weak, nonatomic) IBOutlet UILabel *windLabel3;
@property (weak, nonatomic) IBOutlet UILabel *windLabel4;
@property (weak, nonatomic) IBOutlet UILabel *airGradeLabel;
@property (weak, nonatomic) IBOutlet UILabel *pm25Label;
@property (weak, nonatomic) IBOutlet UILabel *NO2Label;
@property (weak, nonatomic) IBOutlet UILabel *pm10Label;
@property (weak, nonatomic) IBOutlet UILabel *COLabel;
@property (weak, nonatomic) IBOutlet UILabel *O3Label;
@property (weak, nonatomic) IBOutlet UILabel *SO2Label;
@property (weak, nonatomic) IBOutlet UIImageView *windMillImageView;
@property (weak, nonatomic) IBOutlet UIImageView *daytimeImageView;
@property (weak, nonatomic) IBOutlet UIImageView *nightImageView;
@property (weak, nonatomic) IBOutlet UIView *AQIView;

@end
