//
//  LXCommentDetailView.m
//  iWeather
//
//  Created by helloworld on 2017/8/19.
//  Copyright © 2017年 topkid. All rights reserved.
//

#import "LXCommentDetailView.h"

@implementation LXCommentDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:nil options:nil].firstObject;
        [self setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height)];
        self.backgroundColor = [UIColor clearColor];
        self.myLabel1.textColor = [UIColor whiteColor];
        self.myLabel2.textColor = [UIColor whiteColor];
        self.whiteView.layer.cornerRadius = 3;
        self.myImageView.backgroundColor = [UIColor clearColor];
        [self.whiteView.layer masksToBounds];
        self.myLabel1.font = self.myLabel2.font = [UIFont systemFontOfSize:14];
    }
    
    return self;
}

@end
