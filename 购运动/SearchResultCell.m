//
//  SearchResultCell.m
//  SportShopping
//
//  Created by one_vic on 13-11-20.
//  Copyright (c) 2013年 one_vic. All rights reserved.
//

#import "SearchResultCell.h"

@implementation SearchResultCell

@synthesize imageView = _imageView;
@synthesize titleLabel = _titleLabel;
@synthesize priceLabel = _priceLabel;
@synthesize payBtn = _payBtn;

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
        
        // 结算按钮
        _payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _payBtn.frame = CGRectMake(320-60-55, 120-20-22, 55, 22);
        [_payBtn setBackgroundImage:[UIImage imageNamed:@"购物车_18.png"] forState:UIControlStateNormal];
        [_payBtn setTitle:@"去结算" forState:UIControlStateNormal];
        _payBtn.titleLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_payBtn];
        
        UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(320-20-9.5, 52.5, 9.5, 15)];
        leftImageView.image = [UIImage imageNamed:@"购物车_14.png"];
        [self.contentView addSubview:leftImageView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
