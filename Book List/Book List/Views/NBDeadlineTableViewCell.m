//
//  NBDeadlineTableViewCell.m
//  Book List
//
//  Created by Thierry on 14-3-14.
//  Copyright (c) 2014年 Thierry. All rights reserved.
//

#import "NBDeadlineTableViewCell.h"

@interface NBDeadlineTableViewCell()

@property (nonatomic, retain) UILabel *dateLabel;

@end

@implementation NBDeadlineTableViewCell

@synthesize date = _date;
@synthesize dateLabel = _dateLabel;

- (void)setDate:(NSDate *)date
{
    if (date != _date) {
        _date = date;
        self.dateLabel.text = [Common dateToString:date];
    }
}

- (UILabel *)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(TITLE_PADDING, 0, self.frame.size.width - 2 * TITLE_PADDING, self.frame.size.height)];
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        _dateLabel.text = [Common dateToString:[NSDate date]];
    }
    return  _dateLabel;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(TITLE_PADDING, 0, self.frame.size.width - 2 * TITLE_PADDING, self.frame.size.height)];
        label1.text = @"我要在";
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(TITLE_PADDING, 0, self.frame.size.width - 2 * TITLE_PADDING, self.frame.size.height)];
        label2.textAlignment = NSTextAlignmentRight;
        label2.text = @"之前读完";
        [self addSubview:label1];
        [self addSubview:label2];
        [self addSubview:self.dateLabel];
        
    }
    return self;
}

@end
