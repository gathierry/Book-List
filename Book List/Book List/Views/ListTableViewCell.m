//
//  ListTableViewCell.m
//  Book List
//
//  Created by Thierry on 14-3-13.
//  Copyright (c) 2014年 Thierry. All rights reserved.
//

#import "ListTableViewCell.h"

@implementation ListTableViewCell

@synthesize button = _button;

- (UIButton *)button
{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeSystem];
        [_button setFrame:CGRectMake(0, 0, LIST_CELL_HEIGHT, LIST_CELL_HEIGHT)];
        [_button setImageEdgeInsets:UIEdgeInsetsMake(15, 15, 15, 15)];
        _button.backgroundColor = [UIColor whiteColor];
        _button.tintColor = MAIN_COLOR;
    }
    return _button;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.button];
        self.imageView.image = [UIImage imageNamed:@"transparent.png"];
    }
    return self;
}

@end
