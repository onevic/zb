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
        NSLog(@"%@", kSportShopping);
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
    [self homeLoadCategoryDetailCancel];
    
    _homeLoadCategoryDetailsBlockOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSMutableArray *results = [[NSMutableArray alloc] init];
        NSString *urlString = kServer@"get_list.php?cate_id=";
        for (NSString *subId in cate.categorySubIds) {
            NSString *mySubIdString = [NSString stringWithFormat:@"%@%@", urlString, subId];
            NSLog(@"%@", mySubIdString);
            //            NSLog(@"mysubidstring:%@", mySubIdString);
            
            NSData *jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:mySubIdString]];
            if (jsonData)
            {
                NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
                NSArray *list = [rootDict objectForKey:@"List"];
                
                [results addObjectsFromArray:list];
            }
        }
        [_originRelatesArray removeAllObjects];
        [_originRelatesArray addObjectsFromArray:results];
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
    NSMutableArray *favoritesArray = [[userDefaults objectForKey:@"Favorite"] mutableCopy];
    if (!favoritesArray || favoritesArray.count == 0)
    {
        favoritesArray = [[NSMutableArray alloc] init];
        [favoritesArray addObject:item.itemId];
    }else {
        /*如果不存在就添加*/
        BOOL isExist = NO;
        for (NSString *myId in favoritesArray) {
            if ([myId isEqualToString:item.itemId])
            {
                isExist = YES;
                break;
            }
        }
        if (!isExist)
        {
            [favoritesArray addObject:item.itemId];
        }
    }
    [userDefaults setObject:favoritesArray forKey:@"Favorite"];
    [userDefaults synchronize];
}

- (void)removeFavorite:(STModelItem *)item
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *favoritesArray = [[userDefaults objectForKey:@"Favorite"] mutableCopy];
    if (!favoritesArray || favoritesArray.count == 0)
    {
        
    }else {
        /*如果存在就删除*/
        BOOL isExist = NO;
        for (NSString *myId in favoritesArray) {
            if ([myId isEqualToString:item.itemId])
            {
                isExist = YES;
                break;
            }
        }
        if (isExist)
        {
            [favoritesArray removeObject:item.itemId];
        }
    }
    [userDefaults setObject:favoritesArray forKey:@"Favorite"];
    [userDefaults synchronize];
}

- (NSMutableArray *)allMyFavoriteItems
{
    NSMutableArray *results = [[NSMutableArray alloc] init];
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        
//    });
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *favItemDictsArray = [[NSMutableArray alloc] init];
    for (NSDictionary *itemDict in [userdefaults objectForKey:@"Item"]) {
        if ([self isItemDictFavorited:itemDict])
        {
            [favItemDictsArray addObject:itemDict];
        }
    }
    /*转化成对象*/
    
    for (NSDictionary *dict in favItemDictsArray) {
        NSString *itemName = [dict objectForKey:@"name"];
        NSString *itemFavs = [dict objectForKey:@"favs"];
        NSString *itemPreviewUrl = [dict objectForKey:@"previewUrl"];
        NSString *itemPrice = [dict objectForKey:@"price"];
        NSString *itemUrl = [dict objectForKey:@"url"];
        NSString *itemAct = [dict objectForKey:@"act"];
        NSString *itemId = [dict objectForKey:@"ID"];
        NSString *itemImage2 = [dict objectForKey:@"img2"];
        
        NSLog(@"%@", itemName);
        
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
    if (results.count != 0)
        return results;

    return nil;
}

- (BOOL)isItemDictFavorited:(NSDictionary *)itemDict
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    NSArray *favIdsArray = [userdefaults objectForKey:@"Favorite"];
    for (NSString *myid in favIdsArray) {
        if ([myid isEqualToString:[itemDict objectForKey:@"ID"]])
        {
            return YES;
        }
    }
    return NO;
}

- (void)sortItemsByRelates
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    [userdefaults setObject:_originRelatesArray forKey:@"Item"];
    [userdefaults synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotifySortCompleted object:Nil];
}

- (void)sortItemsByPrice
{
    /*从低到高*/
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *itemsArray = [[userdefaults objectForKey:@"Item"] mutableCopy];
    for (int i=0;i<=itemsArray.count-1;i++)
    {
        BOOL isOk = YES;
        for (int j=itemsArray.count-1;j>=i+1;j--)
        {
            NSDictionary *item0 = [itemsArray objectAtIndex:j-1];
            NSDictionary *item1 = [itemsArray objectAtIndex:j];
            float price0 = [[item0 objectForKey:@"price"] floatValue];
            float price1 = [[item1 objectForKey:@"price"] floatValue];
            if (price0 > price1)
            {
                [itemsArray exchangeObjectAtIndex:j-1 withObjectAtIndex:j];
                isOk = NO;
            }
        }
        if (isOk) break;
    }
    [userdefaults setObject:itemsArray forKey:@"Item"];
    [userdefaults synchronize];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotifySortCompleted object:Nil];
}

- (void)sortItemsBySold
{
    /*从高到低*/
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *itemsArray = [[userdefaults objectForKey:@"Item"] mutableCopy];
    for (int i=0;i<=itemsArray.count-1;i++)
    {
        BOOL isOk = YES;
        for (int j=itemsArray.count-1;j>=i+1;j--)
        {
            NSDictionary *item0 = [itemsArray objectAtIndex:j-1];
            NSDictionary *item1 = [itemsArray objectAtIndex:j];
            NSString *act0str = [[item0 objectForKey:@"act"] substringFromIndex:2];
            NSString *act1str = [[item1 objectForKey:@"act"] substringFromIndex:2];
            
            float act0 = [act0str floatValue];
            float act1 = [act1str floatValue];
            if (act0 < act1)
            {
                [itemsArray exchangeObjectAtIndex:j-1 withObjectAtIndex:j];
                isOk = NO;
            }
        }
        if (isOk) break;
    }
    [userdefaults setObject:itemsArray forKey:@"Item"];
    [userdefaults synchronize];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotifySortCompleted object:Nil];
}

- (void)sortItemsByRenQi
{
    /*从高到低*/
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
