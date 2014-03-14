//
//  CWAlertView.m
//  ColorCode
//
//  Created by Thierry on 13-5-9.
//  Copyright (c) 2013年 Thierry. All rights reserved.
//

#import "CWAlertView.h"

@interface CWAlertView() <UIAlertViewDelegate>

@property (nonatomic, copy) CWAlertBlock cancelBlock;
@property (nonatomic, copy) CWAlertBlock otherBlock;
@property (nonatomic, copy) NSString *cancelButtonTitle;
@property (nonatomic, copy) NSString *otherButtonTitle;

@end

@implementation CWAlertView

@synthesize cancelBlock = _cancelBlock;
@synthesize otherBlock = _otherBlock;
@synthesize cancelButtonTitle = _cancelButtonTitle;
@synthesize otherButtonTitle = _otherButtonTitle;

- (id)initWithTitle:(NSString *)title
              message:(NSString *)message
          cancelTitle:(NSString *)cancelTitle
          cancelBlock:(CWAlertBlock)cancelBlk
           otherTitle:(NSString *)otherTitle
           otherBlock:(CWAlertBlock)otherBlk
{
    if (self == [super initWithTitle:title message:message delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:otherTitle, nil]) {
        if (cancelBlk == nil && otherTitle == nil) {
            self.delegate = nil;
        }
        self.cancelButtonTitle = cancelTitle;
        self.otherButtonTitle = otherTitle;
        self.cancelBlock = cancelBlk;
        self.otherBlock = otherBlk;
    }
    return self;
}

+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message
          cancelTitle:(NSString *)cancelTitle
          cancelBlock:(CWAlertBlock)cancelBlock
           otherTitle:(NSString *)otherTitle
           otherBlock:(CWAlertBlock)otherBlock
{
    [[[self alloc] initWithTitle:title message:message cancelTitle:cancelTitle cancelBlock:cancelBlock otherTitle:otherTitle otherBlock:otherBlock] show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *buttonTitle = [alertView buttonTitleAtIndex:buttonIndex];
    if ([buttonTitle isEqualToString:self.cancelButtonTitle]) {
        if (self.cancelBlock) {
            self.cancelBlock();
        }
    }
    if ([buttonTitle isEqualToString:self.otherButtonTitle]) {
        if (self.otherBlock) {
            self.otherBlock();
        }
    }
}

@end
