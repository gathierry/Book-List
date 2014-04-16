//
//  BLSettingsViewController.m
//  Book List
//
//  Created by Thierry on 14-3-23.
//  Copyright (c) 2014年 Thierry. All rights reserved.
//


#import "BLSettingsViewController.h"

@interface BLSettingsViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) UITableView *tableView;

@end

@implementation BLSettingsViewController

@synthesize tableView = _tableView;

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:FULL_FRAME style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dismissViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return SettingNumSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == SettingHelp) {
        return SettingHelpNumRows;
    }
    else if (section == SettingShare) {
        return SettingShareNumRows;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"settings cell"];
    if (cell == nil) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                       reuseIdentifier:@"settings cell"];
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section == SettingHelp) {
        if (row == SettingHelpRowCheckVersion) {
            cell.textLabel.text = @"检查更新";
        }
        else if (row == SettingHelpRowFeedBack) {
            cell.textLabel.text = @"意见反馈";
        }
        else if (row == SettingHelpRowRate) {
            cell.textLabel.text = @"去AppStore为我评分";
        }
    }
    else if (section == SettingShare) {

    }
    
    return cell;
}

#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section == SettingHelp) {
        if (row == SettingHelpRowCheckVersion) {
            [Common checkVersion];
        }
        else if (row == SettingHelpRowFeedBack) {
            [Common showMailComposer:self];
        }
        else if (row == SettingHelpRowRate) {
            [Common rateMe];
        }
    }
    else if (section == SettingShare) {

    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

@end
