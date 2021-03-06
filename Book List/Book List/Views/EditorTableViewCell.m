//
//  EditorTableViewCell.m
//  Book List
//
//  Created by Thierry on 14-3-15.
//  Copyright (c) 2014年 Thierry. All rights reserved.
//

#import "EditorTableViewCell.h"

@interface EditorTableViewCell()
{
    UILabel *_doneLabel;
    UILabel *_favoriteLabel;
}
@end

@implementation EditorTableViewCell

@synthesize doneButton = _doneButton;
@synthesize deleteButton = _deleteButton;
@synthesize editButton = _editButton;
@synthesize favoriteButton = _favoriteButton;
@synthesize finished = _finished;
@synthesize liked = _liked;


#define BUTTON_WIDTH 44
#define BUTTON_IMAGE_WIDTH 30
#define INTERVAL_WIDTH 28
#define CELL_HEIGHT self.frame.size.height
#define TITLE_HEIGHT (EDITOR_CELL_HEIGHT - BUTTON_IMAGE_WIDTH)
#define INSET (BUTTON_WIDTH/2 - BUTTON_IMAGE_WIDTH/2)
//#define BUTTON_TINT_COLOR []

- (UIButton *)doneButton
{
    if (!_doneButton) {
        _doneButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _doneButton.tintColor = MAIN_COLOR;
        _doneButton.imageEdgeInsets = UIEdgeInsetsMake(0, INSET, TITLE_HEIGHT, INSET);
        [_doneButton setFrame:CGRectMake(INTERVAL_WIDTH, 0, BUTTON_WIDTH, CELL_HEIGHT)];
    }
    return _doneButton;
}

- (UIButton *)deleteButton
{
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _deleteButton.tintColor = MAIN_COLOR;
        [_deleteButton setImage:[UIImage imageNamed:@"Trash.png"] forState:UIControlStateNormal];
        _deleteButton.imageEdgeInsets = UIEdgeInsetsMake(0, INSET, TITLE_HEIGHT, INSET);
        [_deleteButton setFrame:CGRectMake(INTERVAL_WIDTH * 2 + BUTTON_WIDTH, 0, BUTTON_WIDTH, CELL_HEIGHT)];
    }
    return _deleteButton;
}

- (UIButton *)editButton
{
    if (!_editButton) {
        _editButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _editButton.tintColor = MAIN_COLOR;
        [_editButton setImage:[UIImage imageNamed:@"Edit.png"] forState:UIControlStateNormal];
        _editButton.imageEdgeInsets = UIEdgeInsetsMake(0, INSET, TITLE_HEIGHT, INSET);
        [_editButton setFrame:CGRectMake(INTERVAL_WIDTH * 3 + BUTTON_WIDTH * 2, 0, BUTTON_WIDTH, CELL_HEIGHT)];
    }
    return _editButton;
}

- (UIButton *)favoriteButton
{
    if (!_favoriteButton) {
        _favoriteButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _favoriteButton.tintColor = MAIN_COLOR;
        _favoriteButton.imageEdgeInsets = UIEdgeInsetsMake(0, INSET, TITLE_HEIGHT, INSET);
        [_favoriteButton setFrame:CGRectMake(INTERVAL_WIDTH * 4 + BUTTON_WIDTH * 3, 0, BUTTON_WIDTH, CELL_HEIGHT)];
    }
    return _favoriteButton;
}

- (void)setLiked:(BOOL)liked
{
    if (_liked != liked) {
        _liked = liked;
    }
    if (_liked) {
        [_favoriteButton setImage:[UIImage imageNamed:@"liked.png"] forState:UIControlStateNormal];
        _favoriteLabel.text = @"喜欢";
    }
    else {
        [_favoriteButton setImage:[UIImage imageNamed:@"like.png"] forState:UIControlStateNormal];
        _favoriteLabel.text = @"喜欢";
    }
}

- (void)setFinished:(BOOL)finished
{
    if (_finished != finished) {
        _finished = finished;
    }
    if (_finished) {
        [_doneButton setImage:[UIImage imageNamed:@"finished.png"] forState:UIControlStateNormal];
        _doneLabel.text = @"未读";
    }
    else {
        [_doneButton setImage:[UIImage imageNamed:@"finish.png"] forState:UIControlStateNormal];
        _doneLabel.text = @"读完";
    }
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
        
        _doneLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.doneButton.frame.origin.x, BUTTON_IMAGE_WIDTH + 1, BUTTON_WIDTH, TITLE_HEIGHT)];
        _doneLabel.textAlignment = NSTextAlignmentCenter;
        _doneLabel.font = [UIFont systemFontOfSize:11];
        [self addSubview:_doneLabel];
        
        UILabel *deleteLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.deleteButton.frame.origin.x, BUTTON_IMAGE_WIDTH + 1, BUTTON_WIDTH, TITLE_HEIGHT)];
        deleteLabel.text = @"删除";
        deleteLabel.textAlignment = NSTextAlignmentCenter;
        deleteLabel.font = [UIFont systemFontOfSize:11];
        [self addSubview:deleteLabel];
        
        UILabel *editLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.editButton.frame.origin.x, BUTTON_IMAGE_WIDTH + 1, BUTTON_WIDTH, TITLE_HEIGHT)];
        editLabel.text = @"编辑";
        editLabel.textAlignment = NSTextAlignmentCenter;
        editLabel.font = [UIFont systemFontOfSize:11];
        [self addSubview:editLabel];
        
        _favoriteLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.favoriteButton.frame.origin.x, BUTTON_IMAGE_WIDTH + 1, BUTTON_WIDTH, TITLE_HEIGHT)];
        _favoriteLabel.textAlignment = NSTextAlignmentCenter;
        _favoriteLabel.font = [UIFont systemFontOfSize:11];
        [self addSubview:_favoriteLabel];
    }
    return self;
}

@end
