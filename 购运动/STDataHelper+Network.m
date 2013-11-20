//
//  STDataHelper+Network.m
//  SportShopping
//
//  Created by scott on 13-11-19.
//  Copyright (c) 2013年 one_vic. All rights reserved.
//
#import "STModelCategory.h"
#import "STModelItem.h"
#import "NSString+URLEncoding.h"

#define kServer @"http://192.168.88.8/app/taobao/api/"
#define kSportShopping kServer@"get_cateall.php?app_name=sportShopping"

#import "STDataHelper+Network.h"

@implementation STDataHelper (Network)

@end

@implementation STDataHelper (Home)
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
    
    _homeLoadCategoryDetailsBlockOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSMutableArray *results = [[NSMutableArray alloc] init];
        NSString *urlString = kServer@"get_list.php?cate_id=";
        for (NSString *subId in cate.categorySubIds) {
            NSString *mySubIdString = [NSString stringWithFormat:@"%@%@", urlString, subId];
            //            NSLog(@"mysubidstring:%@", mySubIdString);
            
            NSData *jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:mySubIdString]];
            if (jsonData)
            {
                NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
                NSArray *list = [rootDict objectForKey:@"List"];
                
                [results addObjectsFromArray:list];
            }
        }
        /*存本地*/
        /*删除原来的数据*/
        NSUserDefaults *userDefautls = [NSUserDefaults standardUserDefaults];
        NSMutableArray *items = [[userDefautls objectForKey:@"Item"] mutableCopy];
        if (items)
        {
            [items removeAllObjects];
        }
        
        [userDefautls setObject:results forKey:@"Item"];
        [userDefautls synchronize];
        _homeLoadCategoryDetailsBlockOperation = nil;
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotifyHomeLoadCategoryDetailCompleted object:nil];
    }];
    [_operationQueue addOperation:_homeLoadCategoryDetailsBlockOperation];
}

- (void)homeLoadCategoryDetailCancel
{
    if (_homeLoadCategoryDetailsBlockOperation) {
        [_homeLoadCategoryDetailsBlockOperation cancel];
    }
}

- (void)addFavorite:(STModelItem *)item
{
    /*拿到原来搜藏的id*/
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *favoritesArray = [userDefaults objectForKey:@"Favorite"];
    if (!favoritesArray)
    {
        favoritesArray = [[NSMutableArray alloc] init];
    }
    [favoritesArray addObject:item.itemId];
}

- (void)sortItemsByPrice
{
    /*从低到高*/
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *itemsArray = [userdefaults objectForKey:@"Item"];
    for (int i=0;i<=itemsArray.count-1;i++)
    {
        BOOL isOk = YES;
        for (int j=itemsArray.count-1;j>=i+1;j--)
        {
            STModelItem *item0 = [itemsArray objectAtIndex:j-1];
            STModelItem *item1 = [itemsArray objectAtIndex:j];
            if (item0.itemPrice.floatValue > item1.itemPrice.floatValue)
            {
                [itemsArray exchangeObjectAtIndex:i withObjectAtIndex:j];
                isOk = NO;
            }
        }
        if (isOk) break;
    }
}

- (void)sortItemsBySold
{
    /*从高到低*/
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *itemsArray = [userdefaults objectForKey:@"Item"];
    for (int i=0;i<=itemsArray.count-1;i++)
    {
        BOOL isOk = YES;
        for (int j=itemsArray.count-1;j>=i+1;j--)
        {
            STModelItem *item0 = [itemsArray objectAtIndex:j-1];
            STModelItem *item1 = [itemsArray objectAtIndex:j];
            if (item0.itemAct.floatValue < item1.itemAct.floatValue)
            {
                [itemsArray exchangeObjectAtIndex:i withObjectAtIndex:j];
                isOk = NO;
            }
        }
        if (isOk) break;
    }
}

- (void)sortItemsByRenQi
{
    /*从高到低*/
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *itemsArray = [userdefaults objectForKey:@"Item"];
    for (int i=0;i<=itemsArray.count-1;i++)
    {
        BOOL isOk = YES;
        for (int j=itemsArray.count-1;j>=i+1;j--)
        {
            STModelItem *item0 = [itemsArray objectAtIndex:j-1];
            STModelItem *item1 = [itemsArray objectAtIndex:j];
            if (item0.itemAct.floatValue < item1.itemAct.floatValue)
            {
                [itemsArray exchangeObjectAtIndex:i withObjectAtIndex:j];
                isOk = NO;
            }
        }
        if (isOk) break;
    }
}

@end

@implementation STDataHelper (Search)
- (void)searchWithKeyword:(NSString *)keyword
{
    
    NSString *urlString = kServer@"get_search.php?item_name=";
    urlString = [NSString stringWithFormat:@"%@%@", urlString, [keyword urlEncodeString]];
    NSLog(@"%@", urlString);
    _searchFetchNetworkDataBlockOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSData *jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
        if (jsonData)
        {
            NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];

            NSArray *list = [rootDict objectForKey:@"List"];
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSMutableArray *items = [[userDefaults objectForKey:@"Item"] mutableCopy];
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
    [_operationQueue addOperation:_searchFetchNetworkDataBlockOperation];
}
@end
