//
//  UIImage+Text.m
//  Book List
//
//  Created by Thierry on 14-3-17.
//  Copyright (c) 2014年 Thierry. All rights reserved.
//

#import "UIImage+Text.h"

@implementation UIImage (Text)

-(UIImage *) drawText:(NSString *)text
             atPoint:(CGPoint)point
{
    
    UIFont *font = [UIFont boldSystemFontOfSize:18];
    UIColor *color = [UIColor colorWithRed:53.0/255.0 green:67.0/255.0 blue:77.0/255.0 alpha:1.0];
    UIGraphicsBeginImageContext(self.size);
    [self drawInRect:CGRectMake(0,0,self.size.width,self.size.height)];
    CGPoint center = CGPointMake(self.size.width / 2, self.size.height / 2);
    CGRect rect = CGRectMake(center.x - (text.length * 9 / 2.0), center.y - 6, self.size.width, self.size.height);
    [[UIColor whiteColor] set];
    [text drawInRect:CGRectIntegral(rect) withAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, color, NSForegroundColorAttributeName, nil]];;
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
