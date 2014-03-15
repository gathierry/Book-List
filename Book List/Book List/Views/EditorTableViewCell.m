//
//  EditorTableViewCell.m
//  Book List
//
//  Created by Thierry on 14-3-15.
//  Copyright (c) 2014年 Thierry. All rights reserved.
//

#import "EditorTableViewCell.h"

@implementation EditorTableViewCell

@synthesize doneButton = _doneButton;
@synthesize deleteButton = _deleteButton;
@synthesize editButton = _editButton;
@synthesize favoriteButton = _favoriteButton;


#define BUTTON_WIDTH 25
#define INTERVAL_WIDTH 44

- (UIButton *)doneButton
{
    if (!_doneButton) {
        _doneButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_doneButton setTintColor:[UIColor blackColor]];
        [_doneButton setImage:[UIImage imageNamed:@"Tick.png"] forState:UIControlStateNormal];
        [_doneButton setFrame:CGRectMake(INTERVAL_WIDTH, 0, BUTTON_WIDTH, BUTTON_WIDTH)];
    }
    return _doneButton;
}

- (UIButton *)deleteButton
{
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_deleteButton setTintColor:[UIColor blackColor]];
        [_deleteButton setImage:[UIImage imageNamed:@"Trash.png"] forState:UIControlStateNormal];
        [_deleteButton setFrame:CGRectMake(INTERVAL_WIDTH * 2 + BUTTON_WIDTH, 0, BUTTON_WIDTH, BUTTON_WIDTH)];
    }
    return _deleteButton;
}

- (UIButton *)editButton
{
    if (!_editButton) {
        _editButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_editButton setTintColor:[UIColor blackColor]];
        [_editButton setImage:[UIImage imageNamed:@"Edit.png"] forState:UIControlStateNormal];
        [_editButton setFrame:CGRectMake(INTERVAL_WIDTH * 3 + BUTTON_WIDTH * 2, 0, BUTTON_WIDTH, BUTTON_WIDTH)];
    }
    return _editButton;
}

- (UIButton *)favoriteButton
{
    if (!_favoriteButton) {
        _favoriteButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_favoriteButton setTintColor:[UIColor blackColor]];
        [_favoriteButton setImage:[UIImage imageNamed:@"favorite.png"] forState:UIControlStateNormal];
        [_favoriteButton setFrame:CGRectMake(INTERVAL_WIDTH * 4 + BUTTON_WIDTH * 3, 0, BUTTON_WIDTH, BUTTON_WIDTH)];
    }
    return _favoriteButton;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
        
        [self addSubview:self.doneButton];
        [self addSubview:self.deleteButton];
        [self addSubview:self.editButton];
        [self addSubview:self.favoriteButton];
        
        UILabel *doneLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.doneButton.frame.origin.x, BUTTON_WIDTH + 1, BUTTON_WIDTH, 16)];
        doneLabel.text = @"读完";
        doneLabel.textAlignment = NSTextAlignmentCenter;
        doneLabel.font = [UIFont systemFontOfSize:10];
        [self addSubview:doneLabel];
        
        UILabel *deleteLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.deleteButton.frame.origin.x, BUTTON_WIDTH + 1, BUTTON_WIDTH, 16)];
        deleteLabel.text = @"删除";
        deleteLabel.textAlignment = NSTextAlignmentCenter;
        deleteLabel.font = [UIFont systemFontOfSize:10];
        [self addSubview:deleteLabel];
        
        UILabel *editLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.editButton.frame.origin.x, BUTTON_WIDTH + 1, BUTTON_WIDTH, 16)];
        editLabel.text = @"编辑";
        editLabel.textAlignment = NSTextAlignmentCenter;
        editLabel.font = [UIFont systemFontOfSize:10];
        [self addSubview:editLabel];
        
        UILabel *favoriteLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.favoriteButton.frame.origin.x, BUTTON_WIDTH + 1, BUTTON_WIDTH, 16)];
        favoriteLabel.text = @"喜欢";
        favoriteLabel.textAlignment = NSTextAlignmentCenter;
        favoriteLabel.font = [UIFont systemFontOfSize:10];
        [self addSubview:favoriteLabel];
    }
    return self;
}

@end
