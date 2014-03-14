//
//  NewBookViewController.m
//  Book List
//
//  Created by Thierry on 14-3-14.
//  Copyright (c) 2014年 Thierry. All rights reserved.
//

#import "NewBookViewController.h"

@interface NewBookViewController ()

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UINavigationBar *navBar;
@property (nonatomic, retain) UITextField *titleTextField;
@property (nonatomic, retain) UITextField *remarkTextField;

@end

@implementation NewBookViewController

@synthesize tableView = _tableView;
@synthesize navBar = _navBar;
@synthesize titleTextField = _titleTextField;
@synthesize remarkTextField = _remarkTextField;

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:VIEW_FRAME style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (UINavigationBar *)navBar
{
    if (!_navBar) {
        _navBar = [[UINavigationBar alloc] initWithFrame:NAV_FRAME];
        UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:@"添加新书"];
        item.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(leftBarButtonItemPressed)];
        item.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(rightBarButtonItemPressed)];
        _navBar.items = @[item];
    }
    return _navBar;
}

- (void)rightBarButtonItemPressed
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)leftBarButtonItemPressed
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return NBNumSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == NecessaryInfo) return NecessaryInfoNumRows;
    else if (section == OptionInfo) return OptionInfoNumRows;
    else return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NBInfoInputTableViewCell *cell = [NBInfoInputTableViewCell cellForTableView:tableView];
    if (indexPath.section == NecessaryInfo) {
        if (indexPath.row == NecessaryInfoRowTitle) {
            cell.title = @"新书";
            self.titleTextField = cell.infoTextField;
        }
        else if (indexPath.row == NecessaryInfoRowRemark) {
            cell.title = @"详细信息";
            self.remarkTextField = cell.infoTextField;
        }
    }
    else if (indexPath.section == OptionInfo) {
        
    }
    return cell;
}

#pragma mark - Table View Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([self.titleTextField isFirstResponder]) [self.titleTextField resignFirstResponder];
    if ([self.remarkTextField isFirstResponder]) [self.remarkTextField resignFirstResponder];
}




#pragma mark - View Controller Lifestyle

- (void)loadView
{
    [super loadView];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.navBar];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
