//
//  LXHomePagePictureView.m
//  iWeather
//
//  Created by helloworld on 2017/8/19.
//  Copyright © 2017年 topkid. All rights reserved.
//

#import "LXHomePagePictureView.h"
#import "LXHorizontalPickerView.h"

#define kHEIGHT [UIScreen mainScreen].bounds.size.height
#define kWIDTH [UIScreen mainScreen].bounds.size.width

@implementation LXHomePagePictureView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        if (self) {
            self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:self options:nil] lastObject];
            [self setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
            
            self.tmpLabel.backgroundColor = [UIColor clearColor];
            self.tmpLabel.font = [UIFont systemFontOfSize:80];
            self.tmpLabel.textAlignment = NSTextAlignmentRight;
            self.tmpLabel.textColor = [UIColor whiteColor];
            
            self.AQILabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.35];
            self.AQILabel.textColor = [UIColor whiteColor];
            self.AQILabel.text = @"空气指数⇩";
            self.AQILabel.font = [UIFont systemFontOfSize:12];
            self.AQILabel.layer.cornerRadius =4;
            self.AQILabel.clipsToBounds = YES;
            self.AQILabel.textAlignment = NSTextAlignmentCenter;
            self.AQILabel.userInteractionEnabled = YES;
        }
    }
    return self;
}

@end
