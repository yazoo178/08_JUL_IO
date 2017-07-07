//
//  TwitterTests.m
//  miCity
//
//  Created by Will on 19/01/2017.
//  Copyright © 2017 Will. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TweetService.h"
#import "TweetDelegate.h"

@interface TwitterTests : XCTestCase<TweetDelegate>{
    XCTestExpectation *tweetEx;
}
@end

@implementation TwitterTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

-(void)testTweetRecieved{
    tweetEx = [self expectationWithDescription:@"got tweets"];
    TweetService* servive = [[TweetService alloc]initWithLocation:10 latitude:53.381129 longitude:-1.470085 radius:100];
    servive.tweetDelegate = self;
    [servive getTweets];
    
    
    [self waitForExpectationsWithTimeout:5 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Server Timeout Error: %@", error);
        }
    }];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

-(void)tweetBatchRecieved:(NSArray *)tweets{
    [tweetEx fulfill];
    XCTAssertTrue(tweets != nil);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
