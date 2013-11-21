//
//  MyFavouriteCell.m
//  SportShopping
//
//  Created by one_vic on 13-11-21.
//  Copyright (c) 2013年 one_vic. All rights reserved.
//

#import "MyFavouriteCell.h"

@implementation MyFavouriteCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 140, 140)];
        _imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(25+140, 15, 140, 140)];
        UIImageView *coverImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 140-22.5, 140, 22.5)];
        coverImageView.image = [UIImage imageNamed:@"我喜欢的_10.png"];
        coverImageView.alpha = 0.8;
        [_imageView1 addSubview:coverImageView];
        [_imageView2 addSubview:coverImageView];
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
