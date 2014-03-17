//
//  CategoryTableView.m
//  Book List
//
//  Created by Thierry on 14-3-13.
//  Copyright (c) 2014年 Thierry. All rights reserved.
//

#import "CategoryTableView.h"

@interface CategoryTableView()

@property (nonatomic, retain) UINavigationBar *navBar;

@end

@implementation CategoryTableView

@synthesize tableView = _tableView;
@synthesize navBar = _navBar;
@synthesize delegate = _delegate;
@synthesize settingsBarButtonItem = _settingsBarButtonItem;

#define BACKGROUND_COLOR [UIColor colorWithWhite:0.95 alpha:1.0]

- (UITableView *)tableView
{
    if(!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:VIEW_FRAME];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = BACKGROUND_COLOR;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorColor = [UIColor colorWithWhite:0.3 alpha:1.0];
    }
    return _tableView;
}

- (UINavigationBar *)navBar
{
    if (!_navBar) {
        _navBar = [[UINavigationBar alloc] initWithFrame:NAV_FRAME];
        _navBar.backgroundColor = BACKGROUND_COLOR;
        UINavigationItem *item = [[UINavigationItem alloc] init];
        item.title = @"Book List";
        //item.rightBarButtonItem = self.settingsBarButtonItem;
        _navBar.items = @[item];
    }
    return _navBar;
}

- (UIBarButtonItem *)settingsBarButtonItem
{
    if (!_settingsBarButtonItem) {
        _settingsBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"settings.png"] style:UIBarButtonItemStylePlain target:nil action:nil];
    }
    return _settingsBarButtonItem;
}

- (id)initWithFrame:(CGRect)frame 
{
    self = [super initWithFrame:frame];
    if (self) {
        [Common setExtraCellLineHidden:self.tableView];
        [self addSubview:self.tableView];
        [self addSubview:self.navBar];
        [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]].selected = YES;
    }
    return self;
}

#pragma mark - Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return CategoryNumSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == stantardSection) {
        return stantardSectionNumRows;
    };
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryTableViewCell *categoryTableViewCell = [CategoryTableViewCell cellForTableView:tableView];
    if (indexPath.section == stantardSection) {
        categoryTableViewCell.textLabel.font = [UIFont systemFontOfSize:15.0];
        if (indexPath.row == stantardSectionRowAll) {
            categoryTableViewCell.imageView.image = [UIImage imageNamed:@"book.png"];
            categoryTableViewCell.textLabel.text = @"全部书单";
        }
        else if (indexPath.row == stantardSectionRowWishToRead) {
            categoryTableViewCell.imageView.image = [UIImage imageNamed:@"look.png"];
            categoryTableViewCell.textLabel.text = @"想读的书";
        }
        else if (indexPath.row == stantardSectionRowFinished) {
            categoryTableViewCell.imageView.image = [UIImage imageNamed:@"folder.png"];
            categoryTableViewCell.textLabel.text = @"读过的书";
        }
        else if (indexPath.row == stantardSectionRowFavorite) {
            categoryTableViewCell.imageView.image = [UIImage imageNamed:@"star.png"];
            categoryTableViewCell.textLabel.text = @"我的最爱";
        }
    }
    return categoryTableViewCell;
}

#pragma mark - Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate categoryTableViewDelegate:self tableView:tableView selectIndexPath:indexPath];
}

@end
