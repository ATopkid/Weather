//
//  LXAQIDetailView.m
//  iWeather
//
//  Created by helloworld on 2017/8/21.
//  Copyright © 2017年 topkid. All rights reserved.
//

#import "LXAQIDetailView.h"

@implementation LXAQIDetailView

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:nil options:nil] lastObject];
        self.layer.cornerRadius = 4;
        self.clipsToBounds = YES;
    }
    
    return self;
}

@end
