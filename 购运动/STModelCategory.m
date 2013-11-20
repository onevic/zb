//
//  STModelCategory.m
//  SportShopping
//
//  Created by scott on 13-11-19.
//  Copyright (c) 2013年 one_vic. All rights reserved.
//

#import "STModelCategory.h"

@implementation STModelCategory

- (id)init
{
    if (self = [super init])
    {
        
        _categorySubIds = [[NSMutableArray alloc] init];
    }
    return self;
}
@end
