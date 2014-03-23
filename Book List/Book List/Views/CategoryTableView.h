//
//  CategoryTableView.h
//  Book List
//
//  Created by Thierry on 14-3-13.
//  Copyright (c) 2014年 Thierry. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CategoryTableViewCell.h"

@class CategoryTableView;

@protocol  CategoryTableViewDelegate <NSObject>

- (void)categoryTableViewDelegate:(CategoryTableView *)sender tableView:(UITableView *)tableView selectIndexPath:(NSIndexPath *)indexPath;

@end

@interface CategoryTableView : UIView <UITableViewDataSource, UITableViewDelegate>

typedef enum {
    filterSection = 0,
    CategoryNumSections
    
} CategorySections;

typedef enum {
    filterSectionRowAll = 0,
    filterSectionRowWishToRead,
    filterSectionRowFinished,
    filterSectionRowFavorite,
    filterSectionNumRows
} FilterRows;

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UIButton *settingsButton;

@property (nonatomic, weak) id<CategoryTableViewDelegate> delegate;

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end
