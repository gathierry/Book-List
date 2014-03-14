//
//  Common.m
//  Book List
//
//  Created by Thierry on 14-3-15.
//  Copyright (c) 2014年 Thierry. All rights reserved.
//

#import "Common.h"

@implementation Common

+ (NSString *)dateToString:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    return [formatter stringFromDate:date];
}

@end
