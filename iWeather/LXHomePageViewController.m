//
//  LXHomePageViewController.m
//  iWeather
//
//  Created by helloworld on 2017/8/19.
//  Copyright © 2017年 topkid. All rights reserved.
//

#import "LXHomePageViewController.h"
#import "LXHomePagePictureView.h"
#import "LXHorizontalPickerView.h"
#import "LXCommentView.h"
#import "LXCommentDetailView.h"
#import "LXWeatherDetailView.h"
#import <AFHTTPSessionManager.h>
#import <Masonry.h>
#import "LXCommentModel.h"
#import "LXWeatherForecastModel.h"
#import "LXAQIDetailView.h"
#import "LXDetailViewController.h"
#import "LXNavRightBtnViewController.h"

#define kHEIGHT [UIScreen mainScreen].bounds.size.height
#define kWIDTH [UIScreen mainScreen].bounds.size.width
#define urlStr @"https://free-api.heweather.com/v5/weather"
#define key @"0e670ef84be04f6fbddbe1ce133403d5"

#define SUNCOLOR1 [UIColor colorWithRed:43/255.0 green:25/255.0 blue:5/255.0 alpha:1.0]
#define CLOUDCOLOR1 [UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1.0]
#define RAINCOLOR1 [UIColor colorWithRed:4/255.0 green:33/255.0 blue:52/255.0 alpha:1.0]

#define SUNCOLOR2 [UIColor colorWithRed:67/255.0 green:39/255.0 blue:3/255.0 alpha:1.0]
#define CLOUDCOLOR2 [UIColor colorWithRed:89/255.0 green:89/255.0 blue:89/255.0 alpha:1.0]
#define RAINCOLOR2 [UIColor colorWithRed:8/255.0 green:46/255.0 blue:73/255.0 alpha:1.0]

@interface LXHomePageViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *rootScrollView;
@property (strong, nonatomic) UITableView *leftDrawerTableView;
@property (strong, nonatomic) LXCommentModel *commentModel;
@property (strong, nonatomic) LXWeatherForecastModel *weatherForecastModel;
@property (strong, nonatomic) LXHorizontalPickerView *weatherScrollView;
@property (strong, nonatomic) LXHomePagePictureView *homePageView;
@property (strong, nonatomic) LXCommentView *commentView;
@property (nonatomic) BOOL didOpenDrawer;
@property (nonatomic) NSString *didSelectCityStr;
@property (strong, nonatomic) NSMutableArray *allDidSelectCityArray;

@end

@implementation LXHomePageViewController

/*
 tag:
    detailView:0-9
    AQIDetailView:10
    leftDrawerTableView:11;
**/

- (void)viewDidLoad {
    [super viewDidLoad];

    self.allDidSelectCityArray = [[NSMutableArray alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshData:) name:@"refreshData" object:nil];
    [self getDataWithCityStr:self.didSelectCityStr];
}

//接收通知
- (void)refreshData:(NSNotification *)object {
    NSString *str = [object object];

    [self getDataWithCityStr:str];
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.didSelectCityStr = @"重庆";
    }
    
    return self;
}

#pragma mark - 网络请求
- (void)getDataWithCityStr:(NSString *)city {
    BOOL isNewCity = YES;
    for (int i = 0; i < self.allDidSelectCityArray.count; i++) {
        if ([city isEqualToString:self.allDidSelectCityArray[i]]) {
            isNewCity = NO;
        }
    }
    if (isNewCity) {
        [self.allDidSelectCityArray addObject:city];
    }
    self.title = city;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    NSDictionary *parameters = @{
                                 @"city":city,
                                 @"key":key
                                 };
    
    [manager GET:urlStr parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        self.commentModel = [[LXCommentModel alloc] initWithDic:responseObject[@"HeWeather5"][0][@"suggestion"]];
        self.weatherForecastModel = [[LXWeatherForecastModel alloc] initWithDic:responseObject];
        [self layoutLeftDrawerView];
        [self layoutView];
        [self.leftDrawerTableView reloadData];
//        [self.leftDrawerTableView setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, 250, self.view.frame.size.height)];
//        NSLog(@"===%lf %lf", self.leftDrawerTableView.frame.origin.x, self.leftDrawerTableView.frame.origin.y);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error when download:%@",error);
    }];
}

