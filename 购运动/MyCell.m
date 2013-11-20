//
//  MyCell.m
//  SportShopping
//
//  Created by one_vic on 13-11-20.
//  Copyright (c) 2013年 one_vic. All rights reserved.
//

#import "MyCell.h"
#import "STModelItem.h"
#import "UIImageView+WebCache.h"
#import "STDataHelper+Network.h"

@implementation MyCell

@synthesize imageView = _imageView;
@synthesize titleLabel = _titleLabel;
@synthesize priceLabel = _priceLabel;
@synthesize favouriteBtn = _favouriteBtn;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 80, 80)];
        [self.contentView addSubview:_imageView];
        _imageView.backgroundColor = [UIColor grayColor];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 20, 190, 45)];
        _titleLabel.textColor = [UIColor darkGrayColor];
        _titleLabel.numberOfLines = 2;
        _titleLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_titleLabel];
        
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 100-24, 80, 24)];
        [self.contentView addSubview:_priceLabel];
        _priceLabel.textColor = [UIColor redColor];
        
        _favouriteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _favouriteBtn.backgroundColor = [UIColor clearColor];
        _favouriteBtn.frame = CGRectMake(320-20-15, 100-15, 15, 12.5);
        [_favouriteBtn setImage:[UIImage imageNamed:@"运动鞋_42.png"] forState:UIControlStateNormal];
        [_favouriteBtn addTarget:self action:@selector(favouriteBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_favouriteBtn];
        
        // 分割线
        UIImageView *breakLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 119, 320, 1)];
        breakLine.image = [UIImage imageNamed:@"运动鞋1_46.png"];
        [self.contentView addSubview:breakLine];
    }
    return self;
}

- (void)favouriteBtnClicked
{
    if (_isFav)
    {
        /*取消搜藏*/
        [[STDataHelper sharedInstance] removeFavorite:self.item];
    }else {
        [[STDataHelper sharedInstance] addFavorite:self.item];
    }
    [self layoutWithItem:self.item];
}

- (void)layoutWithItem:(STModelItem *)item
{
    self.item = item;
    [_imageView setImageWithURL:[NSURL URLWithString:item.itemImage2]];
    _titleLabel.text = item.itemName;
    _priceLabel.text = [NSString stringWithFormat:@"￥%@",item.itemPrice];
    if ([self isFavorite])
    {
        /*实心红心*/
        [_favouriteBtn setImage:[UIImage imageNamed:@"运动鞋_52.png"] forState:UIControlStateNormal];
    } else {
        [_favouriteBtn setImage:[UIImage imageNamed:@"运动鞋_42.png"] forState:UIControlStateNormal];
    }
}

- (BOOL)isFavorite
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *favoritesArray = [userdefaults objectForKey:@"Favorite"];
    if (favoritesArray)
    {
        for (NSString *myid in favoritesArray) {
            if ([myid isEqualToString:self.item.itemId])
            {
                _isFav = YES;
                return YES;
            }
        }
    }
    _isFav = NO;
    return NO;
}

@end
