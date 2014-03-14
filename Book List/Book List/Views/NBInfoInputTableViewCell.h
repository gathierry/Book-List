//
//  NBInfoInputTableViewCell.h
//  Book List
//
//  Created by Thierry on 14-3-14.
//  Copyright (c) 2014年 Thierry. All rights reserved.
//

#import "CWSmartTableViewCell.h"

@interface NBInfoInputTableViewCell : CWSmartTableViewCell

@property (nonatomic, strong) NSString *title;
@property (nonatomic, retain) UITextField *infoTextField;

@end
