//
//  ItemDetailViewController.h
//  SportShopping
//
//  Created by one_vic on 13-11-20.
//  Copyright (c) 2013年 one_vic. All rights reserved.
//

#import "STBaseViewController.h"

@class STModelItem;
@interface ItemDetailViewController : STBaseViewController
{
    UIWebView *_webView;
    STModelItem *_item;
}
@property (strong, nonatomic) STModelItem *item;
- (void)layoutWithItem:(STModelItem *)item;

@end
