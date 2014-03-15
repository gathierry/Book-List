//
//  ListTableView.h
//  Book List
//
//  Created by Thierry on 14-3-13.
//  Copyright (c) 2014年 Thierry. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ListTableViewCell.h"
#import "EditorTableViewCell.h"
#import "Book.h"

@class ListTableView;

@protocol ListTableViewDelegate <NSObject>

- (void)listTableViewDelegate:(ListTableView *)sender editBook:(Book *)book;
- (void)listTableViewDelegateRefreshData;

@end

@interface ListTableView : UIView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) BOOL inactive;
@property (nonatomic, retain) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic, retain) UIBarButtonItem *leftBarButtonItem;
@property (nonatomic, retain) UIBarButtonItem *rightBarButtonItem;
@property (nonatomic, strong) NSArray *booksArray;
@property (nonatomic, strong) UIManagedDocument *bookDatabase;

@property (nonatomic, weak) id<ListTableViewDelegate> delegate;

- (void)reloadData;

@end
