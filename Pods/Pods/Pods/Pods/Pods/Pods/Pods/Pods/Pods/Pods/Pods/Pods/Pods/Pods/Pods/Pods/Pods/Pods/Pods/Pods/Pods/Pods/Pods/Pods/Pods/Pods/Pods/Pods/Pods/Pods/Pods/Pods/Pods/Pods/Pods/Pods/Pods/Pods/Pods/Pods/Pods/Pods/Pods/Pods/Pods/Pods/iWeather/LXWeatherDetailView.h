//
//  LXWeatherDetailView.h
//  iWeather
//
//  Created by helloworld on 2017/8/19.
//  Copyright © 2017年 topkid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXWeatherDetailView : UIView

//@property (strong, nonatomic) UILabel *timeLabel;
//@property (strong, nonatomic) UILabel *weatherLabel;
//@property (strong, nonatomic) UILabel *temperatureLabel;
//@property (strong, nonatomic) UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UILabel *weatherLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;


@end
