//
//  IndexViewController.m
//  购运动
//
//  Created by one_vic on 13-11-18.
//  Copyright (c) 2013年 one_vic. All rights reserved.
//

#import "IndexViewController.h"
#import "AppDelegate.h"
#import "LeftViewController.h"
#import "DDMenuController.h"
#import "STDataHelper+Network.h"
#import "STModelCategory.h"
#import "CategoryDetailViewController.h"

@interface IndexViewController ()

@end

@implementation IndexViewController {
    LeftViewController *_left;
    NSMutableArray *_cateImageArray;
}


- (void)viewWillDisappear:(BOOL)animated
{
    _left = [[LeftViewController alloc] init];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /*数据初始化*/
    _catesArray = [[NSMutableArray alloc] init];
	// Do any additional setup after loading the view.
    
    [self createUI];
    [self addScrollView];
    
    
    /*下载*/
    [[STDataHelper sharedInstance] homeLoadCategory];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchNetworkCompleted:) name:kNotifyHomeFetchNetworkDataCompleted object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchNetworkFailed:) name:kNotifyHomeFetchNetworkDataFailed object:nil];
}

- (void)createUI
{
    // 容器北京，贴在self.view上，其他控件贴在_bgView上
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
    [self.view addSubview:bgImageView];

    [self addMenuButton];
    
    // 标题
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 13, 80, 18)];
    _titleLabel.text = @"户外运动";
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont boldSystemFontOfSize:18];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = [UIColor whiteColor];
    [self.navBar addSubview:_titleLabel];
}


// 添加首页八个模块
- (void)addScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
    scrollView.contentSize = CGSizeMake(320, 25+126.5*2+274*2);
    [self.view addSubview:scrollView];
    scrollView.userInteractionEnabled = YES;
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.tag = 1;
    btn1.frame = CGRectMake(5, 5, 309, 126.5);
    [btn1 setImage:[UIImage imageNamed:@"首页_07.png"] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(cateButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.tag = 2;
    btn2.frame = CGRectMake(5, 10+126.5, 164, 274);
    [btn2 setImage:[UIImage imageNamed:@"首页_10.png"] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(cateButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:btn2];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.tag = 3;
    btn3.frame = CGRectMake(11+164, 10+126.5, 138, 134);
    [btn3 setImage:[UIImage imageNamed:@"首页_12.png"] forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(cateButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:btn3];
    
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn4.tag = 4;
    btn4.frame = CGRectMake(11+164, 15+126.5+134, 138, 134);
    [btn4 setImage:[UIImage imageNamed:@"首页_14.png"] forState:UIControlStateNormal];
    [btn4 addTarget:self action:@selector(cateButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:btn4];
    
    UIButton *btn5 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn5.tag = 5;
    btn5.frame = CGRectMake(5, 20+126.5+134*2, 309, 126.5);
    [btn5 setImage:[UIImage imageNamed:@"首页1_03.png"] forState:UIControlStateNormal];
    [btn5 addTarget:self action:@selector(cateButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:btn5];
    
    UIButton *btn6 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn6.tag = 6;
    btn6.frame = CGRectMake(5, 25+126.5*2+134*2, 164, 274);
    [btn6 setImage:[UIImage imageNamed:@"首页1_06.png"] forState:UIControlStateNormal];
    [btn6 addTarget:self action:@selector(cateButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:btn6];
    
    UIButton *btn7 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn7.tag = 7;
    btn7.frame = CGRectMake(11+164, 25+126.5*2+134*2, 138, 134);
    [btn7 setImage:[UIImage imageNamed:@"首页1_08.png"] forState:UIControlStateNormal];
    [btn7 addTarget:self action:@selector(cateButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:btn7];
    
    UIButton *btn8 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn8.tag = 8;
    btn8.frame = CGRectMake(11+164, 30+126.5*2+134*3, 138, 134);
    [btn8 setImage:[UIImage imageNamed:@"首页1_10.png"] forState:UIControlStateNormal];
    [btn8 addTarget:self action:@selector(cateButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:btn8];
}

#pragma - mark 点击事件
- (void)cateButtonClicked:(UIButton *)button
{
    /*名字数组*/
    /*
     运动鞋
     运动服
     运动包配
     运动品牌
     户外
     户外品牌
     健身用品
     健身品牌
     */
    NSArray *namesArray = @[@"", @"运动鞋", @"运动服", @"运动包配", @"运动品牌", @"户外", @"户外品牌", @"健身用品", @"健身品牌"];
    NSString *touchName = [namesArray objectAtIndex:button.tag];
//    NSLog(@"touchName:%@", touchName);
    
    /*拿到选中的分类*/
    STModelCategory *seletedCategory;
    NSMutableArray *results = [[NSMutableArray alloc] init];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *list = [userDefaults objectForKey:@"Category"];
    for (NSDictionary *dict in list) {
        NSString *cateName = [dict objectForKey:@"Name"];
        NSString *cateId = [dict objectForKey:@"ID"];
        
        
        STModelCategory *cate = [[STModelCategory alloc] init];
        cate.categoryName = cateName;
        cate.categoryId = cateId;
        
        NSArray *subList = [dict objectForKey:@"List"];
        for (NSDictionary *subdict in subList) {
            NSString *subId = [subdict objectForKey:@"ID"];
            [cate.categorySubIds addObject:subId];
        }
        [results addObject:cate];
    }
    for (STModelCategory *cate in results) {
        if ([cate.categoryName isEqualToString:touchName])
        {
            seletedCategory = cate;
            break;
        }
    }
    if (seletedCategory == Nil)
    {
        
        seletedCategory = [[STModelCategory alloc] init];
        seletedCategory.categoryName = touchName;
    }
    
    CategoryDetailViewController *cateDetails = [[CategoryDetailViewController alloc] init];
    cateDetails.cate = seletedCategory;
    [self.navigationController pushViewController:cateDetails animated:YES];
}

#pragma - mark 下载回调
- (void)fetchNetworkCompleted:(NSNotification *)notify
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *cates = [userDefaults objectForKey:@"Category"];
    [_catesArray addObjectsFromArray:cates];
}

- (void)fetchNetworkFailed:(NSNotification *)notify
{
    NSLog(@"加载分类失败");
}

@end
