//
//  TweetChannel.h
//  Demo
//
//  Created by acp16w on 06/12/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TwitterSentiment.h"
#import "Tweet.h"
#import "Constants.h"
#import "Lexicons.h"

@interface TweetChannel : NSObject

-(id)initWithSentimentData:(TwitterSentiment*)data;

//sends a tweet through the channel. returns a weighting
-(void)sendTweetThroughChannel:(Tweet*)tweet;

-(bool)isTweetSubjective:(Tweet*)tweet;

@end
