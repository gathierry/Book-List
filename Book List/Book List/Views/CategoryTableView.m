//
//  CategoryTableView.m
//  Book List
//
//  Created by Thierry on 14-3-13.
//  Copyright (c) 2014年 Thierry. All rights reserved.
//

#import "CategoryTableView.h"

@interface CategoryTableView()

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UINavigationBar *navBar;

@end

@implementation CategoryTableView

@synthesize tableView = _tableView;
@synthesize navBar = _navBar;

- (UITableView *)tableView
{
    if(!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:VIEW_FRAME];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (UINavigationBar *)navBar
{
    if (!_navBar) {
        _navBar = [[UINavigationBar alloc] initWithFrame:NAV_FRAME];
        _navBar.backgroundColor = [UIColor orangeColor];
    }
    return _navBar;
}

- (id)initWithFrame:(CGRect)frame 
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.tableView];
        [self addSubview:self.navBar];
    }
    return self;
}

#pragma mark - Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryTableViewCell *categoryTableViewCell = [CategoryTableViewCell cellForTableView:tableView];
    categoryTableViewCell.textLabel.text = @"category";
    return categoryTableViewCell;
}

#pragma mark - Delegate

@end
