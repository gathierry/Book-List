//
//  BLMainViewController.m
//  Book List
//
//  Created by Thierry on 14-3-13.
//  Copyright (c) 2014年 Thierry. All rights reserved.
//

#import "BLMainViewController.h"

@interface BLMainViewController ()

@property (nonatomic, retain) CategoryTableView *categoryTableView;
@property (nonatomic, retain) ListTableView * listTableView;
@property (nonatomic) CGPoint startPoint;
@property (nonatomic) FilterRows categorySelectedRow;

@end

@implementation BLMainViewController

@synthesize categoryTableView = _categoryTableView;
@synthesize listTableView = _listTableView;
@synthesize startPoint = _startPoint;
@synthesize bookDatabase = _bookDatabase;
@synthesize categorySelectedRow = _categorySelectedRow;

#pragma mark - Getters

- (CategoryTableView *)categoryTableView
{
    if (!_categoryTableView) {
        _categoryTableView = [[CategoryTableView alloc] initWithFrame:FULL_FRAME];
        [_categoryTableView.settingsBarButtonItem setTarget:self];
        [_categoryTableView.settingsBarButtonItem setAction:@selector(presentSettingsViewController)];
        _categoryTableView.delegate = self;
        [_categoryTableView.settingsBarButtonItem setTarget:self];
        [_categoryTableView.settingsBarButtonItem setAction:@selector(presentSettingsViewController)];
    }
    return _categoryTableView;
}

- (ListTableView *)listTableView
{
    if (!_listTableView) {
        _listTableView = [[ListTableView alloc] initWithFrame:FULL_FRAME];
        _listTableView.delegate = self;
        [_listTableView.panGestureRecognizer addTarget:self action:@selector(paningGestureReceive:)];
        [_listTableView.leftBarButtonItem setTarget:self];
        [_listTableView.leftBarButtonItem setAction:@selector(alterMode)];
        [_listTableView.rightBarButtonItem setTarget:self];
        [_listTableView.rightBarButtonItem setAction:@selector(addNewBook)];
        [_listTableView.emptyView.addButton addTarget:self action:@selector(addNewBook) forControlEvents:UIControlEventTouchUpInside];
    }
    return _listTableView;
}
#pragma mark - Setters

- (void)setBookDatabase:(UIManagedDocument *)bookDatabase
{
    if (bookDatabase != _bookDatabase) {
        _bookDatabase =bookDatabase;
    }
}

- (void)setCategorySelectedRow:(FilterRows)categorySelectedRow
{
    if (_categorySelectedRow != categorySelectedRow) {
        _categorySelectedRow = categorySelectedRow;
    }
    self.listTableView.categorySelected = _categorySelectedRow;
}

#pragma mark - Document Operation
- (void)loadDataBase:(UIManagedDocument *)document
{
    NSSortDescriptor *sortByID = [NSSortDescriptor sortDescriptorWithKey:ID_ATTRIBUTION_NAME ascending:YES];
    NSSortDescriptor *sortByDeadline = [NSSortDescriptor sortDescriptorWithKey:DDL_ATTRIBUTION_NAME ascending:YES];
    NSPredicate *predicate = nil;
    NSArray *sortArray = [NSArray array];
    if (self.categorySelectedRow == filterSectionRowAll) {
        sortArray = [NSArray arrayWithObjects:sortByDeadline, sortByID, nil];
    }
    else if (self.categorySelectedRow == filterSectionRowWishToRead) {
        predicate = [NSPredicate predicateWithFormat:@"%K == %@", FINISH_ATTRIBUTION_NAME,  [NSNumber numberWithBool:NO]];
        sortArray = [NSArray arrayWithObjects:sortByDeadline, sortByID, nil];
    }
    else if (self.categorySelectedRow == filterSectionRowFinished) {
        predicate = [NSPredicate predicateWithFormat:@"%K == %@", FINISH_ATTRIBUTION_NAME,  [NSNumber numberWithBool:YES]];
        sortArray = [NSArray arrayWithObjects:sortByID, nil];
    }
    else if (self.categorySelectedRow == filterSectionRowFavorite) {
        predicate = [NSPredicate predicateWithFormat:@"%K == %@", FAVORITE_ATTRIBUTION_NAME,  [NSNumber numberWithBool:YES]];
        sortArray = [NSArray arrayWithObjects:sortByID, nil];
    }
    
    self.listTableView.booksArray = [Common loadData:document sort:sortArray predicate:predicate];
    
    [self.listTableView reloadData];
}

- (void)useDocument
{
    //if the document doesn't exist
    if (![[NSFileManager defaultManager] fileExistsAtPath:[self.bookDatabase.fileURL path]]) {
        [self.bookDatabase saveToURL:self.bookDatabase.fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success){
            [self loadDataBase:self.bookDatabase];
        }];
    }
    //it exists but have been closed
    else if (self.bookDatabase.documentState == UIDocumentStateClosed){
        [self.bookDatabase openWithCompletionHandler:^(BOOL success){
            [self loadDataBase:self.bookDatabase];
        }];
    }
    //it's already opened
    else if (self.bookDatabase.documentState == UIDocumentStateNormal){
        [self loadDataBase:self.bookDatabase];
    }
}

