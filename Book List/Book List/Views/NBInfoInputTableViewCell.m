//
//  NBInfoInputTableViewCell.m
//  Book List
//
//  Created by Thierry on 14-3-14.
//  Copyright (c) 2014年 Thierry. All rights reserved.
//

#import "NBInfoInputTableViewCell.h"

@implementation NBInfoInputTableViewCell

@synthesize title = _title;
@synthesize infoTextField = _infoTextField;

#define TITLE_PADDING 20
#define GENERAL_FONT @"Helvetica-Bold"
#define LABEL_FONT [UIFont fontWithName:GENERAL_FONT size:17]
#define LABEL_TEXT_COLOR [UIColor colorWithRed:143.0/255.0 green:165.0/255.0 blue:164.0/255.0 alpha:1.0]

- (void)setTitle:(NSString *)title
{
    if (_title != title) _title = title;
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(TITLE_PADDING, 0, self.frame.size.width - 2 * TITLE_PADDING, self.frame.size.height)];
    textField.font = LABEL_FONT;
    textField.placeholder = title;
    textField.textColor = LABEL_TEXT_COLOR;
    [textField setBorderStyle:UITextBorderStyleNone];
    [textField setTextAlignment:NSTextAlignmentLeft];
    [textField setAutocapitalizationType:UITextAutocapitalizationTypeSentences];
    [textField setAutocorrectionType:UITextAutocorrectionTypeDefault];
    [textField setReturnKeyType:UIReturnKeyDone];
    textField.delegate = self;
    [self addSubview:textField];
    self.infoTextField = textField;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

#pragma mark - Text Field Delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
