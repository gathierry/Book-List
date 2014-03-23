//
//  CategoryTableViewCell.m
//  Book List
//
//  Created by Thierry on 14-3-13.
//  Copyright (c) 2014年 Thierry. All rights reserved.
//

#import "CategoryTableViewCell.h"

@interface CategoryTableViewCell()

@property (nonatomic, retain) UIImageView *cImageView;

@end


@implementation CategoryTableViewCell

@synthesize cellID = _cellID;
@synthesize cImageView = _cImageView;

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    if (selected) {
        self.backgroundColor = [UIColor whiteColor];
        self.cImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@-selected.png", self.cellID]];
    }
    else {
        self.backgroundColor = [UIColor clearColor];
        self.cImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", self.cellID]];
    }
}

- (UIImageView *)cImageView
{
    if (!_cImageView) {
        _cImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 5, 30, 30)];
    }
    return _cImageView;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.imageView.image = [UIImage imageNamed:@"transparent.png"];
        [self addSubview:self.cImageView];
    }
    return self;
}

@end
