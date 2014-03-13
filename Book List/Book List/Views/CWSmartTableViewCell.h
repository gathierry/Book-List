//
//  CWSmartTableViewCell.h
//  ColorCode
//
//  Created by Thierry on 13-4-13.
//  Copyright (c) 2013年 Thierry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CWSmartTableViewCell : UITableViewCell

@property (nonatomic, strong) NSIndexPath *indexPath;

+ (id)cellForTableView:(UITableView *)tableView;

@end
