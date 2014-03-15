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

@end

@implementation BLMainViewController

@synthesize categoryTableView = _categoryTableView;
@synthesize listTableView = _listTableView;
@synthesize startPoint = _startPoint;
@synthesize bookDatabase = _bookDatabase;

#pragma mark - Getters

- (CategoryTableView *)categoryTableView
{
    if (!_categoryTableView) {
        _categoryTableView = [[CategoryTableView alloc] initWithFrame:FULL_FRAME];
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

#pragma mark - Document Operation
- (void)loadDataBase:(UIManagedDocument *)document
{
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES selector:@selector(localizedStandardCompare:)];
    self.listTableView.booksArray = [Common loadData:document sort:sort predicate:nil];
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
    if (!self.listTableView.inactive) {
        [UIView animateWithDuration:0.3 animations:^{
            [self moveViewWithX:DISTANCE];
        } completion:^(BOOL finished) {
            self.listTableView.inactive = YES;
        }];
    }
    else {
        [UIView animateWithDuration:0.3 animations:^{
            [self moveViewWithX:-DISTANCE];
        } completion:^(BOOL finished) {
            self.listTableView.inactive = NO;
        }];
    }
}

- (void)moveViewWithX:(float)x
{
    CGRect frame = self.listTableView.frame;
    if (!self.listTableView.inactive) {
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
    
    float scale = (frame.origin.x/DISTANCE/20)+0.95;
    
    self.categoryTableView.transform = CGAffineTransformMakeScale(scale, scale);
    
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
            if (!self.listTableView.inactive) {
                [UIView animateWithDuration:0.3 animations:^{
                    [self moveViewWithX:0];
                } completion:^(BOOL finished) {
                    self.listTableView.inactive = NO;
                }];
            }
            else {
                [UIView animateWithDuration:0.3 animations:^{
                    [self moveViewWithX:0];
                } completion:^(BOOL finished) {
                    self.listTableView.inactive = YES;
                }];
            }
        }
        return;
    }else if (recoginzer.state == UIGestureRecognizerStateCancelled){
        if (!self.listTableView.inactive) {
            [UIView animateWithDuration:0.3 animations:^{
                [self moveViewWithX:0];
            } completion:^(BOOL finished) {
                self.listTableView.inactive = NO;
            }];
        }
        else {
            [UIView animateWithDuration:0.3 animations:^{
                [self moveViewWithX:0];
            } completion:^(BOOL finished) {
                self.listTableView.inactive = YES;
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
    [self useDocument];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)listTableViewDelegate:(ListTableView *)sender book:(Book *)book
{
    [self presentNewBookViewControllerBookID:[book.identity intValue]];
}

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

@end
