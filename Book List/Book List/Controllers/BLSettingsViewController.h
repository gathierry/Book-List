//
//  BLSettingsViewController.h
//  Book List
//
//  Created by Thierry on 14-3-23.
//  Copyright (c) 2014年 Thierry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface BLSettingsViewController : UIViewController <MFMailComposeViewControllerDelegate>

typedef enum {
    SettingHelp = 0,
    SettingData,
    SettingNumSections,
} SettingSections;

typedef enum {
    SettingHelpRowCheckVersion = 0,
    SettingHelpRowFeedBack,
    SettingHelpRowRate,
    SettingHelpRowShare,
    SettingHelpNumRows
} SettingHelpRows;

typedef enum {
    SettingDataRowiCloud = 0,
    SettingDataRowCalendar,
    SettingDataNumRows,
} SettingDataRows;

@end
