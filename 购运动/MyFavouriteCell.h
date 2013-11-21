//
//  MyFavouriteCell.h
//  SportShopping
//
//  Created by one_vic on 13-11-21.
//  Copyright (c) 2013年 one_vic. All rights reserved.
//

#import <UIKit/UIKit.h>

@class STModelItem;
@interface MyFavouriteCell : UITableViewCell
{
    UIImageView *_cover1;
    UIImageView *_cover2;
    
}
@property (strong, nonatomic) UIImageView *imageView1;
@property (strong, nonatomic) UIImageView *imageView2;
@property (strong, nonatomic) UILabel *priceLabel1;
@property (strong, nonatomic) UILabel *priceLabel2;


@property (strong, nonatomic) STModelItem *item1;
@property (strong, nonatomic) STModelItem *item2;

- (void)layoutWithItem1:(STModelItem *)item1 andItem2:(STModelItem *)item2;

@end
