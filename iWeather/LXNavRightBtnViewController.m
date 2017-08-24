//
//  LXNavRightBtnViewController.m
//  iWeather
//
//  Created by helloworld on 2017/8/23.
//  Copyright © 2017年 topkid. All rights reserved.
//

#import "LXNavRightBtnViewController.h"
#import <Masonry.h>
#import "LXHomePagePictureView.h"
#import <AFNetworking.h>

#define kHEIGHT [UIScreen mainScreen].bounds.size.height
#define kWIDTH [UIScreen mainScreen].bounds.size.width
#define urlStr @"https://free-api.heweather.com/v5/weather"
#define key @"0e670ef84be04f6fbddbe1ce133403d5"

@interface LXNavRightBtnViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *cityArray;
@property (strong, nonatomic) NSMutableArray *allCity;
@property (strong, nonatomic) UIView *coverView;
@property (strong, nonatomic) UILabel *coverViewsLabel;

@end

@implementation LXNavRightBtnViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

- (void)setUI {
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:47/255.0 green:47/255.0 blue:47/255.0 alpha:1];
    self.title = @"添加城市";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    
    UIView *statusBarView = [[UIView alloc]   initWithFrame:CGRectMake(0, -20, self.view.bounds.size.width, 20)];
    statusBarView.backgroundColor = [UIColor colorWithRed:47/255.0 green:47/255.0 blue:47/255.0 alpha:1];
    [self.navigationController.navigationBar addSubview:statusBarView];

    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    self.cityArray = @[@"北京", @"上海", @"广州", @"深圳", @"杭州", @"南京", @"成都", @"重庆", @"西安", @"厦门", @"昆明", @"丽江"];
    
    self.coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 60, kWIDTH, kHEIGHT - 60)];
    [self.tableView addSubview:self.coverView];
    self.coverView.backgroundColor = [UIColor colorWithRed:47/255.0 green:47/255.0 blue:47/255.0 alpha:1];
    self.coverView.hidden = YES;
    
    self.coverViewsLabel = [[UILabel alloc] init];
    [self.coverView addSubview:self.coverViewsLabel];
    [self.coverViewsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.coverView.mas_left).offset(30);
        make.top.equalTo(self.coverView.mas_top).offset(30);
        make.width.mas_equalTo(kWIDTH);
        make.height.mas_equalTo(50);
    }];
    self.coverViewsLabel.textColor = [UIColor whiteColor];
    UITapGestureRecognizer *tapLabel = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCityLabel)];
    [self.coverViewsLabel addGestureRecognizer:tapLabel];
    self.coverViewsLabel.userInteractionEnabled = YES;
    
    UIView *separaterView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, kWIDTH, 0.5)];
    [self.coverView addSubview:separaterView];
    separaterView.backgroundColor = [UIColor whiteColor];
}

- (void)tapCityLabel {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"你确定要添加%@到天气城市列表？", self.coverViewsLabel.text] preferredStyle:UIAlertControllerStyleAlert];
    //添加取消到UIAlertController中
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ;
    }];
    [alertController addAction:cancelAction];
    
    //添加确定到UIAlertController中
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
        self.coverView.hidden = YES;
        //发送通知，更新UI
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshData" object:[NSString stringWithFormat:@"%@", self.coverViewsLabel.text]];
    }];
    [alertController addAction:OKAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - tableview

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithRed:47/255.0 green:47/255.0 blue:47/255.0 alpha:1];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
        UIView *headerViewv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, 60)];
        _tableView.tableHeaderView = headerViewv;
        UITextField *searchTextField = [[UITextField alloc] init];
        searchTextField.placeholder = @"更多城市请搜索";
        searchTextField.textColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
        searchTextField.layer.cornerRadius = 15;
        searchTextField.layer.masksToBounds = YES;
        searchTextField.backgroundColor = [UIColor colorWithRed:73/255.0 green:73/255.0 blue:73/255.0 alpha:1];
        searchTextField.returnKeyType = UIReturnKeySearch;
        searchTextField.clearButtonMode = UITextFieldViewModeAlways;
        searchTextField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 13, 0)];
        searchTextField.leftViewMode = UITextFieldViewModeAlways;
        searchTextField.delegate = self;
        [headerViewv addSubview:searchTextField];
        [searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headerViewv.mas_left).offset(30);
            make.right.equalTo(headerViewv.mas_right).offset(-30);
            make.top.equalTo(headerViewv.mas_top).offset(20);
            make.height.mas_equalTo(@30);
        }];
    }
    
    return _tableView;
}

#pragma mark - textField代理方法

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSString *cityStr = textField.text;

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSDictionary *parameters = @{
                                 @"city":cityStr,
                                 @"key":key
                                 };
    
    [manager GET:urlStr parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSString *city = responseObject[@"HeWeather5"][0][@"basic"][@"city"];
        if (city) {
            self.coverView.hidden = NO;
            self.coverViewsLabel.text = city;
        } else {
            self.coverView.hidden = NO;
            self.coverViewsLabel.text = @"暂无该城市信息";
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error when download:%@",error);
    }];

    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - tableView代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cityArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LXNavRightBtnCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LXNavRightBtnCell"];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
    cell.textLabel.text = self.cityArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"你确定要添加%@到天气城市列表？", self.cityArray[indexPath.row]] preferredStyle:UIAlertControllerStyleAlert];
    //添加取消到UIAlertController中
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ;
    }];
    [alertController addAction:cancelAction];
    
    //添加确定到UIAlertController中
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
        self.coverView.hidden = YES;
//发送通知，更新UI
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshData" object:[NSString stringWithFormat:@"%@", self.cityArray[indexPath.row]]];
    }];
    [alertController addAction:OKAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
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
