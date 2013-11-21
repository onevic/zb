//
//  LeftViewController.m
//  购运动
//
//  Created by one_vic on 13-11-18.
//  Copyright (c) 2013年 one_vic. All rights reserved.
//

#import "LeftViewController.h"
#import "MenuCell.h"
#import "IndexViewController.h"
#import "DDMenuController.h"
#import "AppDelegate.h"
#import "STSearchViewController.h"
#import "STBaseNavigationController.h"
#import "CenterViewController.h"

@interface LeftViewController ()

@end

@implementation LeftViewController {
    UITableView *_menuTableView;
    UIView *_bgView;
    NSArray *_menuTitleArray;
    NSArray *_menuImageArray;
    IndexViewController *_index;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _index = [[IndexViewController alloc] init];
    [self createMenuList];
}

- (void)createMenuList
{
    _bgView = [[UIView alloc] init];
    _bgView.backgroundColor = [UIColor purpleColor];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        _bgView.frame = CGRectMake(0, self.view.frame.origin.y+20, 320, self.view.frame.size.height+20);
    } else {
        _bgView.frame = CGRectMake(0, self.view.frame.origin.y-20, 320, self.view.frame.size.height);
    }
    [self.view addSubview:_bgView];
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, _bgView.frame.size.height)];
    bgImageView.image = [UIImage imageNamed:@"左滑-背景.png"];
    [_bgView addSubview:bgImageView];
    _menuTitleArray = [[NSArray alloc] initWithObjects:@"主页", @"搜索", @"我喜欢的", @"购物车", @"个人中心", nil];
    _menuImageArray = [[NSArray alloc] initWithObjects:@"左滑_06.png", @"左滑_09.png", @"左滑_11.png", @"左滑_16.png", @"左滑_03.png", nil];
    _menuTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 220)];
    _menuTableView.backgroundColor = [UIColor clearColor];
    _menuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _menuTableView.delegate = self;
    _menuTableView.dataSource = self;
    [_bgView addSubview:_menuTableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _menuTitleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[MenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.menuTitleLabel.text = [NSString stringWithFormat:@"%@",[_menuTitleArray objectAtIndex:indexPath.row]];
    cell.menuImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[_menuImageArray objectAtIndex:indexPath.row]]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSArray *titleArray = [[NSArray alloc] initWithObjects:@"户外运动", @"搜索", @"我喜欢的", @"购物车", nil];
//    if (indexPath.row != 4) {
//        DDMenuController *menuController = (DDMenuController *)((AppDelegate *)[[UIApplication sharedApplication] delegate]).ddmenu;
//        [menuController setRootController:_index animated:YES];
//        _index.titleLabel.text = [NSString stringWithFormat:@"%@",[titleArray objectAtIndex:indexPath.row]];
//    } else if (indexPath.row == 4) {
//        
//    }
    if (indexPath.row == 0)
    {
        IndexViewController *index = [[IndexViewController alloc] init];
        STBaseNavigationController *nav = [[STBaseNavigationController alloc] initWithRootViewController:index];
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        [appDelegate.ddmenu setRootController:nav animated:YES];
    }
    
    if (indexPath.row == 1)
    {
        STSearchViewController *search = [[STSearchViewController alloc] init];
        STBaseNavigationController *nav = [[STBaseNavigationController alloc] initWithRootViewController:search  ];
        
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        [appDelegate.ddmenu setRootController:nav animated:YES];
    }
    
    if (indexPath.row == 4) {
        CenterViewController *center = [[CenterViewController alloc] init];
        STBaseNavigationController *nav = [[STBaseNavigationController alloc] initWithRootViewController:center];
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        [appDelegate.ddmenu setRootController:nav animated:YES];
    }
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
