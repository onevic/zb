//
//  MenuCell.m
//  购运动
//
//  Created by one_vic on 13-11-18.
//  Copyright (c) 2013年 one_vic. All rights reserved.
//

#import "MenuCell.h"

@implementation MenuCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        _menuImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 7, 30, 30)];
        _menuImageView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_menuImageView];
        _menuTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 7, 70, 30)];
        _menuTitleLabel.backgroundColor = [UIColor clearColor];
        _menuTitleLabel.textAlignment = NSTextAlignmentCenter;
        _menuTitleLabel.font = [UIFont boldSystemFontOfSize:16];
        _menuTitleLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_menuTitleLabel];
        UIImageView *cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 42, 320, 2)];
        cutLine.image = [UIImage imageNamed:@"左滑_13.png"];
        cutLine.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:cutLine];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
