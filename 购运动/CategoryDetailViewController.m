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
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    /*加载数据*/
    [[STDataHelper sharedInstance] homeLoadCategoryDetail:_cate];
    [NSNotificationCenter defaultCenter] addObserver:<#(id)#> selector:<#(SEL)#> name:<#(NSString *)#> object:<#(id)#>
}

@end