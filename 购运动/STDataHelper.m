//
//  STDataHelper.m
//  QingDaoEstates
//
//  Created by scott on 13-11-13.
//  Copyright (c) 2013年 scott. All rights reserved.
//

#import "STDataHelper.h"

@implementation STDataHelper
+ (id)sharedInstance
{
    static STDataHelper *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[super alloc] init];
    });
    return _instance;
}
- (id)init
{
    if (self = [super init])
    {
        _operationQueue = [[NSOperationQueue alloc] init];
        _operationQueue.maxConcurrentOperationCount = 10;
        
        _homeFetchNetworkDataBlockOperation = nil;
        _searchFetchNetworkDataBlockOperation = nil;
        _homeLoadCategoryDetailsBlockOperation = nil;
    }
    return self;
}
@end
