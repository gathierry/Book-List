//
//  Book.h
//  Book List
//
//  Created by Thierry on 14-3-16.
//  Copyright (c) 2014年 Thierry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Book : NSManagedObject

@property (nonatomic, retain) NSDate * deadline;
@property (nonatomic, retain) NSNumber * favorite;
@property (nonatomic, retain) NSNumber * finish;
@property (nonatomic, retain) NSNumber * identity;
@property (nonatomic, retain) NSString * remark;
@property (nonatomic, retain) NSString * title;

@end
