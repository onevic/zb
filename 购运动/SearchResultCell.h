//
//  SearchResultCell.h
//  SportShopping
//
//  Created by one_vic on 13-11-20.
//  Copyright (c) 2013年 one_vic. All rights reserved.
//

#import <UIKit/UIKit.h>

@class STModelItem;
@interface SearchResultCell : UITableViewCell

@property (strong, nonatomic) UIImageView *mImageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *priceLabel;
@property (strong, nonatomic) UIButton *payBtn;

@property (strong, nonatomic) STModelItem *item;
- (void)layoutWithItem:(STModelItem *)item;

@end

