//
//  STSearchViewController.m
//  SportShopping
//
//  Created by scott on 13-11-19.
//  Copyright (c) 2013年 one_vic. All rights reserved.
//

#import "STSearchViewController.h"
#import "SearchResultViewController.h"
#import "STDataHelper+Network.h"

@interface STSearchViewController ()

@end

@implementation STSearchViewController {
    UITextField *_searchTextField;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addMenuButton];
    /*标题*/
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 13, 80, 18)];
    titleLabel.text = @"搜索";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.center = self.navBar.center;
    [self.navBar addSubview:titleLabel];
    
    // 搜索条
    UIImageView *searchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(25, 30, 215, 33.5)];
    searchImageView.image = [UIImage imageNamed:@"搜索2_07.png"];
    [self.view addSubview:searchImageView];
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(240, 30, 54.5, 33.5);
    [searchBtn setImage:[UIImage imageNamed:@"搜索1_07.png"] forState:UIControlStateNormal];
    [searchBtn setImage:[UIImage imageNamed:@"搜索3_08.png"] forState:UIControlStateHighlighted];
    [searchBtn addTarget:self action:@selector(goSearch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBtn];
    
    _searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(32, 32, 208, 30)];
    _searchTextField.delegate = self;
    [self.view addSubview:_searchTextField];
    
    // 点击背景收起键盘
    UIControl *control = [[UIControl alloc] init];
    control.frame = CGRectMake(0, 0, 320, 460);
    [control addTarget:self action:@selector(controlClick)                                                              forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:control];
    [self.view sendSubviewToBack:control];
}

- (void)goSearch
{
    [_searchTextField resignFirstResponder];
    if (_searchTextField.text == Nil || [_searchTextField.text isEqualToString:@""])
    {
        return;
    }
    [[STDataHelper sharedInstance] searchWithKeyword:_searchTextField.text];
    /*推入搜索结果*/
    SearchResultViewController *result = [[SearchResultViewController alloc] init];
    [self.navigationController pushViewController:result animated:YES];
}

- (void)controlClick
{
    [_searchTextField resignFirstResponder];
}

#pragma mark - TextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_searchTextField resignFirstResponder];
    [self goSearch];
    return YES;
}

@end
