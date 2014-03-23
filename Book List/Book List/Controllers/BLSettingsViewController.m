//
//  BLSettingsViewController.m
//  Book List
//
//  Created by Thierry on 14-3-23.
//  Copyright (c) 2014年 Thierry. All rights reserved.
//

#import "BLSettingsViewController.h"

@interface BLSettingsViewController ()

@property (nonatomic, retain) UITableView *tableView;

@end

@implementation BLSettingsViewController

@synthesize tableView = _tableView;

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:VIEW_FRAME style:UITableViewStyleGrouped];
    }
    return _tableView;
}

- (void)loadView
{
    [super loadView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissViewController)];
    [self.view addSubview:self.tableView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dismissViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
