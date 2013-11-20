//
//  CategoryDetailViewController.h
//  SportShopping
//
//  Created by one_vic on 13-11-19.
//  Copyright (c) 2013年 one_vic. All rights reserved.
//

#import "STBaseViewController.h"

@class STModelCategory;
@interface CategoryDetailViewController : STBaseViewController <UITableViewDataSource,UITableViewDelegate>
{
    STModelCategory *_cate;
    NSMutableArray *_allItems;
}
@property (nonatomic, strong) STModelCategory *cate;

@end