//
//  TweetService.m
//  ExtractTweets
//
//  Created by acp16ssc on 16/12/2016.
//  Copyright © 2016 acp16ssc. All rights reserved.
//

#import "TweetService.h"
#import "STTwitter.h"
#import "STTwitterAPI.h"
#import "STTwitterOAuth.h"
#import "NSDateFormatter+STTwitter.h"

@implementation TweetService

/* App settings
 Consumer Key (API Key)          wfTYiWbxALRestlizHmbunDPS
 Consumer Secret (API Secret)	 YS2aX27u8KTwTWjv9U0LvEXdMyy173hDZRGWmH6mQzoXMn29FO
 Access Level                    Read and write (modify app permissions)
 Owner                           iosXcodeAppTest
 Owner ID                        806518766490292224
 */
/* Access token
 Access Token           806518766490292224-eIOWsrqXDIyUhDa2NgUegreuhwE2LqQ
 Access Token Secret	KErcVRIgVkMj4GBVe3r7WeWgYt0uJrSirG7pbNtH4AfZ7
 Access Level           Read and write
 Owner                  iosXcodeAppTest
 Owner ID               806518766490292224
 */

NSString * Consumer_Key = @"wfTYiWbxALRestlizHmbunDPS";
NSString * Consumer_Secret = @"YS2aX27u8KTwTWjv9U0LvEXdMyy173hDZRGWmH6mQzoXMn29FO";
NSString * Access_Token = @"806518766490292224-eIOWsrqXDIyUhDa2NgUegreuhwE2LqQ";
NSString * Access_Token_Secret	= @"KErcVRIgVkMj4GBVe3r7WeWgYt0uJrSirG7pbNtH4AfZ7";
NSString * ScreenName = @"dota2ti";
NSString * latitude_city = @"53.3811";
NSString * longitude_city = @"1.4701";
//NSString * accuracy_city = @"100";
NSString * granularity = @"";
NSString * max_results_city = @"300";
//NSString * geocode_city = @"40.7128,74.0059,100mi";

// Contains tweet objects
NSMutableArray * tweetObjArr;
// Store in app flash/database
NSInteger totalRateLimit = 0;
// Store in app flash/database
NSInteger availableRateLimit = 1;
NSInteger errorStatus;

-(id)initWithLocation:(int)tweetAmount latitude:(float)latitude longitude:(float)longitude radius:(int)radius
{
    self = [super init];
    
    if(self)
    {
        self.amountOfTweetsToPull = [NSString stringWithFormat:@"%i", tweetAmount];
        self.cityCoordinates = [NSString stringWithFormat:@"%f,%f,%imi", latitude, longitude, radius];
        self.tweetData = [[TweetRaw alloc]init];
        self.requestMade = false;
        
    }
    return self;
}

-(void)main{
    while(![self isCancelled]){
        if (self.requestMade && !self.processingRequest){
            [self getTweets];
            self.processingRequest = YES;
            self.requestMade = false;
        }
    }

}

// Method to extract tweets from twitter using REST API and STTwitter library
-(NSInteger) getTweets
{
    errorStatus = 0;
    // Check if tweets to pull are non-zero
    if(self.amountOfTweetsToPull > 0)
    {
        // Check if the available tweet request rate limit is greater than 0
        if(availableRateLimit > 0)
        {
            NSString * accuracy_city = self.amountOfTweetsToPull;
            NSString * geocode_city = self.cityCoordinates;
            tweetObjArr = [[NSMutableArray alloc] init];
            
            // Create instance of the twitter account using OAuth
            STTwitterAPI *twitter = [STTwitterAPI twitterAPIWithOAuthConsumerKey:Consumer_Key consumerSecret:Consumer_Secret oauthToken:Access_Token oauthTokenSecret:Access_Token_Secret];
            
            // Verify the twitter account credentials
            [twitter verifyCredentialsWithUserSuccessBlock:^(NSString *username, NSString *userID)
            {
                NSLog(@"Successful authentication/n");
                
                // Request to pull tweets from a given location
                [twitter getSearchTweetsWithQuery:@"" geocode:geocode_city lang:nil locale:nil resultType:@"recent" count:accuracy_city until:nil sinceID:nil maxID:nil includeEntities:[NSNumber numberWithInt:1] callback:nil useExtendedTweetMode:0
                successBlock:^(NSDictionary *searchMetadata, NSArray *statuses, NSDictionary * rateLimits)
                {
                    //NSLog(@"%@ %lu", statuses, (unsigned long)statuses.count);
                    
                    self.tweetStatuses = statuses;
            
                    NSLog(@"%@", rateLimits);
                    totalRateLimit = [[rateLimits valueForKey:@"x-rate-limit-remaining"] integerValue];
                    availableRateLimit = [[rateLimits valueForKey:@"x-rate-limit-remaining"] integerValue];
                    
                    for (int i = 0; i < [self.tweetStatuses count]; i++)
                    {
                        NSDictionary * dicTweet = [self.tweetStatuses objectAtIndex:i];
                        NSDictionary * dicForUserData = [dicTweet valueForKey:@"user"];

                        //for (k in [dic allKeys]) {}
                        
                        NSLog(@"Date: %@\n Text: %@\n", [dicTweet valueForKey:@"created_at"], [dicTweet valueForKey:@"text"]);
                        NSLog(@"Name: %@\n Screen_name: %@\n", [dicForUserData valueForKey:@"name"], [dicForUserData valueForKey:@"screen_name"]);
                        
                        TweetRaw* rawTweetData = [[TweetRaw alloc]init];
                        rawTweetData.userName = [dicForUserData valueForKey:@"name"];
                        rawTweetData.userScreenName = [dicForUserData valueForKey:@"screen_name"];
                        rawTweetData.tweetText = [dicTweet valueForKey:@"text"];
                        rawTweetData.tweetTime = [dicTweet valueForKey:@"created_at"];
                        [tweetObjArr addObject:rawTweetData];
                    }
                    errorStatus = 1;
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.tweetDelegate tweetBatchRecieved:tweetObjArr];
                        self.processingRequest = NO;
                    });
                }
                errorBlock:^(NSError *error)
                {
                    NSLog(@"Error in authentication:%@/n", error.localizedDescription);
                }];
            }
            errorBlock:^(NSError *error)
            {
                NSLog(@"Error in authentication:%@/n", error.localizedDescription);
            }];
        }
        else
        {
            NSLog(@"Tweet rate limit reached/n");
        }
    }
    else
    {
        NSLog(@"Tweet count should be greater than 0/n");
    }
    return errorStatus;
}


@end
