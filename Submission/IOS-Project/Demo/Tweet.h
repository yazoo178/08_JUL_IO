//
//  Tweet.h
//  Demo
//
//  Created by acp16w on 06/12/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TweetRaw.h"

@interface Tweet : NSObject

-(id)initWithTweetString:(NSString*)tweet;
-(id)initWithTweetRaw:(TweetRaw*)tweet;

@property (strong) NSString* tweetString;
@property (strong) NSMutableArray* tokenString;
@property (strong) NSString* user;
@property (strong) NSString* userScreenName;
@property (strong) NSString* tweetTime;

@property (assign) double positiveRanking;
@property (assign) double negativeRanking;

typedef enum Polarity
{
    Positive,
    Negative,
    Neutral
} Polarity;

@property (assign) Polarity polarity;
-(Polarity)getPolarity;

-(NSInteger)getWordSentiment:(NSString*)word;

@end
