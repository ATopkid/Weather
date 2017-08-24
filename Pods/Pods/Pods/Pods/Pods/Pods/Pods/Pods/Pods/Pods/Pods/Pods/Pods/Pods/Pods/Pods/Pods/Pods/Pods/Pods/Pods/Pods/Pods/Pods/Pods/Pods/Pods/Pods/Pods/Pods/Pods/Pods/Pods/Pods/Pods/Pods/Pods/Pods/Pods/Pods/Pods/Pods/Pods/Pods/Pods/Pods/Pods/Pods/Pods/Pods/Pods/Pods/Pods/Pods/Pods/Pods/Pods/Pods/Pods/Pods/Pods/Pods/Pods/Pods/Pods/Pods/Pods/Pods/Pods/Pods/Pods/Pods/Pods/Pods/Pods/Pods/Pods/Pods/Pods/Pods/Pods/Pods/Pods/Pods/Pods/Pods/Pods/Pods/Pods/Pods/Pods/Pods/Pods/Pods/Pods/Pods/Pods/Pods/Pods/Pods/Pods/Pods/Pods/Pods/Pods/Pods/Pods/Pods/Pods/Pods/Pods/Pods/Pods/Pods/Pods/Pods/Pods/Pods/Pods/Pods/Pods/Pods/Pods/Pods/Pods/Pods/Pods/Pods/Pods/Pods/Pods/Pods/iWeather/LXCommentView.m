//
//  LXCommentView.m
//  iWeather
//
//  Created by helloworld on 2017/8/19.
//  Copyright © 2017年 topkid. All rights reserved.
//

#import "LXCommentView.h"
#import <Masonry.h>
#import "LXCommentDetailView.h"

@implementation LXCommentView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    double width = frame.size.width;
    double height = frame.size.height;
    
    if (self) {
        self.detailView1 = [[LXCommentDetailView alloc] initWithFrame:CGRectMake(0, 0, width/2.0, height/3.0)];
        self.detailView2 = [[LXCommentDetailView alloc] initWithFrame:CGRectMake(width/2, 0, width/2.0, height/3.0)];
        self.detailView3 = [[LXCommentDetailView alloc] initWithFrame:CGRectMake(0, height/3.0, width/2.0, height/3.0)];
        self.detailView4 = [[LXCommentDetailView alloc] initWithFrame:CGRectMake(width/2, height/3.0, width/2.0, height/3.0)];
        self.detailView5 = [[LXCommentDetailView alloc] initWithFrame:CGRectMake(0, height * 2.0 /3.0, width/2.0, height/3.0)];
        self.detailView6 = [[LXCommentDetailView alloc] initWithFrame:CGRectMake(width/2, height * 2.0/3.0, width/2.0, height/3.0)];
        [self addSubview:self.detailView1];
        [self addSubview:self.detailView2];
        [self addSubview:self.detailView3];
        [self addSubview:self.detailView4];
        [self addSubview:self.detailView5];
        [self addSubview:self.detailView6];
        self.backgroundColor = [UIColor clearColor];
        self.detailView2.whiteView.hidden = self.detailView4.whiteView.hidden = self.detailView6.whiteView.hidden = YES;
        self.layer.cornerRadius = 6;
        
        self.detailView1.myLabel1.text = @"运动";
        self.detailView2.myLabel1.text = @"穿衣";
        self.detailView3.myLabel1.text = @"洗车";
        self.detailView4.myLabel1.text = @"感冒";
        self.detailView5.myLabel1.text = @"旅游";
        self.detailView6.myLabel1.text = @"紫外线";
        
        self.detailView1.myImageView.contentMode = self.detailView1.myImageView.contentMode = self.detailView1.myImageView.contentMode = self.detailView1.myImageView.contentMode = self.detailView1.myImageView.contentMode = self.detailView1.myImageView.contentMode = UIViewContentModeScaleToFill;
        
        self.detailView1.myImageView.image = [UIImage imageNamed:@"sports"];
        self.detailView2.myImageView.image = [UIImage imageNamed:@"clothes"];
        self.detailView3.myImageView.image = [UIImage imageNamed:@"washcar"];
        self.detailView4.myImageView.image = [UIImage imageNamed:@"pill"];
        self.detailView5.myImageView.image = [UIImage imageNamed:@"trunk"];
        self.detailView6.myImageView.image = [UIImage imageNamed:@"UV"];
        
    }
    
    return self;
}

@end
