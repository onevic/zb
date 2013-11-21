//
//  MyFavouriteViewController.m
//  SportShopping
//
//  Created by one_vic on 13-11-21.
//  Copyright (c) 2013年 one_vic. All rights reserved.
//

#import "MyFavouriteViewController.h"
#import "MyFavouriteCell.h"
#import "STDataHelper+Network.h"
#import "STModelItem.h"


@interface MyFavouriteViewController ()

@end

@implementation MyFavouriteViewController {
    UITableView *_tableView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self addMenuButton];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _allMyFavorites = [[NSMutableArray alloc] init];
    /*加载数据*/
    NSArray *allItems = [[STDataHelper sharedInstance] allMyFavoriteItems];
    [_allMyFavorites addObjectsFromArray:allItems];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _allMyFavorites.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyFavouriteCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[MyFavouriteCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    if (_allMyFavorites.count != 0) {
        STModelItem *item1;
        STModelItem *item2;
        if (indexPath.row*2 <= _allMyFavorites.count-1)
        {
            
            item1 = [_allMyFavorites objectAtIndex:indexPath.row*2];
        }
        if (indexPath.row*2+1 <= _allMyFavorites.count-1)
        {
            
            item2 = [_allMyFavorites objectAtIndex:indexPath.row*2+1];
        }
        [cell layoutWithItem1:item1 andItem2:item2];
    }
    return cell;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
