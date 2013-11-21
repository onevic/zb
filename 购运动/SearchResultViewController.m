//
//  SearchResultViewController.m
//  SportShopping
//
//  Created by one_vic on 13-11-20.
//  Copyright (c) 2013年 one_vic. All rights reserved.
//

#import "SearchResultViewController.h"
#import "SearchResultCell.h"
#import "STDataHelper+Network.h"
#import "STModelItem.h"

@interface SearchResultViewController ()

@end

@implementation SearchResultViewController {
    UITableView *_tableView;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self addBackButton];
    _resultsItems = [[NSMutableArray alloc] init];
    
    // 搜索结果
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    /*联网加载*/
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchCompleted) name:kNotifySearchWithKeywordCompleted object:Nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchFailed) name:kNotifySearchWithKeywordFailed object:Nil];
}

#pragma mark - 下载回调
- (void)searchCompleted
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        /*拿到所有商品的数组*/
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
            
            [_resultsItems addObject:item];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
    });
}

- (void)searchFailed
{
    
}

#pragma mark tableView
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _resultsItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[SearchResultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (_resultsItems.count != 0)
    {
        STModelItem *item = [_resultsItems objectAtIndex:indexPath.row];
        [cell layoutWithItem:item];
    }
    return cell;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
