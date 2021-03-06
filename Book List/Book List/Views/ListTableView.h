//
//  ListTableView.h
//  Book List
//
//  Created by Thierry on 14-3-13.
//  Copyright (c) 2014年 Thierry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "ListTableViewCell.h"
#import "EditorTableViewCell.h"
#import "Book.h"
#import "UIImage+Text.h"
#import "CategoryTableView.h"
#import "EmptyView.h"

@class ListTableView;

@protocol ListTableViewDelegate <NSObject>

- (void)listTableViewDelegate:(ListTableView *)sender editBook:(Book *)book;
- (void)listTableViewDelegateRefreshData;

@end

@interface ListTableView : UIView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) BOOL active;
@property (nonatomic, retain) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic, retain) UIBarButtonItem *leftBarButtonItem;
@property (nonatomic, retain) UIBarButtonItem *rightBarButtonItem;
@property (nonatomic, strong) NSArray *booksArray;
@property (nonatomic, strong) UIManagedDocument *bookDatabase;
@property (nonatomic, retain) UINavigationBar *navBar;
@property (nonatomic, strong) NSIndexPath *editorIndexPath;
@property (nonatomic) FilterRows categorySelected;
@property (nonatomic, retain) EmptyView *emptyView;
@property (nonatomic, retain) UISearchBar *searchBar;

@property (nonatomic, weak) id<ListTableViewDelegate> delegate;

- (void)reloadData;

@end
