//
//  LXModel.h
//  iWeather
//
//  Created by helloworld on 2017/8/20.
//  Copyright © 2017年 topkid. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXCommentModel : NSObject

@property (strong, nonatomic) NSString *sports;
@property (strong, nonatomic) NSString *clothes;
@property (strong, nonatomic) NSString *washCar;
@property (strong, nonatomic) NSString *flu;
@property (strong, nonatomic) NSString *travel;
@property (strong, nonatomic) NSString *UV;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
