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
@synthesize active = _active;
@synthesize panGestureRecognizer = _panGestureRecognizer;
@synthesize navBar = _navBar;
@synthesize leftBarButtonItem = _leftBarButtonItem;
@synthesize rightBarButtonItem = _rightBarButtonItem;
@synthesize booksArray = _booksArray;
@synthesize editorIndexPath = _editorIndexPath;
@synthesize bookDatabase = _bookDatabase;
@synthesize delegate = _delegate;
@synthesize categorySelected = _categorySelected;
@synthesize emptyView = _emptyView;
@synthesize searchBar = _searchBar;

#pragma mark - Getters

- (UITableView *)tableView
{
    if(!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:VIEW_FRAME];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [Common setExtraCellLineHidden:_tableView];
        _tableView.tableHeaderView = self.searchBar;
    }
    return _tableView;
}

- (UINavigationBar *)navBar
{
    if (!_navBar) {
        _navBar = [[UINavigationBar alloc] initWithFrame:NAV_FRAME];
        [_navBar setTranslucent:NO];
         _navBar.tintColor = MAIN_COLOR;
        UINavigationItem *item = [[UINavigationItem alloc] init];
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

- (EmptyView *)emptyView
{
    if (!_emptyView) {
        _emptyView = [[EmptyView alloc] initWithFrame:self.tableView.frame];
    }
    return _emptyView;
}

- (UISearchBar *)searchBar
{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        _searchBar.placeholder = @"输入要搜索的书名";
        _searchBar.barTintColor = [UIColor clearColor];
        _searchBar.searchBarStyle = UISearchBarStyleMinimal;
    }
    return _searchBar;
}

- (void)setActive:(BOOL)active
{
    if (_active != active) {
        _active = active;
    }
    self.tableView.userInteractionEnabled = active;
}

- (void)setBooksArray:(NSArray *)booksArray
{
    if (_booksArray != booksArray) {
        _booksArray = booksArray;
        if (!_booksArray.count && self.categorySelected == filterSectionRowAll) {
            [self addSubview:self.emptyView];
        }
        else {
            [self.emptyView removeFromSuperview];
        }
    }
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.tableView];
        [self addSubview:self.navBar];
        [self addGestureRecognizer:self.panGestureRecognizer];
        self.layer.shadowColor = [UIColor grayColor].CGColor;
        self.layer.shadowRadius = 2.0f;
        self.layer.shadowOffset = CGSizeMake(-2, 0);
        self.layer.masksToBounds = NO;
        self.layer.shadowOpacity = 1.0;
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
            self.editorIndexPath = NULL;
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:nextIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            
        }
        else {
            //need to close one editor and open another
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:self.editorIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            if ([indexPath compare:self.editorIndexPath] == NSOrderedAscending) {
                [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:nextIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                self.editorIndexPath = nextIndexPath;
            }
            else {
                [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                self.editorIndexPath = indexPath;
            }
        }
    }
    [self.tableView endUpdates];
}

- (void)doneButtonPressed
{
    Book *book = [self.booksArray objectAtIndex:self.editorIndexPath.row - 1];
    [Common updateData:self.bookDatabase book:book title:book.title remark:book.remark deadline:book.deadline finish:![book.finish boolValue] favorite:[book.favorite boolValue]];
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.editorIndexPath.row - 1 inSection:self.editorIndexPath.section], self.editorIndexPath] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)deleteButtonPressed
{
    Book *book = [self.booksArray objectAtIndex:self.editorIndexPath.row - 1];
    [Common deleteData:self.bookDatabase object:book];
    self.editorIndexPath = NULL;
    [self.delegate listTableViewDelegateRefreshData];
    
}

- (void)editButtonPressed
{
    [self.delegate listTableViewDelegate:self editBook:[self.booksArray objectAtIndex:self.editorIndexPath.row - 1]];
}

- (void)favoriteButtonPressed
{
    Book *book = [self.booksArray objectAtIndex:self.editorIndexPath.row - 1];
    [Common updateData:self.bookDatabase book:book title:book.title remark:book.remark deadline:book.deadline finish:[book.finish boolValue] favorite:![book.favorite boolValue]];
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.editorIndexPath.row - 1 inSection:self.editorIndexPath.section], self.editorIndexPath] withRowAnimation:UITableViewRowAnimationNone];
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
    Book *book;
    if (self.editorIndexPath && [indexPath compare:self.editorIndexPath] == NSOrderedSame) {
        book = [self.booksArray objectAtIndex:indexPath.row - 1];
        EditorTableViewCell *editorTableViewCell = [EditorTableViewCell cellForTableView:tableView];
        editorTableViewCell.liked = [book.favorite boolValue];
        editorTableViewCell.finished = [book.finish boolValue];
        [editorTableViewCell.doneButton addTarget:self action:@selector(doneButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [editorTableViewCell.deleteButton addTarget:self action:@selector(deleteButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [editorTableViewCell.editButton addTarget:self action:@selector(editButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [editorTableViewCell.favoriteButton addTarget:self action:@selector(favoriteButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        return editorTableViewCell;
    }
    ListTableViewCell *listTableViewCell = [ListTableViewCell cellForTableView:tableView];
    if (self.editorIndexPath &&[indexPath compare:self.editorIndexPath] == NSOrderedDescending) {
        book = [self.booksArray objectAtIndex:indexPath.row - 1];
    }
    else {
        book = [self.booksArray objectAtIndex:indexPath.row];
    }
    
    listTableViewCell.textLabel.text = book.title;
    listTableViewCell.detailTextLabel.text = book.remark;
    listTableViewCell.textLabel.textColor = [book.favorite boolValue] && (_categorySelected == filterSectionRowAll)? [UIColor colorWithRed:202.0/255.0 green:38.0/255.0 blue:96.0/255.0 alpha:0.5] : [UIColor blackColor];
    NSTimeInterval interval = [book.deadline timeIntervalSinceNow];
    int i = (int)(interval/86400) + 1;
    UIImage *image = [book.finish boolValue] ? [UIImage imageNamed:@"check.png"] : [[UIImage imageNamed:@"calendar.png"] drawText:[NSString stringWithFormat:@"%d", i] atPoint:CGPointMake(10, 15)];
    [listTableViewCell.button setImage:image forState:UIControlStateNormal];
    listTableViewCell.button.tag = [book.identity integerValue];
    return listTableViewCell;
}

#pragma mark - Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath compare:self.editorIndexPath] == NSOrderedSame) {
        return EDITOR_CELL_HEIGHT;
    }
    return LIST_CELL_HEIGHT;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([indexPath compare:self.editorIndexPath] != NSOrderedSame) {
        [self displayEditingRowAtIndex:indexPath];
    }
}

@end
