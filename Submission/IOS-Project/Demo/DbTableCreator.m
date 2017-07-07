//
//  DbTableCreator.m
//  Demo
//
//  Created by Will on 09/10/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import "DbTableCreator.h"

@implementation DbTableCreator

-(id)initDbCreator{
    self = [super init];
    if(self){
        self.dbCreators =  [[NSMutableArray alloc]init];
    }
    return self;
}

-(void)addDbStr:(NSString *)name{
    [self.dbCreators addObject:name];
}

@end
