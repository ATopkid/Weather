//
//  LXDetailViewController.h
//  iWeather
//
//  Created by helloworld on 2017/8/21.
//  Copyright © 2017年 topkid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIView *contentSize;

- (instancetype) initWithWeatherStr:(NSString *)str andCityStr:(NSString *)city date:(NSInteger)date;
@end
