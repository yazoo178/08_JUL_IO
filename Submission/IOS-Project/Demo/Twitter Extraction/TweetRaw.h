//
//  Tweet.h
//  ExtractTweets
//
//  Created by acp16ssc on 16/12/2016.
//  Copyright © 2016 acp16ssc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TweetRaw : NSObject

@property (strong) NSString* userName;
@property (strong) NSString* userScreenName;
@property (strong) NSString* tweetTime;
@property (strong) NSString* tweetText;

@end
