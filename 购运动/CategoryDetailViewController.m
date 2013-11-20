//
//  CategoryDetailViewController.m
//  SportShopping
//
//  Created by one_vic on 13-11-19.
//  Copyright (c) 2013年 one_vic. All rights reserved.
//

#import "CategoryDetailViewController.h"
#import "STModelCategory.h"
#import "STDataHelper+Network.h"

@interface CategoryDetailViewController ()

@end

@implementation CategoryDetailViewController {
    UIImageView *_topImageView;
    UITableView *_tableView;
}

- (id)initWithCategory:(STModelCategory *)cate
{
    if (self = [super init])
    {
        _cate = [cate copy];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    /*加载数据*/
    [[STDataHelper sharedInstance] homeLoadCategoryDetail:_cate];
//    [NSNotificationCenter defaultCenter] addObserver:<#(id)#> selector:<#(SEL)#> name:<#(NSString *)#> object:<#(id)#>
    
    _tableView = [[UITableView alloc] init];
    [self createUI];
}

- (void)createUI
{
    // 选项按钮
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, 320, 43)];
    [self.view addSubview:topView];
    _topImageView= [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 43)];
    [topView addSubview:_topImageView];

    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0, 0, 80, 40);
    [topView addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(80, 0, 80, 40);
    [topView addSubview:btn2];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(160, 0, 80, 40);
    [topView addSubview:btn3];
    
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn4.frame = CGRectMake(240, 0, 80, 40);
    [topView addSubview:btn4];
    
    
    _tableView.frame = CGRectMake(0, 87, 320, self.view.frame.size.height-87);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

#pragma mark tableView



@end