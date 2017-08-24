//
//  LXDetailViewController.m
//  iWeather
//
//  Created by helloworld on 2017/8/21.
//  Copyright © 2017年 topkid. All rights reserved.
//

#import "LXDetailViewController.h"
#import "LXScrollViewContentView.h"
#import <AFNetworking.h>
#import "LXDeatilViewControllerModel.h"

#define kHEIGHT [UIScreen mainScreen].bounds.size.height
#define kWIDTH [UIScreen mainScreen].bounds.size.width
#define urlStr @"https://free-api.heweather.com/v5/weather"
#define key @"0e670ef84be04f6fbddbe1ce133403d5"

@interface LXDetailViewController ()

@property (strong, nonatomic)LXDeatilViewControllerModel *model;
@property (strong, nonatomic) LXScrollViewContentView *scrollViewContView;

@end

@implementation LXDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (instancetype)initWithWeatherStr:(NSString *)str andCityStr:(NSString *)city date:(NSInteger)date{
    self = [super init];
    
    if (self) {
        [self.view bringSubviewToFront:self.scrollView];
        self.scrollViewContView = [[LXScrollViewContentView alloc] init];
        [self.scrollView addSubview:self.scrollViewContView];
        self.scrollView.contentSize = CGSizeMake(kWIDTH, 1000);
        if (date == 1 || date == 2) {
            self.scrollViewContView.AQIView.hidden = YES;
            self.scrollView.contentSize = CGSizeMake(kWIDTH, 750);
        }
        
        if ([str isEqualToString:@"晴"]) {
            self.backgroundImage.image = [UIImage imageNamed:@"bg_sun_big"];
        } else if ([str isEqualToString:@"多云"] || [str isEqualToString:@"阴"]) {
            self.backgroundImage.image = [UIImage imageNamed:@"bg_cloud_big"];
        } else if ([str containsString:@"雨"]) {
            self.backgroundImage.image = [UIImage imageNamed:@"bg_rain_big"];
        }
        [self getDataWithCity:city date:date];
    }
    
    return self;
}

#pragma mark - 网络请求
- (void)getDataWithCity:(NSString *)city date:(NSInteger)date{
/*
 date: 0-doday
       1-tomorrow
       2-theDayAfterTomorrow
 **/
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSDictionary *parameters = @{
                                 @"city":city,
                                 @"key":key
                                 };
    
    [manager GET:urlStr parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        self.model = [[LXDeatilViewControllerModel alloc] initWithDic:responseObject andDate:date];
        [self refreshUI];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败,error:%@", error);
    }];
}

- (void)refreshUI {
    self.scrollViewContView.rainfallRateLabel.text = self.model.rainfallRate;
    self.scrollViewContView.daytimeWeatherLabel.text = self.model.daytimeWeather;
    self.scrollViewContView.nightWeatherLabel.text = self.model.nightWeather;
    self.scrollViewContView.minToMaxTmpLabel.text = self.model.minToMaxTmp;
    self.scrollViewContView.sunupTimeLabel.text = self.model.sunupTime;
    self.scrollViewContView.sundownTimeLabel.text = self.model.sundownTime;
    self.scrollViewContView.humidityLabel.text = self.model.humidity;
    self.scrollViewContView.pcpnLabel.text = self.model.pcpn;
    self.scrollViewContView.airPressureLabel.text = self.model.airPressure;
    self.scrollViewContView.windLabel1.text = self.model.wind1;
    self.scrollViewContView.windLabel2.text = self.model.wind2;
    self.scrollViewContView.windLabel3.text = self.model.wind3;
    self.scrollViewContView.windLabel4.text = self.model.wind4;
    self.scrollViewContView.airGradeLabel.text = self.model.airGrade;
    self.scrollViewContView.pm25Label.text = self.model.pm25;
    self.scrollViewContView.NO2Label.text = self.model.NO2;
    self.scrollViewContView.pm10Label.text = self.model.pm10;
    self.scrollViewContView.COLabel.text = self.model.CO;
    self.scrollViewContView.O3Label.text = self.model.O3;
    self.scrollViewContView.SO2Label.text = self.model.SO2;
    self.scrollViewContView.daytimeImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", self.model.daytimeWeather]];
    self.scrollViewContView.nightImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", self.model.nightWeather]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
