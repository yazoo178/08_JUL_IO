//
//  TwitterSentiment.h
//  Demo
//
//  Created by acp16w on 22/11/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Lexicons.h"

@interface TwitterSentiment : NSObject

@property (strong) NSDictionary* corpus;

-(double)priorPositive;
-(double)priorNegative;

-(double)countGivenPositiveWord:(NSString*)word;
-(double)countGivenNegativeWord:(NSString*)word;

-(double)positiveWordCount;
-(double)negativeWordCount;

-(double)vocab;

-(void)updateReflectionForTweets:(NSArray*)tweets;

@property (assign) double overallPositive;
@property (assign) double overallNegative;

+(TwitterSentiment*)instance;

@property (strong) Lexicons* lexicons;

@end
