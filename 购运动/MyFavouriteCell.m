//
//  MyFavouriteCell.m
//  SportShopping
//
//  Created by one_vic on 13-11-21.
//  Copyright (c) 2013年 one_vic. All rights reserved.
//

#import "MyFavouriteCell.h"
#import "UIImageView+WebCache.h"
#import "STModelItem.h"

@implementation MyFavouriteCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.item1 = [[STModelItem alloc] init];
        self.item2 = [[STModelItem alloc] init];
        
        // Initialization code
        _imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 140, 140)];
        _imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(25+140, 15, 140, 140)];
        
        _cover1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 140-22.5, 140, 22.5)];
        _cover1.image = [UIImage imageNamed:@"我喜欢的_10.png"];
        _cover1.alpha = 0.8;
        [_imageView1 addSubview:_cover1];
        
        _cover2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 140-22.5, 140, 22.5)];
        _cover2.image = [UIImage imageNamed:@"我喜欢的_10.png"];
        _cover2.alpha = 0.8;
        [_imageView2 addSubview:_cover2];
        
        [self.contentView addSubview:_imageView1];
        [self.contentView addSubview:_imageView2];
        
        _priceLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 140-22.5, 140, 22.5)];
        _priceLabel1.textAlignment = NSTextAlignmentLeft;
        _priceLabel1.backgroundColor = [UIColor clearColor];
        _priceLabel1.font = [UIFont systemFontOfSize:14];
        _priceLabel1.textColor = [UIColor whiteColor];
        [_imageView1 addSubview:_priceLabel1];
        
        _priceLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 140-22.5, 140, 22.5)];
        _priceLabel2.textAlignment = NSTextAlignmentLeft;
        _priceLabel2.backgroundColor = [UIColor clearColor];
        _priceLabel2.font = [UIFont systemFontOfSize:14];
        _priceLabel2.textColor = [UIColor whiteColor];
        [_imageView2 addSubview:_priceLabel2];
    }
    return self;
}

- (void)layoutWithItem1:(STModelItem *)item1 andItem2:(STModelItem *)item2
{
    self.item1 = item1;
    self.item2 = item2;
    if (self.item1)
    {
        
        [_imageView1 setImageWithURL:[NSURL URLWithString:item1.itemImage2]];
        _priceLabel1.text = item1.itemPrice;
    }else {
        _cover1.hidden = YES;
    }
    if (self.item2)
    {
        
        [_imageView2 setImageWithURL:[NSURL URLWithString:item2.itemImage2]];
        
        _priceLabel2.text = item2.itemPrice;
    }else {
        _cover2.hidden = YES;
    }
    
}

@end
