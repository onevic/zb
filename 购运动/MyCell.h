//
//  MyCell.h
//  SportShopping
//
//  Created by one_vic on 13-11-20.
//  Copyright (c) 2013年 one_vic. All rights reserved.
//

#import <UIKit/UIKit.h>

@class STModelItem;
@interface MyCell : UITableViewCell

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *priceLabel;
@property (strong, nonatomic) UIButton *favouriteBtn;

- (void)layoutWithItem:(STModelItem *)item;
@end
