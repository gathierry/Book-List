//
//  Common.h
//  Book List
//
//  Created by Thierry on 14-3-15.
//  Copyright (c) 2014年 Thierry. All rights reserved.
//

#import <Foundation/Foundation.h>

#define BOOK_ENTITY_NAME @"Book"
#define ID_ATTRIBUTION_NAME @"identity"
#define DDL_ATTRIBUTION_NAME @"deadline"
#define FINISH_ATTRIBUTION_NAME @"finish"
#define FAVORITE_ATTRIBUTION_NAME @"favorite"

@interface Common : NSObject

+ (NSString *)dateToString:(NSDate *)date;
+ (NSNumber *)refreshBookId;
+ (void)saveData:(UIManagedDocument *)document
           title:(NSString *)title
          remark:(NSString *)remark
              ID:(NSNumber *)id
        deadline:(NSDate *)deadline
          finish:(BOOL)finish
        favorite:(BOOL)favorite;
+ (void)updateData:(UIManagedDocument *)document
              book:(Book *)oneBook
             title:(NSString *)title
            remark:(NSString *)remark
          deadline:(NSDate *)deadline
            finish:(BOOL)finish
          favorite:(BOOL)favorite;
+ (NSArray *)loadData:(UIManagedDocument *)document sort:(NSArray *)sorts predicate:(NSPredicate *)predicate;
+ (void)deleteData:(UIManagedDocument *)document object:(Book *)book;
@end
