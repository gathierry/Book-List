//
//  BLMainViewController.h
//  Book List
//
//  Created by Thierry on 14-3-13.
//  Copyright (c) 2014年 Thierry. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CategoryTableView.h"
#import "ListTableView.h"
#import "NewBookViewController.h"
#import "BLSettingsViewController.h"

@interface BLMainViewController : UIViewController <ListTableViewDelegate, CategoryTableViewDelegate>

@property (nonatomic, strong) UIManagedDocument *bookDatabase;

@end