#pragma mark - 抽屉
- (void)layoutLeftDrawerView {
    [self.view addSubview:self.leftDrawerTableView];
}

- (UITableView *)leftDrawerTableView {
    if (!_leftDrawerTableView) {
        _leftDrawerTableView.tag = 11;
        _leftDrawerTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 250, kHEIGHT) style:UITableViewStylePlain];
        _leftDrawerTableView.delegate = self;
        _leftDrawerTableView.dataSource = self;
//        _leftDrawerTableView.bounces = NO;
        _leftDrawerTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _leftDrawerTableView.backgroundColor = [UIColor colorWithRed:47/255.0 green:47/255.0 blue:47/255.0 alpha:1];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 250, 44)];
        view.backgroundColor = [UIColor colorWithRed:47/255.0 green:47/255.0 blue:47/255.0 alpha:1];
        _leftDrawerTableView.tableHeaderView = view;
    }
    
    return _leftDrawerTableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allDidSelectCityArray.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LeftDrawerTableViewCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LeftDrawerTableViewCell"];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor colorWithRed:47/255.0 green:47/255.0 blue:47/255.0 alpha:1];
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"已选择城市";
        cell.userInteractionEnabled = NO;
    } else {
        cell.textLabel.text = self.allDidSelectCityArray[indexPath.row - 1];
        cell.userInteractionEnabled = YES;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self getDataWithCityStr:self.allDidSelectCityArray[indexPath.row -1]];
    [self closeDrawerWithNothing];
}

#pragma mark - 主页
- (void)layoutView {
/*
导航栏标题颜色
 **/
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
/*
根UIScrollView
 **/
    self.rootScrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    self.rootScrollView.showsVerticalScrollIndicator = NO;
    self.rootScrollView.showsHorizontalScrollIndicator = NO;
    self.rootScrollView.contentSize = CGSizeMake(kWIDTH, 880);
    [self.view addSubview:self.rootScrollView];

/*
 背景图
**/
    CGRect imageViewFrame = CGRectMake(0, 0, kWIDTH, 3/5.0 * kHEIGHT);
    self.homePageView = [[LXHomePagePictureView alloc] initWithFrame:imageViewFrame];
    [self.rootScrollView addSubview:self.homePageView];
    NSString *nowWeatherStr = self.weatherForecastModel.today_now_Dic[@"cond"][@"txt"];
    
    LXAQIDetailView *aqiDetailView = [[LXAQIDetailView alloc] init];
    [self.rootScrollView addSubview:aqiDetailView];
    aqiDetailView.hidden = YES;
    aqiDetailView.tag = 10;
    [aqiDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.homePageView.AQILabel.mas_right).offset(0);
        make.left.equalTo(self.homePageView.AQILabel.mas_left).offset(-35);
        make.top.equalTo(self.homePageView.AQILabel.mas_bottom).offset(10);
        make.height.mas_equalTo(100);
    }];
    if (self.weatherForecastModel) {
        self.homePageView.tmpLabel.text = self.weatherForecastModel.today_now_Dic[@"tmp"];
        if (self.weatherForecastModel.AQIDic[@"pm25"]) {
            aqiDetailView.pm25Label.text = self.weatherForecastModel.AQIDic[@"pm25"];
        }
        if (self.weatherForecastModel.AQIDic[@"co"]) {
            aqiDetailView.coLabel.text = self.weatherForecastModel.AQIDic[@"co"];
        }
        if (self.weatherForecastModel.AQIDic[@"no2"]) {
            aqiDetailView.no2Label.text = self.weatherForecastModel.AQIDic[@"no2"];
        }
        if (self.weatherForecastModel.AQIDic[@"o3"]) {
            aqiDetailView.o3Label.text = self.weatherForecastModel.AQIDic[@"o3"];
        }
        if (self.weatherForecastModel.AQIDic[@"pm10"]) {
            aqiDetailView.pm10Label.text = self.weatherForecastModel.AQIDic[@"pm10"];
        }
        if (self.weatherForecastModel.AQIDic[@"so2"]) {
            aqiDetailView.so2Label.text = self.weatherForecastModel.AQIDic[@"so2"];
        }
    }
    
