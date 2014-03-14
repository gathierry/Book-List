//
//  NewBookViewController.h
//  Book List
//
//  Created by Thierry on 14-3-14.
//  Copyright (c) 2014年 Thierry. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NBInfoInputTableViewCell.h"
#import "NBDeadlineTableViewCell.h"
#import "Book.h"
#import "CWAlertView.h"

@interface NewBookViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

typedef enum {
    NecessaryInfo = 0,
    OptionInfo,
    NBNumSections
} NBSections;

typedef enum {
    NecessaryInfoRowTitle = 0,
    NecessaryInfoNumRows
} NecessaryInfoRows;

typedef enum {
    OptionInfoRowRemark = 0,
    OptionInfoRowDeadline,
    OptionInfoNumRows
} OptionInfoRows;

#define OptionInfoRowDatePicker OptionInfoNumRows

@property (nonatomic, strong) UIManagedDocument *bookDatabase;

@end
