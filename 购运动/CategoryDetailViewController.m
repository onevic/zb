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
#import "STModelItem.h"
#import "MyCell.h"

@interface CategoryDetailViewController ()

@end

@implementation CategoryDetailViewController {
    UIImageView *_topImageView;
    UITableView *_tableView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _allItems = [[NSMutableArray alloc] init];
    /*加载数据*/
    [[STDataHelper sharedInstance] homeLoadCategoryDetail:_cate];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadCategoryDetailCompleted) name:kNotifyHomeLoadCategoryDetailCompleted object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadCategoryDetailFailed) name:kNotifyHomeLoadCategoryDetailFailed object:nil];
    
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
    
    
    _tableView.frame = CGRectMake(0, 44, 320, self.view.frame.size.height-44);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadCategoryDetailCompleted) name:kNotifyHomeLoadCategoryDetailCompleted object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadCategoryDetailFailed) name:kNotifyHomeLoadCategoryDetailFailed object:nil];
}

#pragma mark - 下载回调
- (void)loadCategoryDetailCompleted
{
    /*拿到所有商品的数组*/
    NSMutableArray *results = [[NSMutableArray alloc] init];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSArray *list = [user objectForKey:@"Item"];
    for (NSDictionary *dict in list) {
        NSString *itemName = [dict objectForKey:@"name"];
        NSString *itemFavs = [dict objectForKey:@"favs"];
        NSString *itemPreviewUrl = [dict objectForKey:@"previewUrl"];
        NSString *itemPrice = [dict objectForKey:@"price"];
        NSString *itemUrl = [dict objectForKey:@"url"];
        NSString *itemAct = [dict objectForKey:@"act"];
        NSString *itemId = [dict objectForKey:@"ID"];
        
        STModelItem *item = [[STModelItem alloc] init];
        item.itemName = itemName;
        item.itemFavs = itemFavs;
        item.itemPreviewUrl = itemPreviewUrl;
        item.itemPrice = itemPrice;
        item.itemUrl = itemUrl;
        item.itemAct = itemAct;
        item.itemId = itemId;
        [results addObject:item];
    }
    [_allItems addObjectsFromArray:results];
}

- (void)loadCategoryDetailFailed
{
    NSLog(@"failed");
}

#pragma mark tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[MyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    return cell;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}


@end