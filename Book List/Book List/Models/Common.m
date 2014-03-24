//
//  Common.m
//  Book List
//
//  Created by Thierry on 14-3-15.
//  Copyright (c) 2014年 Thierry. All rights reserved.
//

#import <SystemConfiguration/SystemConfiguration.h>
#import <netdb.h>
#import <MessageUI/MessageUI.h>

#import "Common.h"

@implementation Common

+ (NSString *)dateToString:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //[formatter setDateFormat:@"dd/MM/yyyy"];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    return [formatter stringFromDate:date];
}

#define BOOK_ID @"bookID"

+ (NSNumber *)refreshBookId
{
    NSUserDefaults *userDefault =  [NSUserDefaults standardUserDefaults];
    NSNumber *lastID = [userDefault objectForKey:BOOK_ID];
    if (!lastID) {
        lastID = [NSNumber numberWithInteger:10];
    }
    NSInteger newID =  [lastID integerValue] + 1;
    
    [userDefault setObject:[NSNumber numberWithInteger:newID] forKey:BOOK_ID];
    [userDefault synchronize];
    return [NSNumber numberWithInteger:newID];
}

+ (void)saveData:(UIManagedDocument *)document
           title:(NSString *)title
          remark:(NSString *)remark
              ID:(NSNumber *)identity
        deadline:(NSDate *)deadline
          finish:(BOOL)finish
        favorite:(BOOL)favorite
{
    Book *oneBook = [NSEntityDescription insertNewObjectForEntityForName:BOOK_ENTITY_NAME inManagedObjectContext:document.managedObjectContext];
    oneBook.title = title;
    oneBook.remark = remark;
    oneBook.identity = identity;
    oneBook.deadline = deadline;
    oneBook.finish = [NSNumber numberWithBool:finish];
    oneBook.favorite = [NSNumber numberWithBool:favorite];
    NSError *error;
    [document.managedObjectContext save:&error];
    [document saveToURL:document.fileURL forSaveOperation:UIDocumentSaveForOverwriting completionHandler:nil];
}

+ (NSArray *)loadData:(UIManagedDocument *)document sort:(NSArray *)sorts predicate:(NSPredicate *)predicate
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:BOOK_ENTITY_NAME inManagedObjectContext:document.managedObjectContext];
    NSError *error = nil;
    if (sorts.count) request.sortDescriptors = sorts;
    if (predicate) request.predicate = predicate;
    NSArray *fetchResultArray = [document.managedObjectContext executeFetchRequest:request error:&error];
    return fetchResultArray;
}

+ (void)updateData:(UIManagedDocument *)document
              book:(Book *)oneBook
           title:(NSString *)title
          remark:(NSString *)remark
        deadline:(NSDate *)deadline
          finish:(BOOL)finish
        favorite:(BOOL)favorite
{
    oneBook.title = title;
    oneBook.remark = remark;
    oneBook.deadline = deadline;
    oneBook.finish = [NSNumber numberWithBool:finish];
    oneBook.favorite = [NSNumber numberWithBool:favorite];
    NSError *error;
    [document.managedObjectContext save:&error];
    [document saveToURL:document.fileURL forSaveOperation:UIDocumentSaveForOverwriting completionHandler:nil];
}

+ (void)deleteData:(UIManagedDocument *)document object:(Book *)book
{
    [document.managedObjectContext deleteObject:book];
    NSError *error;
    [document.managedObjectContext save:&error];
    [document saveToURL:document.fileURL forSaveOperation:UIDocumentSaveForOverwriting completionHandler:nil];
}

+ (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    [tableView setTableHeaderView:view];
}

+ (BOOL) checkNetWorkIsOk{
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags) {
        return NO;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    BOOL nonWifi = flags & kSCNetworkReachabilityFlagsTransientConnection;
    BOOL moveNet = flags & kSCNetworkReachabilityFlagsIsWWAN;
    
    return ((isReachable && !needsConnection) || nonWifi || moveNet) ? YES : NO;
}

+ (NSDictionary *)getAppStoreInfo
{
    NSURL *url = [NSURL URLWithString:APP_URL];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSDictionary *results = data?[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:nil]:nil;
    return results;
}

+ (void)checkVersion
{
    if (![Common checkNetWorkIsOk]) {
        [CWAlertView showWithTitle:@"无网络环境" message:@"请检查网络连接后重试" cancelTitle:@"好的" cancelBlock:nil otherTitle:nil otherBlock:nil];
        return;
    }
    dispatch_queue_t checkVersionQueue = dispatch_queue_create("check version", NULL);
    dispatch_async(checkVersionQueue, ^{
        NSDictionary *results = [Common getAppStoreInfo];
        NSString *version = [[[results objectForKey:@"results"] lastObject] objectForKey:@"version"];
        NSURL *trackViewUrl = [NSURL URLWithString:[[[results objectForKey:@"results"] lastObject] objectForKey:@"trackViewUrl"]];
        BOOL upToDate = ([version floatValue] == [CurrentAppVersion floatValue]);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!upToDate) {
                [CWAlertView showWithTitle:@"应用有更新" message:@"本应用的最新版本可以在AppStore下载" cancelTitle:@"下次再说" cancelBlock:nil otherTitle:@"去下载" otherBlock:^{
                    [[UIApplication sharedApplication] openURL:trackViewUrl];
                }];
            }
        });
    });
}

+ (void)rateMe
{
    dispatch_queue_t rateQueue = dispatch_queue_create("rate Q", NULL);
    dispatch_async(rateQueue, ^{
        NSDictionary *results = [Common getAppStoreInfo];
        NSURL *trackViewUrl = [NSURL URLWithString:[[[results objectForKey:@"results"] lastObject] objectForKey:@"trackViewUrl"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication] openURL:trackViewUrl];
        });
    });
}

+ (void)showMailComposer:(UIViewController *)controller
{
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    if (mailClass != nil) {
        if ([mailClass canSendMail]) {
            MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
            picker.mailComposeDelegate = (BLSettingsViewController *)controller;
            NSArray *reception = [[NSArray alloc] init];
            reception = [NSArray arrayWithObjects:@"lishiyu.thierry@gmail.com", nil];
            [picker setToRecipients:reception];
            [controller presentViewController:picker animated:YES completion:nil];
        }
        else {
            [CWAlertView showWithTitle:@"设备不支持发送邮件" message:@"" cancelTitle:@"取消" cancelBlock:nil otherTitle:nil otherBlock:nil];
        }
    }
}

@end
