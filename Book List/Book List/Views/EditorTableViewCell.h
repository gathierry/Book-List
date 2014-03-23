//
//  EditorTableViewCell.h
//  Book List
//
//  Created by Thierry on 14-3-15.
//  Copyright (c) 2014年 Thierry. All rights reserved.
//

#import "CWSmartTableViewCell.h"

#define EDITOR_CELL_HEIGHT 44

@interface EditorTableViewCell : CWSmartTableViewCell

@property (nonatomic, retain) UIButton *doneButton;
@property (nonatomic, retain) UIButton *deleteButton;
@property (nonatomic, retain) UIButton *editButton;
@property (nonatomic, retain) UIButton *favoriteButton;

@property (nonatomic) BOOL finished;
@property (nonatomic) BOOL liked;

@end
