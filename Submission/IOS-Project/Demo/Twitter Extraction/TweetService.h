//
//  TweetService.h
//  ExtractTweets
//
//  Created by acp16ssc on 16/12/2016.
//  Copyright © 2016 acp16ssc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TweetDelegate.h"
#import "TweetRaw.h"

@interface TweetService : NSOperation
@property (assign, atomic) BOOL running;
@property (strong) NSString * amountOfTweetsToPull;
@property (strong) NSString * cityCoordinates;
@property (strong) NSString * cityLongitude;
@property (strong) NSString * cityRadius;
@property (assign, atomic) BOOL requestMade;
@property (assign, atomic) BOOL processingRequest;

-(id)initWithLocation:(int)tweetAmount latitude:(float)latitude longitude:(float)longitude radius:(int)radius;

@property (weak) NSObject<TweetDelegate>* tweetDelegate;
@property (nonatomic, strong) NSArray *tweetStatuses;
//@property (nonatomic, strong) NSArray *tweetObjArr;
@property (strong) TweetRaw * tweetData;

-(NSInteger) getTweets;

@end
