//
//  TweetDelegate.h
//  ExtractTweets
//
//  Created by acp16ssc on 16/12/2016.
//  Copyright © 2016 acp16ssc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TweetRaw.h"

@protocol TweetDelegate <NSObject>

-(void)tweetBatchRecieved:(NSArray*)tweets;


@end
