//
//  STDataHelper.h
//  QingDaoEstates
//
//  Created by scott on 13-11-13.
//  Copyright (c) 2013年 scott. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STDataHelper : NSObject
{
    NSOperationQueue *_operationQueue;
    
    NSBlockOperation *_homeFetchNetworkDataBlockOperation;
    NSBlockOperation *_searchFetchNetworkDataBlockOperation;
    NSBlockOperation *_homeLoadCategoryDetailsBlockOperation;
}
+ (id)sharedInstance;
@end
