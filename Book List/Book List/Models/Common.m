//
//  Common.m
//  Book List
//
//  Created by Thierry on 14-3-15.
//  Copyright (c) 2014年 Thierry. All rights reserved.
//

#import "Common.h"

@implementation Common

+ (NSString *)dateToString:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //[formatter setDateFormat:@"dd/MM/yyyy"];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
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
    Book *oneBook = [NSEntityDescription insertNewObjectForEntityForName:@"Book" inManagedObjectContext:document.managedObjectContext];
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

+ (NSArray *)loadData:(UIManagedDocument *)document sort:(NSSortDescriptor *)sort predicate:(NSPredicate *)predicate
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:@"Book" inManagedObjectContext:document.managedObjectContext];
    NSError *error = nil;
    if (sort) request.sortDescriptors = [NSArray arrayWithObject:sort];
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

@end
