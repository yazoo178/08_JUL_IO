//
//  SentimentAnalysisTests.m
//  miCity
//
//  Created by acp16w on 17/01/2017.
//  Copyright © 2017 Will. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TwitterSentiment.h"
#import "Tweet.h"
#import "TweetChannel.h"

@interface SentimentAnalysisTests : XCTestCase

@end

@implementation SentimentAnalysisTests

TwitterSentiment* inst;

- (void)setUp {
    [super setUp];
    inst = [TwitterSentiment instance];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPositiveTweetAsPositive {
    Tweet* tweet = [[Tweet alloc]initWithTweetString:@"i am very happy today"];
    TweetChannel* channel = [[TweetChannel alloc]initWithSentimentData:[TwitterSentiment instance]];
    [channel sendTweetThroughChannel:tweet];
    XCTAssertTrue([tweet getPolarity] == Positive);
}

- (void)testNegativeTweetAsNegative {
    Tweet* tweet = [[Tweet alloc]initWithTweetString:@"i am very sad today"];
    TweetChannel* channel = [[TweetChannel alloc]initWithSentimentData:[TwitterSentiment instance]];
    [channel sendTweetThroughChannel:tweet];
    XCTAssertTrue([tweet getPolarity] == Negative);
}

- (void)testIncreateCityPositiveRating {
    Tweet* tweet = [[Tweet alloc]initWithTweetString:@"i am very happy today"];
    TweetChannel* channel = [[TweetChannel alloc]initWithSentimentData:[TwitterSentiment instance]];
    [channel sendTweetThroughChannel:tweet];
    [inst updateReflectionForTweets:[NSArray arrayWithObjects:tweet, nil]];
    XCTAssertTrue(inst.overallPositive > inst.overallNegative);
}

- (void)testIncreateCityDecrease {
    Tweet* tweet = [[Tweet alloc]initWithTweetString:@"i am very sad today"];
    Tweet* tweet2 = [[Tweet alloc]initWithTweetString:@"i am very sad today"];
    TweetChannel* channel = [[TweetChannel alloc]initWithSentimentData:[TwitterSentiment instance]];
    [channel sendTweetThroughChannel:tweet];
    [inst updateReflectionForTweets:[NSArray arrayWithObjects:tweet, tweet2, nil]];
    XCTAssertTrue(inst.overallPositive < inst.overallNegative);
}

- (void)testNeutralTweet {
    Tweet* tweet = [[Tweet alloc]initWithTweetString:@""];
    XCTAssertTrue(tweet.polarity == Neutral);
}

-(void)testSubjectiveTweetTrue{
    Tweet* tweet = [[Tweet alloc]initWithTweetString:@"i am very sad today"];
    TweetChannel* channel = [[TweetChannel alloc]initWithSentimentData:[TwitterSentiment instance]];
    XCTAssertTrue([channel isTweetSubjective:tweet]);
    
}

-(void)testObjectiveTweet{
    Tweet* tweet = [[Tweet alloc]initWithTweetString:@"i am very today"];
    TweetChannel* channel = [[TweetChannel alloc]initWithSentimentData:[TwitterSentiment instance]];
    XCTAssertFalse([channel isTweetSubjective:tweet]);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
