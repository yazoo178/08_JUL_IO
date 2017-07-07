//
//  DbAccess.h
//  Demo
//
//  Created by Will on 08/10/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "DbTableCreator.h"
#import "Constants.h"


@interface DbAccess : NSObject

@property (strong, nonatomic) NSString* dbSourcePath;
@property (strong, nonatomic) DbTableCreator* dbCreator;

- (id) init __attribute__((unavailable("You cannot create a new instance of this object, use instance method instead")));
- (void)loaddb;

//Used for inserting data
- (void)executeStatement:(NSString*)query;

//Used for returning data. Delegates the data returned back to the caller
//to load in model of choice
- (void)selectStatement:(NSString*)query itempulledBack:(void(^)(id item))val;

//Singleton instance to prevent multiple db connections..
+ (DbAccess *)instance;

@end