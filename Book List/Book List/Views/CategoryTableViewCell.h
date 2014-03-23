//
//  CategoryTableViewCell.h
//  Book List
//
//  Created by Thierry on 14-3-13.
//  Copyright (c) 2014年 Thierry. All rights reserved.
//

#import "CWSmartTableViewCell.h"

#define CATEGORY_CELL_HEIGHT 40

#define BOOK_CELL_ID @"book"
#define LOOK_CELL_ID @"look"
#define FOLDER_CELL_ID @"folder"
#define STAR_CELL_ID @"star"

@interface CategoryTableViewCell : CWSmartTableViewCell

@property (nonatomic, strong) NSString *cellID;

@end
