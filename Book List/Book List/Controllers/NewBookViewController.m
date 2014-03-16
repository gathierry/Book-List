//
//  NewBookViewController.m
//  Book List
//
//  Created by Thierry on 14-3-14.
//  Copyright (c) 2014年 Thierry. All rights reserved.
//

#import "NewBookViewController.h"

@interface NewBookViewController () <NBInfoInputTableViewCellDelegate>

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UINavigationBar *navBar;
@property (nonatomic) BOOL pickingDate;
@property (nonatomic, retain) UITextField *titleTextField;
@property (nonatomic, retain) UITextField *remarkTextField;
@property (nonatomic, strong) Book *book;

@end

@implementation NewBookViewController

@synthesize tableView = _tableView;
@synthesize navBar = _navBar;
@synthesize titleTextField = _titleTextField;
@synthesize remarkTextField = _remarkTextField;
@synthesize bookDatabase = _bookDatabase;
@synthesize pickingDate = _pickingDate;
@synthesize bookID = _bookID;

#pragma mark - Getters

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
        if (_bookID) {
            item.title = @"编辑信息";
        }
        item.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(leftBarButtonItemPressed)];
        item.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(rightBarButtonItemPressed)];
        _navBar.items = @[item];
    }
    return _navBar;
}

#pragma mark - Navigation Actions

- (void)rightBarButtonItemPressed
{
    if (self.titleTextField.text.length > 0) {
        if (_bookID) {
            [Common updateData:self.bookDatabase book:self.book title:self.titleTextField.text remark:self.remarkTextField.text deadline:((NBDeadlineTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:OptionInfoRowDeadline inSection:OptionInfo]]).date finish:[self.book.finish boolValue] favorite:[self.book.favorite boolValue]];
        }
        else {
            [Common saveData:self.bookDatabase title:self.titleTextField.text remark:self.remarkTextField.text ID:[Common refreshBookId] deadline:((NBDeadlineTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:OptionInfoRowDeadline inSection:OptionInfo]]).date finish:NO favorite:NO];
        }
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
    else {
        [CWAlertView showWithTitle:@"内容不能为空" message:@"请填写必要信息" cancelTitle:@"好" cancelBlock:nil otherTitle:nil otherBlock:nil];
    }
}

- (void)leftBarButtonItemPressed
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Date Picker Actions

- (void)displayInlineDatePickerForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.pickingDate = !self.pickingDate;
    NSIndexPath *pickerIndexPath = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section];
    [self.tableView beginUpdates];
    
    if (self.pickingDate) {
        [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:pickerIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    else {
        [[self.tableView cellForRowAtIndexPath:pickerIndexPath].contentView.subviews.lastObject removeFromSuperview];;
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:pickerIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    
    [self.tableView endUpdates];
}

- (void)synDateInTableViewCell:(UIDatePicker *)sender
{
    NBDeadlineTableViewCell *cell = (NBDeadlineTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:OptionInfoRowDeadline inSection:OptionInfo]];
    [cell setDate:sender.date];
    
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return NBNumSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == NecessaryInfo) return NecessaryInfoNumRows;
    else if (section == OptionInfo) return OptionInfoNumRows + self.pickingDate;
    else return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (indexPath.section == OptionInfo && indexPath.row == OptionInfoRowDatePicker) ? 216 : 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NBInfoInputTableViewCell *cell = [NBInfoInputTableViewCell cellForTableView:tableView];
    cell.delegate = self;
    if (indexPath.section == NecessaryInfo) {
        if (indexPath.row == NecessaryInfoRowTitle) {
            cell.title = @"书名";
            cell.infoTextField.text = self.book.title;
            self.titleTextField = cell.infoTextField;
        }
    }
    else if (indexPath.section == OptionInfo) {
        if (indexPath.row == OptionInfoRowRemark) {
            cell.title = @"详细信息";
            cell.infoTextField.text = self.book.remark;
            self.remarkTextField = cell.infoTextField;
        }
        else if (indexPath.row == OptionInfoRowDeadline) {
            NBDeadlineTableViewCell *ddlCell = [NBDeadlineTableViewCell cellForTableView:tableView];
            ddlCell.date = self.book.deadline;
            return ddlCell;
        }
        else if (indexPath.row == OptionInfoRowDatePicker) {
            UITableViewCell * dpCell = [tableView dequeueReusableCellWithIdentifier:@"datePicker"];
            if (dpCell == nil) dpCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                              reuseIdentifier:@"datePicker"];
            UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:dpCell.contentView.frame];
            datePicker.datePickerMode = UIDatePickerModeDate;
            datePicker.minimumDate = [NSDate date];
            [datePicker addTarget:self action:@selector(synDateInTableViewCell:) forControlEvents:UIControlEventValueChanged];
            [dpCell.contentView addSubview:datePicker];
            return dpCell;
        }
    }
    return cell;
}

#pragma mark - Table View Delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if ([self.titleTextField isFirstResponder]) [self.titleTextField resignFirstResponder];
    if ([self.remarkTextField isFirstResponder]) [self.remarkTextField resignFirstResponder];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == NecessaryInfo) {
        if (indexPath.row == NecessaryInfoRowTitle) {
            
        }
    }
    else if (indexPath.section == OptionInfo) {
        if (indexPath.row == OptionInfoRowRemark) {
            
        }
        else if (indexPath.row == OptionInfoRowDeadline) {
            [self scrollViewWillBeginDragging:tableView];
            [self displayInlineDatePickerForRowAtIndexPath:indexPath];
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
        }
    }
}

#pragma mark - NBInfoInputTableViewCell Delegate
- (void)infoInputTableViewCellDelegate:(NBInfoInputTableViewCell *)sender
{
    if (self.pickingDate) {
        [self displayInlineDatePickerForRowAtIndexPath:[NSIndexPath indexPathForRow:OptionInfoRowDeadline inSection:OptionInfo]];
    }
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
    if (_bookID) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@", ID_ATTRIBUTION_NAME, [NSNumber numberWithInt:_bookID]];
        NSArray *array = [Common loadData:self.bookDatabase sort:nil predicate:predicate];
        self.book = [array lastObject];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end
