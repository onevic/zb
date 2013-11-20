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
    //#define kServer @"http://192.168.88.8/app/taobao/api/"
    ///get_list.php?cate_id=2733
    NSString *urlString = kServer@"get_list.php?cate_id=";
    urlString = [NSString stringWithFormat:@"%@%@", urlString, cate.categoryId];
    NSLog(@"urlString:%@", urlString);
    _homeLoadCategoryDetailsBlockOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSData *jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
        if (jsonData)
        {
            NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
            NSArray *list = [rootDict objectForKey:@"List"];

            /*存本地*/
            NSUserDefaults *userDefautls = [NSUserDefaults standardUserDefaults];
            NSMutableArray *items = [userDefautls objectForKey:@"Item"];
            if (items)
            {
                [items removeAllObjects];
            }
            [items addObjectsFromArray:list];
            [userDefautls setObject:items forKey:@"Item"];
            [userDefautls synchronize];
            
            _homeLoadCategoryDetailsBlockOperation = nil;
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotifyHomeLoadCategoryDetailCompleted object:nil];
        }else {
            _homeLoadCategoryDetailsBlockOperation = nil;
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotifyHomeLoadCategoryDetailFailed object:nil];
        }
    }];
    [_operationQueue addOperation:_homeFetchNetworkDataBlockOperation];
}
@end

@implementation STDataHelper (Search)
- (void)searchWithKeyword:(NSString *)keyword
{
    NSString *urlString = kServer@"get_search.php?item_name=";
    urlString = [NSString stringWithFormat:@"%@%@", urlString, keyword];
    _searchFetchNetworkDataBlockOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSData *jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
        if (jsonData)
        {
            NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@", rootDict);
            NSArray *list = [rootDict objectForKey:@"List"];
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSMutableArray *items = [[userDefaults objectForKey:@"Item"] copy];
            if (items)
            {
                [items removeAllObjects];
            }
            [items addObjectsFromArray:list];
            [userDefaults setObject:items forKey:@"Item"];
            [userDefaults synchronize];
            
            _searchFetchNetworkDataBlockOperation = nil;
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotifySearchWithKeywordCompleted object:nil];
        }else {
            _searchFetchNetworkDataBlockOperation = nil;
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotifySearchWithKeywordFailed object:nil];
        }
    }];
}
@end
