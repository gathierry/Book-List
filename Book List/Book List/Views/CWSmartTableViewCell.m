//
//  CWSmartTableViewCell.m
//  ColorCode
//
//  Created by Thierry on 13-4-13.
//  Copyright (c) 2013年 Thierry. All rights reserved.
//

#import "CWSmartTableViewCell.h"

@implementation CWSmartTableViewCell

@synthesize indexPath = _indexPath;

+ (NSString *)cellIdentifier
{
    return NSStringFromClass([self class]);
}

+ (id)cellForTableView:(UITableView *)tableView
{
    NSString *cellID = [self cellIdentifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}


@end
