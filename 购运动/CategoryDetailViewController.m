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

@implementation CategoryDetailViewController

- (id)initWithCategory:(STModelCategory *)cate
{
    if (self = [super init])
    {
        _cate = [cate copy];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    /*加载数据*/
    [[STDataHelper sharedInstance] homeLoadCategoryDetail:_cate];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadCategoryDetailCompleted) name:kNotifyHomeLoadCategoryDetailCompleted object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadCategoryDetailFailed) name:kNotifyHomeLoadCategoryDetailFailed object:nil];
}

#pragma mark - 下载回调
- (void)loadCategoryDetailCompleted
{
    //            NSMutableArray *results = [[NSMutableArray alloc] init];
    //            for (NSDictionary *dict in list) {
    //                NSString *itemName = [dict objectForKey:@"name"];
    //                NSString *itemFavs = [dict objectForKey:@"favs"];
    //                NSString *itemPreviewUrl = [dict objectForKey:@"previewUrl"];
    //                NSString *itemPrice = [dict objectForKey:@"price"];
    //                NSString *itemUrl = [dict objectForKey:@"url"];
    //                NSString *itemAct = [dict objectForKey:@"act"];
    //                NSString *itemId = [dict objectForKey:@"ID"];
    //
    //                STModelItem *item = [[STModelItem alloc] init];
    //                item.itemName = itemName;
    //                item.itemFavs = itemFavs;
    //                item.itemPreviewUrl = itemPreviewUrl;
    //                item.itemPrice = itemPrice;
    //                item.itemUrl = itemUrl;
    //                item.itemAct = itemAct;
    //                item.itemId = itemId;
    //                [results addObject:item];
    //            }
}

- (void)loadCategoryDetailFailed
{
    
}

@end