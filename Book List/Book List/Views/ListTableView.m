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
@property (nonatomic, retain) UINavigationBar *navBar;
@property (nonatomic, strong) NSIndexPath *editorIndexPath;

@end

@implementation ListTableView

@synthesize tableView = _tableView;
@synthesize inactive = _inactive;
@synthesize panGestureRecognizer = _panGestureRecognizer;
@synthesize navBar = _navBar;
@synthesize leftBarButtonItem = _leftBarButtonItem;
@synthesize rightBarButtonItem = _rightBarButtonItem;
@synthesize booksArray = _booksArray;
@synthesize editorIndexPath = _editorIndexPath;
@synthesize bookDatabase = _bookDatabase;
@synthesize delegate = _delegate;

#pragma mark - Getters

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
        UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:@"书单"];
        item.leftBarButtonItem = self.leftBarButtonItem;
        item.rightBarButtonItem = self.rightBarButtonItem;
        _navBar.items = @[item];
    }
    return _navBar;
}

- (UIBarButtonItem *)rightBarButtonItem
{
    if (!_rightBarButtonItem) {
        _rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:nil action:nil];
    }
    return _rightBarButtonItem;
}

- (UIBarButtonItem *)leftBarButtonItem
{
    if (!_leftBarButtonItem) {
        _leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"list.png"] style:UIBarButtonItemStylePlain target:nil action:nil];
    }
    return _leftBarButtonItem;
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
        [self addSubview:self.navBar];
        [self addGestureRecognizer:self.panGestureRecognizer];
    }
    return self;
}

- (void)reloadData
{
    [self.tableView reloadData];
}

#pragma mark - Actions

- (void)displayEditingRowAtIndex:(NSIndexPath *)indexPath
{
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section];
    [self.tableView beginUpdates];
    if (self.editorIndexPath == NULL) {
        //no editor open one
        self.editorIndexPath = nextIndexPath;
        [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:self.editorIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    else {
        if ([self.editorIndexPath compare:nextIndexPath] == NSOrderedSame) {
            //need to close the editor
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:nextIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            self.editorIndexPath = NULL;
        }
        else {
            //need to close one editor and open another
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:self.editorIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:nextIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            self.editorIndexPath = nextIndexPath;
        }
    }
    [self.tableView endUpdates];
}

- (void)doneButtonPressed
{
    Book *book = [self.booksArray objectAtIndex:self.editorIndexPath.row - 1];
    book.finish = [NSNumber numberWithBool:![book.finish boolValue]];
    [Common saveData:self.bookDatabase title:book.title remark:book.remark ID:book.identity deadline:book.deadline finish:[book.finish boolValue] favorite:[book.favorite boolValue]];
}

- (void)deleteButtonPressed
{
    //delete from database
}

- (void)editButtonPressed
{
    [self.delegate listTableViewDelegate:self book:[self.booksArray objectAtIndex:self.editorIndexPath.row - 1]];
}

- (void)favoriteButtonPressed
{
    Book *book = [self.booksArray objectAtIndex:self.editorIndexPath.row - 1];
    book.favorite = [NSNumber numberWithBool:![book.favorite boolValue]];
    [Common saveData:self.bookDatabase title:book.title remark:book.remark ID:book.identity deadline:book.deadline finish:[book.finish boolValue] favorite:[book.favorite boolValue]];
}

#pragma mark - Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.booksArray.count + (self.editorIndexPath != NULL);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.editorIndexPath && [indexPath compare:self.editorIndexPath] == NSOrderedSame) {
        EditorTableViewCell *editorTableViewCell = [EditorTableViewCell cellForTableView:tableView];
        [editorTableViewCell.doneButton addTarget:self action:@selector(doneButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [editorTableViewCell.deleteButton addTarget:self action:@selector(deleteButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [editorTableViewCell.editButton addTarget:self action:@selector(editButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [editorTableViewCell.favoriteButton addTarget:self action:@selector(favoriteButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        return editorTableViewCell;
    }
    ListTableViewCell *listTableViewCell = [ListTableViewCell cellForTableView:tableView];
    Book *book;
    
    if (self.editorIndexPath &&[indexPath compare:self.editorIndexPath] == NSOrderedDescending) {
        book = [self.booksArray objectAtIndex:indexPath.row - 1];
    }
    else {
        book = [self.booksArray objectAtIndex:indexPath.row];
    }
    listTableViewCell.textLabel.text = book.title;
    listTableViewCell.detailTextLabel.text = book.remark;
    if ([book.favorite boolValue]) {
        listTableViewCell.textLabel.textColor = [UIColor purpleColor];
    }
    return listTableViewCell;
}

#pragma mark - Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath compare:self.editorIndexPath] != NSOrderedSame) {
        [self displayEditingRowAtIndex:indexPath];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

@end
