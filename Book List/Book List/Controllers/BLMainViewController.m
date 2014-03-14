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
        [_listTableView.panGestureRecognizer addTarget:self action:@selector(paningGestureReceive:)];
        [_listTableView.leftBarButtonItem setTarget:self];
        [_listTableView.leftBarButtonItem setAction:@selector(alterMode)];
        [_listTableView.rightBarButtonItem setTarget:self];
        [_listTableView.rightBarButtonItem setAction:@selector(addNewBook)];
    }
    return _listTableView;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)addNewBook
{
    NewBookViewController *nbvc = [[NewBookViewController alloc] init];
    [self presentViewController:nbvc animated:YES completion:nil];
}

@end
