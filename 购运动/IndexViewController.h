//
//  IndexViewController.h
//  购运动
//
//  Created by one_vic on 13-11-18.
//  Copyright (c) 2013年 one_vic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STBaseViewController.h"

@interface IndexViewController : STBaseViewController
{
    NSMutableArray *_catesArray; //分类数组
}
@property (strong, nonatomic) UILabel *titleLabel;

@end
