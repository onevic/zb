//
//  STModelItem.h
//  SportShopping
//
//  Created by scott on 13-11-19.
//  Copyright (c) 2013年 one_vic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STModelItem : NSObject
@property (nonatomic, strong) NSString *itemName;
@property (nonatomic, strong) NSString *itemFavs;
@property (nonatomic, strong) NSString *itemPreviewUrl;
@property (nonatomic, strong) NSString *itemPrice;
@property (nonatomic, strong) NSString *itemUrl;
@property (nonatomic, strong) NSString *itemAct; //销量
@property (nonatomic, strong) NSString *itemId; 
@end
