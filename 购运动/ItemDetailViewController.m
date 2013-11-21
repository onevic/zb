//
//  ItemDetailViewController.m
//  SportShopping
//
//  Created by one_vic on 13-11-20.
//  Copyright (c) 2013年 one_vic. All rights reserved.
//

#import "ItemDetailViewController.h"
#import "STModelItem.h"

@interface ItemDetailViewController ()

@end

@implementation ItemDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addBackButton];
	// Do any additional setup after loading the view.
    // 添加标题
    // 标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 13, 80, 18)];
    titleLabel.text = @"商品详情";
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.textColor = [UIColor whiteColor];
    [_navBar addSubview:titleLabel];
    
    
    if (_webView == Nil)
    {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
        [self.view addSubview:_webView];
        
        NSURL *url = [NSURL URLWithString:_item.itemUrl];
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:urlRequest];
    }
}

- (void)layoutWithItem:(STModelItem *)item
{
    self.item = item;
    if (_webView == Nil)
    {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
        [self.view addSubview:_webView];
        
        NSURL *url = [NSURL URLWithString:_item.itemUrl];
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:urlRequest];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
