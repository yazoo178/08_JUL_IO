//
//  DbSampleController.m
//  Demo
//
//  Created by Will on 07/10/2016.
//  Copyright © 2016 Will. All rights reserved.
//
//testing
#import "DbSampleController.h"
#import "DbTableCreator.h"
#import "Constants.h"

@implementation DbSampleController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addtoDb:(id)sender{
     NSString* insert = [NSString stringWithFormat:@"INSERT INTO USERREVIEWS (NAME_OF_LOCATION, REVIEW_SCORE) VALUES ('%@',%@)", self.FirstName.text, self.LastName.text];
    
    DbAccess* dbCaller = [DbAccess instance];
    
    [dbCaller executeStatement:insert];
}

@end
