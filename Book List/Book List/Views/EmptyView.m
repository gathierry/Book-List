//
//  EmptyView.m
//  Book List
//
//  Created by Thierry on 14-3-17.
//  Copyright (c) 2014年 Thierry. All rights reserved.
//

#import "EmptyView.h"

@implementation EmptyView

@synthesize addButton = _addButton;

#define ORIGIN_X 100
#define ORIGIN_Y 100
#define WIDTH (frame.size.width - 2 * ORIGIN_X)

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImage *image = [UIImage imageNamed:@"TableViewBackgroundColor.png"];
        UIImageView *imageView =  [[UIImageView alloc] initWithImage:image];
        [imageView setFrame:CGRectMake(ORIGIN_X, ORIGIN_Y, WIDTH, WIDTH/image.size.width*image.size.height)];
        [self addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X, ORIGIN_Y + imageView.frame.size.height + 50, WIDTH, 30)];
        label.text = @"你的书单还是空的";
        label.font = [UIFont systemFontOfSize:15.0];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        
        self.addButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.addButton setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
        [self.addButton setTitle:@"添加第一本书" forState:UIControlStateNormal];
        [self.addButton setFrame:CGRectMake(ORIGIN_X, label.frame.origin.y + label.frame.size.height, WIDTH, 30)];
        [self addSubview:self.addButton];
        
        
    }
    return self;
}

@end
