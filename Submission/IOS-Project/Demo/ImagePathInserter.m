//
//  ImagePathInserter.m
//  Demo
//
//  Created by acp16w on 14/12/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import "ImagePathInserter.h"

@implementation ImagePathInserter

-(id)pullWithId:(NSString *)iD{
    DbAccess* dbEx = [DbAccess instance];
    NSString* pullStr = [NSString stringWithFormat:IMAGE_LINKS_FOR_PLACE_ID, iD];
    
    NSMutableArray* results = [[NSMutableArray alloc]init];
    
    [dbEx selectStatement:pullStr itempulledBack:^(id result){
        [results addObject:[result objectForKey:@"PATH"]];
    }];
    
    return results;
    
}

-(bool)insertWithType:(id)param{
    DbAccess* dbEx = [DbAccess instance];
    NSString* place_id = [param objectForKey:PLACE_ID];
    NSArray* paths = [param objectForKey:PATHS];
    
    for(NSString* path in paths){
        [dbEx executeStatement: [NSString stringWithFormat:IMAGE_LINKS_INSERT_STR, path, place_id]];
    }
    
    return YES;
}

-(void)deleteForId:(NSString *)iD{
    DbAccess* dbEx = [DbAccess instance];
    NSString* query = [NSString stringWithFormat:@"DELETE FROM IMAGE_LINKS WHERE PLACE_ID = '%@'", iD];
    [dbEx executeStatement:query];
}

-(id)pullWithCustomQuery:(NSString*)query{
    DbAccess* dbEx = [DbAccess instance];

    NSMutableArray* results = [[NSMutableArray alloc]init];
    
    [dbEx selectStatement:query itempulledBack:^(id result){
        [results addObject:[result objectForKey:@"PATH"]];
    }];
    
    return results;
}

@end