#pragma mark - Gesture Recognizer

#define DISTANCE 260

- (void)alterMode
{
    if (self.listTableView.active) {
        [UIView animateWithDuration:0.3 animations:^{
            [self moveViewWithX:DISTANCE];
        } completion:^(BOOL finished) {
            self.listTableView.active = NO;
        }];
    }
    else {
        [UIView animateWithDuration:0.3 animations:^{
            [self moveViewWithX:-DISTANCE];
        } completion:^(BOOL finished) {
            self.listTableView.active = YES;
        }];
    }
}

- (void)moveViewWithX:(float)x
{
    CGRect frame = self.listTableView.frame;
    if (self.listTableView.active) {
        x = x>DISTANCE?DISTANCE:x;
        x = x<0?0:x;
        frame.origin.x = x;
    }
    else {
        x = x<-DISTANCE?-DISTANCE:x;
        x = x>0?0:x;
        frame.origin.x = DISTANCE + x;
    }
    
    self.listTableView.frame = frame;
}


- (void)paningGestureReceive:(UIPanGestureRecognizer *)recoginzer
{
    CGPoint touchPoint = [recoginzer locationInView:self.view];
    
    if (recoginzer.state == UIGestureRecognizerStateBegan) {
        self.startPoint = touchPoint;
    }else if (recoginzer.state == UIGestureRecognizerStateEnded){
        
        if (fabs(touchPoint.x - self.startPoint.x) > 50)
        {
            [self alterMode];
            
        }
        else
        {
            if (self.listTableView.active) {
                [UIView animateWithDuration:0.3 animations:^{
                    [self moveViewWithX:0];
                } completion:^(BOOL finished) {
                    self.listTableView.active = YES;
                }];
            }
            else {
                [UIView animateWithDuration:0.3 animations:^{
                    [self moveViewWithX:0];
                } completion:^(BOOL finished) {
                    self.listTableView.active = NO;
                }];
            }
        }
        return;
    }else if (recoginzer.state == UIGestureRecognizerStateCancelled){
        if (self.listTableView.active) {
            [UIView animateWithDuration:0.3 animations:^{
                [self moveViewWithX:0];
            } completion:^(BOOL finished) {
                self.listTableView.active = YES;
            }];
        }
        else {
            [UIView animateWithDuration:0.3 animations:^{
                [self moveViewWithX:0];
            } completion:^(BOOL finished) {
                self.listTableView.active = NO;
            }];
        }
        return;
    }
    else if (recoginzer.state == UIGestureRecognizerStateChanged) {
        [self moveViewWithX:touchPoint.x - self.startPoint.x];
    }
    else return;
}

#pragma mark - View Controller Lifestyle

- (void)loadView
{
    [super loadView];
    
    [self.view addSubview:self.categoryTableView];
    [self.view addSubview:self.listTableView];
    self.categorySelectedRow = filterSectionRowAll;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!self.bookDatabase) {
        NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        url = [url URLByAppendingPathComponent:@"Default Book Database"];
        self.bookDatabase = [[UIManagedDocument alloc] initWithFileURL:url];
    }
    self.listTableView.bookDatabase = self.bookDatabase;
    [self.categoryTableView.tableView reloadData];
    [self.categoryTableView.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:_categorySelectedRow inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    [self.categoryTableView tableView:self.categoryTableView.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:_categorySelectedRow inSection:0]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Delegates

- (void)listTableViewDelegate:(ListTableView *)sender editBook:(Book *)book
{
    [self presentNewBookViewControllerBookID:[book.identity intValue]];
}

- (void)listTableViewDelegateRefreshData
{
    [self loadDataBase:self.bookDatabase];
}

- (void)categoryTableViewDelegate:(CategoryTableView *)sender tableView:(UITableView *)tableView selectIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    ((UINavigationItem *)[self.listTableView.navBar.items lastObject]).title = cell.textLabel.text;
    self.listTableView.editorIndexPath = NULL;
    self.categorySelectedRow = (FilterRows)indexPath.row;
    [self useDocument];
    
    if (!self.listTableView.active) [self alterMode];
}

#pragma mark - New View Controller

- (void)addNewBook
{
    [self presentNewBookViewControllerBookID:0];
}

- (void)presentNewBookViewControllerBookID:(int)bookID
{
    NewBookViewController *nbvc = [[NewBookViewController alloc] init];
    nbvc.bookID  = bookID;
    nbvc.bookDatabase = self.bookDatabase;
    [self presentViewController:nbvc animated:YES completion:nil];
}

- (void)presentSettingsViewController
{
    //present settings controller
}

@end
