//
//  FavePlaceInserter.m
//  Demo
//
//  Created by Will on 15/10/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import "FavePlaceInserter.h"
#import <GooglePlacePicker/GooglePlacePicker.h>
#import "Place.h"
#import "Constants.h"

@implementation FavePlaceInserter


-(void)deleteForId:(NSString *)iD{
    DbAccess* dbEx = [DbAccess instance];
    NSString* query = [NSString stringWithFormat:@"DELETE FROM FAVE_PLACES WHERE PLACE_ID = '%@'", iD];
    [dbEx executeStatement:query];
}

-(bool)insertWithType:(id)param{
    DbAccess* dbEx = [DbAccess instance];
    Place* place = param;
    
    NSString* inserter = [NSString stringWithFormat:PLACE_INSERT_STR,
                          [place.placeId stringByReplacingOccurrencesOfString:@"'" withString:@"''"],
                          [place.placeName stringByReplacingOccurrencesOfString:@"'" withString:@"''"],
                          [place.placePhone stringByReplacingOccurrencesOfString:@"'" withString:@"''"],
                          [place.placeWebsite stringByReplacingOccurrencesOfString:@"'" withString:@"''"],
                          [place.placeAddress stringByReplacingOccurrencesOfString:@"'" withString:@"''"],
                          [place.placeComments stringByReplacingOccurrencesOfString:@"'" withString:@"''"]];
    
    NSString* existingChecker = [NSString stringWithFormat: @"SELECT 1 FROM FAVE_PLACES WHERE PLACE_ID ='%@'", place.placeId];

    bool __block existing = false;
    [dbEx selectStatement:existingChecker itempulledBack:^(id result){
        existing = true;
    }];
    
    if(!existing){
        [dbEx executeStatement:inserter];
    }
    
    else{
        
        NSString* updater = [NSString stringWithFormat:PLACE_UPDATE_STR,
                              [place.placeName stringByReplacingOccurrencesOfString:@"'" withString:@"''"],
                              [place.placePhone stringByReplacingOccurrencesOfString:@"'" withString:@"''"],
                              [place.placeWebsite stringByReplacingOccurrencesOfString:@"'" withString:@"''"],
                              [place.placeAddress stringByReplacingOccurrencesOfString:@"'" withString:@"''"],
                              [place.placeComments stringByReplacingOccurrencesOfString:@"'" withString:@"''"],
                              [place.placeId stringByReplacingOccurrencesOfString:@"'" withString:@"''"]];
        
        [dbEx selectStatement:updater itempulledBack:nil];
    }
    
    return YES;
}

-(id)pullWithId:(NSString*)iD{
    NSString* pullStr = [NSString stringWithFormat: @"SELECT * FROM FAVE_PLACES WHERE PLACE_ID ='%@'", iD];
    return [[self pullWithCustomQuery:pullStr]firstObject];
}

-(id)pullWithCustomQuery:(NSString *)query{
    DbAccess* dbEx = [DbAccess instance];

    NSMutableArray* results = [[NSMutableArray alloc]init];
    
    [dbEx selectStatement:query itempulledBack:^(id result){
        Place* place = [[Place alloc]initWithId:[result objectForKey:PLACE_ID]];
        place.placeComments = [result objectForKey:COMMENTS];
        place.placeAddress = [result objectForKey:ADDRESS];
        place.placePhone = [result objectForKey:PHONE];
        place.placeWebsite = [result objectForKey:WEBSITE];
        place.placeName = [result objectForKey:NAME];
        [results addObject:place];
        
    }];
    
    return results;
}

@end