//添加手势
    UITapGestureRecognizer *tapAQIView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAQIView)];
    [self.homePageView.AQILabel addGestureRecognizer:tapAQIView];

/*
横向日期选择器
**/
    double pickerViewHeight = 175;
    CGRect pickerViewFrame = CGRectMake(0, imageViewFrame.size.height, kWIDTH, pickerViewHeight);
    LXHorizontalPickerView *weatherScrollView = [[LXHorizontalPickerView alloc] initWithFrame:pickerViewFrame];
    weatherScrollView.delegate = self;
    weatherScrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
    for (int i = 0; i < 10; i++) {
        LXWeatherDetailView *detailView = [[LXWeatherDetailView alloc] initWithFrame:CGRectMake(i * kWIDTH/4.0, 0, kWIDTH/4.0, pickerViewHeight)];
        detailView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapDetailView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetailView:)];
        [detailView addGestureRecognizer:tapDetailView];
        detailView.tag = i;
        self.weatherScrollView = weatherScrollView;
        [weatherScrollView addSubview:detailView];
        weatherScrollView.backgroundColor = [UIColor clearColor];
        detailView.contentMode = UIViewContentModeScaleAspectFit;

        
        if (self.weatherForecastModel) {
            if (detailView.tag == 1 || detailView.tag == 4 || detailView.tag == 7) {
                NSDictionary *dic = self.weatherForecastModel.tomorrowDic;
                NSString *timeStr = dic[@"date"];
                timeStr = [timeStr substringFromIndex:5];
                detailView.timeLabel.text = timeStr;
                detailView.weatherLabel.text = dic[@"cond"][@"txt_d"];
                int maxTmp = [dic[@"tmp"][@"max"] intValue];
                int minTmp = [dic[@"tmp"][@"min"] intValue];
                detailView.temperatureLabel.text = [NSString stringWithFormat:@"%d℃/%d℃", minTmp, maxTmp];
                
                NSString *weatherStr = detailView.weatherLabel.text;
                detailView.myImageView.image = [UIImage imageNamed:weatherStr];
            } else if (detailView.tag == 2 || detailView.tag == 5 || detailView.tag == 8) {
                NSDictionary *dic = self.weatherForecastModel.theDayAfterTomorrowDic;
                NSString *timeStr = dic[@"date"];
                timeStr = [timeStr substringFromIndex:5];
                detailView.timeLabel.text = timeStr;
                detailView.weatherLabel.text = dic[@"cond"][@"txt_d"];
                int maxTmp = [dic[@"tmp"][@"max"] intValue];
                int minTmp = [dic[@"tmp"][@"min"] intValue];
                detailView.temperatureLabel.text = [NSString stringWithFormat:@"%d℃/%d℃", minTmp, maxTmp];
                
                NSString *weatherStr = detailView.weatherLabel.text;
                detailView.myImageView.image = [UIImage imageNamed:weatherStr];
            } else if (detailView.tag == 0 || detailView.tag == 3 || detailView.tag == 6 || detailView.tag == 9) {
                detailView.timeLabel.text = @"今天";
                detailView.weatherLabel.text = self.weatherForecastModel.today_now_Dic[@"cond"][@"txt"];
                int maxTmp = [self.weatherForecastModel.todayDic[@"tmp"][@"max"] intValue];
                int minTmp = [self.weatherForecastModel.todayDic[@"tmp"][@"min"] intValue];
                detailView.temperatureLabel.text = [NSString stringWithFormat:@"%d℃/%d℃", minTmp, maxTmp];
                
                NSString *weatherStr = detailView.weatherLabel.text;
                detailView.myImageView.image = [UIImage imageNamed:weatherStr];
            }
        }
        
        
    }
