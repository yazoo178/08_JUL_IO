//
//  Tweet.m
//  Demo
//
//  Created by acp16w on 06/12/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import "Tweet.h"
#import "Constants.h"
#import "TwitterSentiment.h"

@implementation Tweet

-(id)initWithTweetString:(NSString *)tweet{
    self = [super init];
    
    if(self){
        self.tweetString = tweet;
        self.tokenString = [[NSMutableArray alloc]init];
        self.polarity = Neutral;
        NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:TWITTER_TOKEN_MATCH_REGEX options:0 error:nil];
        NSArray *matches = [expression matchesInString:self.tweetString options: NSMatchingCompleted range:NSMakeRange(0, self.tweetString.length)];
        
        for (NSTextCheckingResult *result in matches){
            NSString *word = [self.tweetString substringWithRange:result.range];stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet];
            word = [word lowercaseString];
            [self.tokenString addObject:word];
        }
    }
    
    return self;
}



-(id)initWithTweetRaw:(TweetRaw *)tweet{
    self = [self initWithTweetString:tweet.tweetText];
    
    if(self){
        self.user = tweet.userName;
        self.userScreenName = tweet.userScreenName;
        self.tweetTime = tweet.tweetTime;
    }
    
    return self;
}

-(Polarity)getPolarity{
    return self.positiveRanking > self.negativeRanking ? Positive : (self.positiveRanking == self.negativeRanking ? Neutral : Negative);
}

-(NSInteger)getWordSentiment:(NSString *)word{
    if([self.tokenString containsObject:word]){
        TwitterSentiment* sent = [TwitterSentiment instance];
        return [sent.lexicons.positiveLexicons containsObject:word] ? 1 : [sent.lexicons.negativeLexicons containsObject:word] ? 0 : -1;
        
    }
    
    return -1;
}

@end
