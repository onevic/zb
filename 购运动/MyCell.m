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

@implementation MyCell

@synthesize imageView = _imageView;
@synthesize titleLabel = _titleLabel;
@synthesize priceLabel = _priceLabel;
@synthesize favouriteImageView = _favouriteImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 80, 80)];
        [self.contentView addSubview:_imageView];
        _imageView.backgroundColor = [UIColor redColor];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 20, 170, 50)];
        _titleLabel.numberOfLines = 2;
        [self.contentView addSubview:_titleLabel];
        _titleLabel.backgroundColor = [UIColor cyanColor];
        
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 100-24, 80, 24)];
        [self.contentView addSubview:_priceLabel];
        _priceLabel.backgroundColor = [UIColor orangeColor];
        
        _favouriteImageView = [[UIImageView alloc] initWithFrame:CGRectMake(320-40-30, 100-25, 30, 25)];
        [self.contentView addSubview:_favouriteImageView];
        _favouriteImageView.backgroundColor = [UIColor lightGrayColor];
    }
    return self;
}

- (void)layoutWithItem:(STModelItem *)item
{
    [_imageView setImageWithURL:[NSURL URLWithString:item.itemImage2]];
    _titleLabel.text = item.itemName;
    _priceLabel.text = item.itemPrice;
}

@end
