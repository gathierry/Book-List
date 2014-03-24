//
//  Common.h
//  Book List
//
//  Created by Thierry on 14-3-15.
//  Copyright (c) 2014年 Thierry. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CWAlertView.h"

#define BOOK_ENTITY_NAME @"Book"
#define ID_ATTRIBUTION_NAME @"identity"
#define DDL_ATTRIBUTION_NAME @"deadline"
#define FINISH_ATTRIBUTION_NAME @"finish"
#define FAVORITE_ATTRIBUTION_NAME @"favorite"
#define MAIN_COLOR [UIColor colorWithRed:233.0/255.0 green:102.0/255.0 blue:28.0/255.0 alpha:1.0]
#define NAV_BAR_HEIGHT 64
#define NAV_FRAME CGRectMake(0, 0, SCREEN_WIDTH, NAV_BAR_HEIGHT)
#define VIEW_FRAME CGRectMake(0, NAV_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_BAR_HEIGHT)
#define FULL_FRAME CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)

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

+ (void)setExtraCellLineHidden: (UITableView *)tableView;
+ (void)checkVersion;
+ (void)rateMe;
+ (void)showMailComposer:(UIViewController *)controller;
@end
