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
#import "ItemDetailViewController.h"

@interface CategoryDetailViewController ()

@end

@implementation CategoryDetailViewController {
    UIImageView *_topImageView;
    UITableView *_tableView;
    UILabel *_titleLabel;
    NSMutableArray *_btnArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _allItems = [[NSMutableArray alloc] init];
    _btnArray = [[NSMutableArray alloc] initWithCapacity:4];
    /*加载数据*/
    [[STDataHelper sharedInstance] homeLoadCategoryDetail:_cate];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadCategoryDetailCompleted) name:kNotifyHomeLoadCategoryDetailCompleted object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadCategoryDetailFailed) name:kNotifyHomeLoadCategoryDetailFailed object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadCategoryDetailCompleted) name:kNotifySortCompleted object:Nil];
    
    _tableView = [[UITableView alloc] init];
    [self createUI];
}

- (void)backButtonClicked
{
    [super backButtonClicked];
    [[STDataHelper sharedInstance] homeLoadCategoryDetailCancel];
}

- (void)createUI
{
    [self addBackButton];
    
    // 添加标题
    // 标题
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 13, 80, 18)];
    _titleLabel.text = [NSString stringWithFormat:@"%@",_cate.categoryName];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont boldSystemFontOfSize:18];
    _titleLabel.textColor = [UIColor whiteColor];
    [_navBar addSubview:_titleLabel];
    
    // 选项按钮
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 43)];
    [self.view addSubview:topView];
    _topImageView= [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 43)];
    _topImageView.image = [UIImage imageNamed:@"相关.png"];
    [topView addSubview:_topImageView];

    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.tag = 101;
    btn1.frame = CGRectMake(13, 11.5, 54, 19.5);
    [btn1 setImage:[UIImage imageNamed:@"运动鞋1_03.png"] forState:UIControlStateNormal];
    [btn1 setImage:[UIImage imageNamed:@"运动鞋_03nmb.png"] forState:UIControlStateSelected];
    [btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:btn1];
    [_btnArray addObject:btn1];
    btn1.selected = YES;
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.tag = 102;
    btn2.frame = CGRectMake(93, 11.5, 54, 19.5);
    [btn2 setImage:[UIImage imageNamed:@"运动鞋_05.png"] forState:UIControlStateNormal];
    [btn2 setImage:[UIImage imageNamed:@"运动鞋1_05.png"] forState:UIControlStateSelected];
    [btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:btn2];
    [_btnArray addObject:btn2];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.tag = 103;
    btn3.frame = CGRectMake(173, 11.5, 54, 19.5);
    [btn3 setImage:[UIImage imageNamed:@"运动鞋_07.png"] forState:UIControlStateNormal];
    [btn3 setImage:[UIImage imageNamed:@"运动鞋1_07.png"] forState:UIControlStateSelected];
    [btn3 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:btn3];
    [_btnArray addObject:btn3];
    
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn4.tag = 104;
    btn4.frame = CGRectMake(253, 11.5, 54, 19.5);
    [btn4 setImage:[UIImage imageNamed:@"运动鞋_09.png"] forState:UIControlStateNormal];
    [btn4 setImage:[UIImage imageNamed:@"运动鞋1_09.png"] forState:UIControlStateSelected];
    [btn4 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:btn4];
    [_btnArray addObject:btn4];
    
    _tableView.frame = CGRectMake(0, 43, kScreenWidth, kScreenHeight-87-20);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadCategoryDetailCompleted) name:kNotifyHomeLoadCategoryDetailCompleted object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadCategoryDetailFailed) name:kNotifyHomeLoadCategoryDetailFailed object:nil];
}

- (void)btnClick:(UIButton *)btn
{
    
    int selected = btn.tag - 100 - 1;
    NSArray *namesArray = @[@"相关", @"价格", @"销量", @"人气"];
    btn.selected = YES;
    _topImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [namesArray objectAtIndex:selected]]];
    for (UIButton *button in _btnArray) {
        if (button.tag != btn.tag) {
            button.selected = NO;
        }
    }
    
    if (_allItems.count == 0)
    {
        return;
    }
    
    if (selected == 0)
    {
        //相关
        
        
    }else if (selected == 1)
    {
        //价格
        [[STDataHelper sharedInstance] sortItemsByPrice];

        
    }else if (selected == 2)
    {
        //销量
        [[STDataHelper sharedInstance] sortItemsBySold];

        
    }else {
        //人气
        
    }
}



#pragma mark - 下载回调
- (void)loadCategoryDetailCompleted
{
    [_allItems removeAllObjects];

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
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
            NSString *itemImage2 = [dict objectForKey:@"img2"];
            
            STModelItem *item = [[STModelItem alloc] init];
            item.itemName = itemName;
            item.itemFavs = itemFavs;
            item.itemPreviewUrl = itemPreviewUrl;
            item.itemPrice = itemPrice;
            item.itemUrl = itemUrl;
            item.itemAct = itemAct;
            item.itemId = itemId;
            item.itemImage2 = itemImage2;
            
            [results addObject:item];
        }
        [_allItems addObjectsFromArray:results];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
    });

}

- (void)loadCategoryDetailFailed
{
    NSLog(@"failed");
}

#pragma mark tableView
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ItemDetailViewController *itemDetail = [[ItemDetailViewController alloc] init];
    STModelItem *item = [_allItems objectAtIndex:indexPath.row];
    [itemDetail layoutWithItem:item];
    [self.navigationController pushViewController:itemDetail animated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _allItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[MyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (_allItems.count != 0)
    {
        STModelItem *item = [_allItems objectAtIndex:indexPath.row];
//        cell.textLabel.text = item.itemName;
        [cell layoutWithItem:item];
    }
    return cell;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}


@end