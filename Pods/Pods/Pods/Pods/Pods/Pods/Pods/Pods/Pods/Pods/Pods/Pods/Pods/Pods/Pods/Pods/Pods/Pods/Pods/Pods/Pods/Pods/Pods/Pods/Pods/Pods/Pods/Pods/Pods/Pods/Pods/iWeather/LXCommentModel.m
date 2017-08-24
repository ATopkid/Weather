//
//  LXModel.m
//  iWeather
//
//  Created by helloworld on 2017/8/20.
//  Copyright © 2017年 topkid. All rights reserved.
//

#import "LXCommentModel.h"

@implementation LXCommentModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    
    if (self) {
        self.sports = [NSString stringWithFormat:@"%@", dic[@"sport"][@"brf"]];
        self.clothes = [NSString stringWithFormat:@"%@", dic[@"drsg"][@"brf"]];
        self.washCar = [NSString stringWithFormat:@"%@", dic[@"cw"][@"brf"]];
        self.flu = [NSString stringWithFormat:@"%@", dic[@"flu"][@"brf"]];
        self.travel = [NSString stringWithFormat:@"%@", dic[@"trav"][@"brf"]];
        self.UV = [NSString stringWithFormat:@"%@", dic[@"uv"][@"brf"]];
    }
    
    return self;
}

@end
