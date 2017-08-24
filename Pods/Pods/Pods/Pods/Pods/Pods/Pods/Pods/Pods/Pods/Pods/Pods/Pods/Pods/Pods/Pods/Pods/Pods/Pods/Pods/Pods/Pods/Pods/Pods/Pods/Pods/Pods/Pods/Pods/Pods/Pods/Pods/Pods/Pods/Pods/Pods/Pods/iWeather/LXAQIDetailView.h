//
//  LXAQIDetailView.h
//  iWeather
//
//  Created by helloworld on 2017/8/21.
//  Copyright © 2017年 topkid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXAQIDetailView : UIView
@property (weak, nonatomic) IBOutlet UILabel *pm25Label;
@property (weak, nonatomic) IBOutlet UILabel *coLabel;
@property (weak, nonatomic) IBOutlet UILabel *no2Label;
@property (weak, nonatomic) IBOutlet UILabel *o3Label;
@property (weak, nonatomic) IBOutlet UILabel *pm10Label;
@property (weak, nonatomic) IBOutlet UILabel *so2Label;

- (instancetype)init;

@end
