//
//  CWAlertView.h
//  ColorCode
//
//  Created by Thierry on 13-5-9.
//  Copyright (c) 2013年 Thierry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CWAlertView : UIAlertView

typedef void(^CWAlertBlock)(void);

+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message
          cancelTitle:(NSString *)cancelTitle
          cancelBlock:(CWAlertBlock)cancelBlock
           otherTitle:(NSString *)otherTitle
           otherBlock:(CWAlertBlock)otherBlock;

@end