//初始位置
    [weatherScrollView setContentOffset:CGPointMake(kWIDTH/4.0 * 3/2.0, 0)];
    [self.rootScrollView addSubview:weatherScrollView];
    
/*
底部评论
**/
    CGRect commentViewFrame = CGRectMake(20, pickerViewFrame.origin.y + pickerViewFrame.size.height, kWIDTH-40, 0.8/2 * kHEIGHT);
    self.commentView = [[LXCommentView alloc] initWithFrame:commentViewFrame];
    [self.rootScrollView addSubview:self.commentView];
    if (self.commentModel) {
        self.commentView.detailView1.myLabel2.text = self.commentModel.sports;
        self.commentView.detailView2.myLabel2.text = self.commentModel.clothes;
        self.commentView.detailView3.myLabel2.text = self.commentModel.washCar;
        self.commentView.detailView4.myLabel2.text = self.commentModel.flu;
        self.commentView.detailView5.myLabel2.text = self.commentModel.travel;
        self.commentView.detailView6.myLabel2.text = self.commentModel.UV;
    }
    
/*
更换套图及背景颜色
**/
    if ([nowWeatherStr isEqualToString:@"晴"]) {
        self.homePageView.myImageView.image = [UIImage imageNamed:@"bg_sun"];
        self.rootScrollView.backgroundColor = SUNCOLOR1;
        self.commentView.backgroundColor = SUNCOLOR2;
    } else if ([nowWeatherStr isEqualToString:@"多云"] || [nowWeatherStr isEqualToString:@"阴"]) {
        self.homePageView.myImageView.image = [UIImage imageNamed:@"bg_cloud"];
        self.rootScrollView.backgroundColor = CLOUDCOLOR1;
        self.commentView.backgroundColor = CLOUDCOLOR2;
    } else if ([nowWeatherStr containsString:@"雨"]){
        self.homePageView.myImageView.image = [UIImage imageNamed:@"bg_rain"];
        self.rootScrollView.backgroundColor = RAINCOLOR1;
        self.commentView.backgroundColor = RAINCOLOR2;
    }
}

- (void)tapAQIView {
    LXAQIDetailView *aqiDetailView = [self.rootScrollView viewWithTag:10];
    if (aqiDetailView.hidden == YES) {
        aqiDetailView.hidden = NO;
    } else {
        aqiDetailView.hidden = YES;
    }
}

- (void)tapDetailView:(UIGestureRecognizer *)sender {
    NSInteger tag = sender.view.tag;
    if (tag == 1 || tag == 4 || tag == 7) {
        [self.navigationController pushViewController:[[LXDetailViewController alloc] initWithWeatherStr:self.weatherForecastModel.tomorrowDic[@"cond"][@"txt_d"] andCityStr:@"chongqing" date:1] animated:YES];
    } else if (tag == 2 || tag == 5 || tag == 8) {
        [self.navigationController pushViewController:[[LXDetailViewController alloc] initWithWeatherStr:self.weatherForecastModel.theDayAfterTomorrowDic[@"cond"][@"txt_d"] andCityStr:@"chongqing" date:2] animated:YES];
    } else if (tag == 0 || tag == 3 || tag == 6 || tag == 9) {
        [self.navigationController pushViewController:[[LXDetailViewController alloc] initWithWeatherStr:self.weatherForecastModel.today_now_Dic[@"cond"][@"txt"] andCityStr:@"chongqing" date:0] animated:YES];
    }
}

