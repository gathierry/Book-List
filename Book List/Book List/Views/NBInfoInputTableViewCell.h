//
//  NBInfoInputTableViewCell.h
//  Book List
//
//  Created by Thierry on 14-3-14.
//  Copyright (c) 2014年 Thierry. All rights reserved.
//

#import "CWSmartTableViewCell.h"

@class NBInfoInputTableViewCell;

@protocol NBInfoInputTableViewCellDelegate <NSObject>

- (void)infoInputTableViewCellDelegate:(NBInfoInputTableViewCell *)sender;

@end

#define TITLE_PADDING 20
#define GENERAL_FONT @"Helvetica-Bold"
#define LABEL_FONT [UIFont fontWithName:GENERAL_FONT size:17]
#define LABEL_TEXT_COLOR [UIColor colorWithRed:143.0/255.0 green:165.0/255.0 blue:164.0/255.0 alpha:1.0]

@interface NBInfoInputTableViewCell : CWSmartTableViewCell <UITextFieldDelegate>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, retain) UITextField *infoTextField;

@property (nonatomic, weak) id<NBInfoInputTableViewCellDelegate> delegate;

@end
