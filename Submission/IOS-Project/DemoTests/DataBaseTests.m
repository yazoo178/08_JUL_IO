//
//  DataBaseTests.m
//  miCity
//
//  Created by Will on 18/01/2017.
//  Copyright © 2017 Will. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FavePlaceInserter.h"
#import "HighScoresInserter.h"
#import "Highscore.h"
#import "Place.h"
#import "ImagePathInserter.h"

@interface DataBaseTests : XCTestCase

@end

@implementation DataBaseTests



- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testDeleteFavePlace{
    FavePlaceInserter* inserter = [[FavePlaceInserter alloc]init];
    Place* place = [[Place alloc]init];
    place.placeId = @"0000";
    place.placeName = @"Test Place";
    place.placePhone = @"000000";
    place.placeAddress = @"Test Street";
    place.placeWebsite = @"www.google.com";
    place.placeComments = @"comments";
    [inserter insertWithType:place];
    Place* returnType = [inserter pullWithId:@"0000"];
    [inserter deleteForId:place.placeId];
    returnType = [inserter pullWithId:@"0000"];
    XCTAssertNil(returnType);
}

- (void)testInsertPlace {
    FavePlaceInserter* inserter = [[FavePlaceInserter alloc]init];
    Place* place = [[Place alloc]init];
    place.placeId = @"0000";
    place.placeName = @"Test Place";
    place.placePhone = @"000000";
    place.placeAddress = @"Test Street";
    place.placeWebsite = @"www.google.com";
    place.placeComments = @"comments";
    [inserter insertWithType:place];
    Place* returnType = [inserter pullWithId:@"0000"];
    XCTAssertNotNil(returnType);
    [inserter deleteForId:place.placeId];
}

- (void)testHighScoreInsert{
    HighScoresInserter* inserter = [[HighScoresInserter alloc]init];
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc]init];
    [dict setObject:@"Testing" forKey:@"NAME"];
    [dict setObject:@"0" forKey:@"SCORE"];
    [dict setObject:@"happy" forKey:@"GAME_EMOTION"];
    [dict setObject:[NSString stringWithFormat:@"%d", -1] forKey:@"WAVE"];
    [inserter insertWithType:dict];
    NSMutableArray * results = [inserter pullWithCustomQuery:@"SELECT * FROM HIGHSCORES WHERE WAVE = -1"];
    XCTAssertTrue([results count] > 0);
    Highscore * score = [results firstObject];
    [inserter deleteForId:score.Id];
}

- (void)testHighScoreDelete{
    HighScoresInserter* inserter = [[HighScoresInserter alloc]init];
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc]init];
    [dict setObject:@"Testing" forKey:@"NAME"];
    [dict setObject:@"0" forKey:@"SCORE"];
    [dict setObject:@"happy" forKey:@"GAME_EMOTION"];
    [dict setObject:[NSString stringWithFormat:@"%d", -1] forKey:@"WAVE"];
    [inserter insertWithType:dict];
    NSMutableArray * results = [inserter pullWithCustomQuery:@"SELECT * FROM HIGHSCORES WHERE WAVE = -1"];
    Highscore * score = [results firstObject];
    [inserter deleteForId:score.Id];
    results = [inserter pullWithCustomQuery:@"SELECT * FROM HIGHSCORES WHERE WAVE = -1"];
    XCTAssertTrue([results count] == 0);
    
}

- (void)testImageInsert{
    ImagePathInserter* inserter = [[ImagePathInserter alloc]init];
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc]init];
    NSArray* paths = [[NSArray alloc]initWithObjects:@"path", nil];
    [dict setObject:@"0000" forKey:PLACE_ID];
    [dict setObject:paths forKey:PATHS];
    [inserter insertWithType:dict];
    NSString* query = [NSString stringWithFormat:@"SELECT * FROM IMAGE_LINKS WHERE PLACE_ID = '%@'", @"0000"];
    NSMutableArray* results = [inserter pullWithCustomQuery:query];
    XCTAssertTrue([results count] > 0);
    [inserter deleteForId:@"0000"];
    
}

- (void)testImageDelete{
    ImagePathInserter* inserter = [[ImagePathInserter alloc]init];
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc]init];
    NSArray* paths = [[NSArray alloc]initWithObjects:@"path", nil];
    [dict setObject:@"0000" forKey:PLACE_ID];
    [dict setObject:paths forKey:PATHS];
    [inserter insertWithType:dict];
    NSString* query = [NSString stringWithFormat:@"SELECT * FROM IMAGE_LINKS WHERE PLACE_ID = '%@'", @"0000"];
    NSMutableArray* results = [inserter pullWithCustomQuery:query];
    [inserter deleteForId:@"0000"];
    results = [inserter pullWithCustomQuery:query];
    XCTAssertTrue([results count] == 0);
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
