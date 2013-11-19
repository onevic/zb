//
//  STSearchViewController.m
//  SportShopping
//
//  Created by scott on 13-11-19.
//  Copyright (c) 2013年 one_vic. All rights reserved.
//

#import "STSearchViewController.h"

@interface STSearchViewController ()

@end

@implementation STSearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    /*标题*/
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 13, 80, 18)];
    titleLabel.text = @"搜索";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.center = self.navBar.center;
    [self.navBar addSubview:titleLabel];
}

@end
