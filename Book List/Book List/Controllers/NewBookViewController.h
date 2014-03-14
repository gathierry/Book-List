//
//  NewBookViewController.h
//  Book List
//
//  Created by Thierry on 14-3-14.
//  Copyright (c) 2014年 Thierry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "NBInfoInputTableViewCell.h"

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
    OptionInfoRowDeadline = 0,
    OptionInfoRowRemark,
    OptionInfoNumRows
} OptionInfoRows;

@end
