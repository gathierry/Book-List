//
//  ListTableView.m
//  Book List
//
//  Created by Thierry on 14-3-13.
//  Copyright (c) 2014年 Thierry. All rights reserved.
//

#import "ListTableView.h"

@interface ListTableView()

@property (nonatomic, retain) UITableView *tableView;

@end

@implementation ListTableView

@synthesize tableView = _tableView;
@synthesize inactive = _inactive;
@synthesize panGestureRecognizer = _panGestureRecognizer;

- (UITableView *)tableView
{
    if(!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:VIEW_FRAME];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (UIPanGestureRecognizer *)panGestureRecognizer
{
    if (!_panGestureRecognizer) {
        _panGestureRecognizer = [[UIPanGestureRecognizer alloc] init];
    }
    return _panGestureRecognizer;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.tableView];
        [self addGestureRecognizer:self.panGestureRecognizer];
    }
    return self;
}

#pragma mark - Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return @[@"1", @"2"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListTableViewCell *listTableViewCell = [ListTableViewCell cellForTableView:tableView];
    listTableViewCell.textLabel.text = @"list";
    return listTableViewCell;
}

#pragma mark - Delegate


@end