#pragma mark - 导航栏
////怎么修改导航栏颜色?
- (void)viewWillAppear:(BOOL)animated {
//    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
//    self.navigationController.navigationBar.translucent = NO;
//    self.navigationController.navigationBar.alpha = 0.3;
    
//    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:nil];
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];

    
//    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(openDrawer)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [button setImage:[UIImage imageNamed:@"三横"] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 25, 25);
    // 让按钮内部的所有内容左对齐
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [button addTarget:self action:@selector(openDrawer) forControlEvents:UIControlEventTouchUpInside];
    // 修改导航栏左边的item
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(tapNavRightBtn)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
//    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"三个横"] style:UIBarButtonItemStylePlain target:self action:@selector(openDrawer)];
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//    self.navigationItem.leftBarButtonItem = leftBtn;
//    self.navigationItem.leftBarButtonItem.image = [UIImage imageNamed:@"三个横"];
}

- (void)tapNavRightBtn {
    [self.navigationController pushViewController:[[LXNavRightBtnViewController alloc] init] animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.navigationItem.backBarButtonItem = item;
}

- (void)openDrawer {
    self.didOpenDrawer = YES;
    self.navigationController.navigationBar.hidden = YES;
    [UIView beginAnimations:@"animate" context:nil];
    [UIView setAnimationDuration:0.3];
    [self.rootScrollView setFrame:CGRectMake(self.view.frame.origin.x + 250, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height)];
    [self.navigationController.navigationBar setFrame:CGRectMake(self.view.frame.origin.x + 250, 0, kWIDTH, 64)];
//    [self.leftDrawerTableView setFrame:CGRectMake(0, self.view.frame.origin.y, 250, self.view.frame.size.height)];
    [UIView commitAnimations];
    UITapGestureRecognizer *tapToBackGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeDrawerWithNothing)];
    self.rootScrollView.userInteractionEnabled = YES;
    [self.rootScrollView addGestureRecognizer:tapToBackGesture];
}

- (void)closeDrawerWithNothing {
    self.didOpenDrawer = NO;
    self.navigationController.navigationBar.hidden = NO;
    [UIView beginAnimations:@"back" context:nil];
    [UIView setAnimationDuration:0.3];
    [self.rootScrollView setFrame:self.view.frame];
    [self.navigationController.navigationBar setFrame:CGRectMake(self.view.frame.origin.x, 0, kWIDTH, 64)];
    [UIView commitAnimations];
}

#pragma mark - UIScrollView代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_didOpenDrawer == YES) {
        return;
    }
    
    if (scrollView.contentOffset.x >= 6 * kWIDTH/4.0) {
        scrollView.contentOffset = CGPointMake(3 * kWIDTH/4.0, 0);
    }
    if (scrollView.contentOffset.x <= kWIDTH/4.0) {
        scrollView.contentOffset = CGPointMake(kWIDTH, 0);
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (_didOpenDrawer == YES) {
        return;
    }
    double end = scrollView.contentOffset.x;
    double sum = 0;
    int count = 0;
    for (int i = 0; sum < end; i++) {
        sum = kWIDTH/4.0 * i + kWIDTH/8.0;
        count++;
    }
    sum = sum - kWIDTH/8;
    if (end > sum) {
        end = sum + kWIDTH/8.0;
    } else {
        end = sum - kWIDTH/8.0;
    }
    
    [scrollView setContentOffset:CGPointMake(end, 0) animated:YES];
    
    for (int i = 0; i < 10; i++) {
        LXWeatherDetailView *view = [self.weatherScrollView viewWithTag:i];
        if (view.frame.origin.x > (count) * kWIDTH/4.0  + kWIDTH/8.0 && view.frame.origin.x < (count+1)*kWIDTH/4.0 + kWIDTH/8.0) {
//            view.timeLabel.text = [NSString stringWithFormat:@"%d", i];
            view.userInteractionEnabled = YES;
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (_didOpenDrawer == YES) {
        return;
    }
    double end = scrollView.contentOffset.x;
    double sum = 0;
    for (int i = 0; sum < end; i++) {
        sum = kWIDTH/4.0 * i + kWIDTH/8.0;
    }
    sum = sum - kWIDTH/8;
    if (end > sum) {
        end = sum + kWIDTH/8.0;
    } else {
        end = sum - kWIDTH/8.0;
    }
    
    [scrollView setContentOffset:CGPointMake(end, 0) animated:YES];
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
