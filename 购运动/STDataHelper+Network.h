//
//  STDataHelper+Network.h
//  SportShopping
//
//  Created by scott on 13-11-19.
//  Copyright (c) 2013年 one_vic. All rights reserved.
//

#import "STDataHelper.h"

@interface STDataHelper (Network)

@end

@class STModelCategory;
#define kNotifyHomeFetchNetworkDataCompleted @"kNotifyHomeFetchNetworkDataCompleted"
#define kNotifyHomeFetchNetworkDataFailed @"kNotifyHomeFetchNetworkDataFailed"
#define kNotifyHomeLoadCategoryDetailCompleted @"kNotifyHomeLoadCategoryDetailCompleted"
#define kNotifyHomeLoadCategoryDetailFailed @"kNotifyHomeLoadCategoryDetailFailed"
@interface STDataHelper (Home)
- (void)homeLoadCategory; //加载分类
- (void)homeFetchNetworkDataCancel;
- (void)homeLoadCategoryDetail:(STModelCategory *)cate; //加载某个分类的详细信息
@end

#define kNotifySearchWithKeywordCompleted @"kNotifySearchWithKeywordCompleted"
#define kNotifySearchWithKeywordFailed @"kNotifySearchWithKeywordFailed"
@interface STDataHelper (Search)
- (void)searchWithKeyword:(NSString *)keyword;
@end
