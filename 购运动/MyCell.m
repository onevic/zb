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
        _imageView.backgroundColor = [UIColor grayColor];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 20, 190, 40)];
        _titleLabel.numberOfLines = 2;
        _titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [self.contentView addSubview:_titleLabel];
        
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 100-24, 80, 24)];
        [self.contentView addSubview:_priceLabel];
        _priceLabel.textColor = [UIColor redColor];
        
        _favouriteImageView = [[UIImageView alloc] initWithFrame:CGRectMake(320-20-30, 100-25, 30, 25)];
        [self.contentView addSubview:_favouriteImageView];
        _favouriteImageView.backgroundColor = [UIColor lightGrayColor];
    }
    return self;
}

- (void)layoutWithItem:(STModelItem *)item
{
    [_imageView setImageWithURL:[NSURL URLWithString:item.itemImage2]];
    _titleLabel.text = item.itemName;
    _priceLabel.text = [NSString stringWithFormat:@"￥%@",item.itemPrice];
}

@end
