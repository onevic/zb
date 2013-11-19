//
//  STDataHelper+Network.m
//  SportShopping
//
//  Created by scott on 13-11-19.
//  Copyright (c) 2013年 one_vic. All rights reserved.
//
#import "STModelCategory.h"
#import "STModelItem.h"

#define kServer @"http://192.168.88.8/app/taobao/api/"
#define kSportShopping kServer@"get_cateall.php?app_name=sportShopping"

#import "STDataHelper+Network.h"

@implementation STDataHelper (Network)
- (void)homeLoadCategory
{
    _homeFetchNetworkDataBlockOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSData *jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:kSportShopping]];
        if (jsonData)
        {
            NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
            NSArray *list = [rootDict objectForKey:@"List"];
            NSDictionary *value0 = [list objectAtIndex:0];
            list = [value0 objectForKey:@"List"];
//            
//            NSMutableArray *results = [[NSMutableArray alloc] init];
//            for (NSDictionary *dict in list) {
//                NSString *cateName = [dict objectForKey:@"Name"];
//                NSString *cateId = [dict objectForKey:@"ID"];
//                
//                STModelCategory *cate = [[STModelCategory alloc] init];
//                cate.categoryName = cateName;
//                cate.categoryId = cateId;
//                [results addObject:cate];
//            }
            /*保存到本地*/
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:list forKey:@"Category"];
            [userDefaults synchronize];
            
            _homeFetchNetworkDataBlockOperation = nil;
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotifyHomeFetchNetworkDataCompleted object:nil];
        }else {
            _homeFetchNetworkDataBlockOperation = nil;
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotifyHomeFetchNetworkDataFailed object:nil];
        }
    }];
    [_operationQueue addOperation:_homeFetchNetworkDataBlockOperation];
}

- (void)homeFetchNetworkDataCancel
{
    if (_homeFetchNetworkDataBlockOperation)
    {
        [_homeFetchNetworkDataBlockOperation cancel];
    }
}
/*
 name
 favs
 previewUrl
 price
 url
 act
 ID
 */
- (void)homeLoadCategoryDetail:(STModelCategory *)cate
{
    _homeLoadCategoryDetailsBlockOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSData *jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@""]];
        if (jsonData)
        {
            NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
            NSArray *list = [rootDict objectForKey:@"List"];
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
            /*存本地*/
            NSUserDefaults *userDefautls = [NSUserDefaults standardUserDefaults];
            [userDefautls setObject:list forKey:@"Item"];
            
            _homeLoadCategoryDetailsBlockOperation = nil;
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotifyHomeLoadCategoryDetailCompleted object:nil];
        }else {
            _homeLoadCategoryDetailsBlockOperation = nil;
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotifyHomeLoadCategoryDetailFailed object:nil];
        }
    }];
}
@end

@implementation STDataHelper (Search)
- (void)searchFetchNetworkDataStart
{
    
    _searchFetchNetworkDataBlockOperation = [NSBlockOperation blockOperationWithBlock:^{
        
    }];
    [_operationQueue addOperation:_searchFetchNetworkDataBlockOperation];
}
- (void)searchFetchNetworkDataCancel
{
    if (_searchFetchNetworkDataBlockOperation)
    {
        [_searchFetchNetworkDataBlockOperation cancel];
    }
}
@end
