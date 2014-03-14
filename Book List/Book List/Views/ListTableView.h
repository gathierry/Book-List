//
//  ListTableView.h
//  Book List
//
//  Created by Thierry on 14-3-13.
//  Copyright (c) 2014年 Thierry. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ListTableViewCell.h"

@interface ListTableView : UIView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) BOOL inactive;
@property (nonatomic, retain) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic, retain) UIBarButtonItem *leftBarButtonItem;
@property (nonatomic, retain) UIBarButtonItem *rightBarButtonItem;

@end
