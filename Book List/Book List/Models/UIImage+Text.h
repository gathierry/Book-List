//
//  UIImage+Text.h
//  Book List
//
//  Created by Thierry on 14-3-17.
//  Copyright (c) 2014年 Thierry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Text)

-(UIImage *) drawText:(NSString *)text
              atPoint:(CGPoint)point;

@end
