//
//  TwitterSentiment.m
//  Demo
//
//  Created by acp16w on 22/11/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import "TwitterSentiment.h"
#import "Constants.h"
#import "Tweet.h"

@implementation TwitterSentiment

static TwitterSentiment* sentiment;

-(id)init{
    self = [super init];
    
    if(self){
        NSString *filepath = [[NSBundle mainBundle] pathForResource:@"filter_2" ofType:@"xml"];
        self.corpus = [[NSDictionary alloc]initWithContentsOfFile:filepath];
         Lexicons* lexicons = [[Lexicons alloc]initWithPositiveLexiconFile:@"positive-words" negativeLexiconFile:@"negative-words" withNegationWords:@"negation_words" withPresup:@"Presuppositional-words"];
        self.lexicons = lexicons;
    }
    
    return self;
}

-(void)updateReflectionForTweets:(NSArray *)tweets{
    double pos = 0;
    double neg = 0;
    
    for(Tweet* t in tweets){
        if([t getPolarity] == Positive){
            pos++;
        }
        
        else if([t getPolarity] == Negative){
            neg++;
        }
        
    }
    
    self.overallPositive = pos / (pos + neg);
    self.overallNegative = neg / (pos + neg);
}

-(double)countGivenPositiveWord:(NSString *)word{
    
    if([self.corpus objectForKey:word]){
        NSArray* ar= [self.corpus objectForKey:word];
        return [ar[0] doubleValue];
    }
    
    return 0;
}

-(double)countGivenNegativeWord:(NSString *)word{
    if([self.corpus objectForKey:word]){
        NSArray* ar= [self.corpus objectForKey:word];
        return [ar[1] doubleValue];
    }
    
    return 0;
}

-(double)negativeWordCount{
    int count = 0;
    for(NSString* key in self.corpus){
        NSArray* ar= [self.corpus objectForKey:key];
        count += [ar[1] doubleValue];
    }
    
    return count;
}

-(double)positiveWordCount{
    double count = 0;
    for(NSString* key in self.corpus){
        NSArray* ar= [self.corpus objectForKey:key];
        count += [ar[0] doubleValue];
    }
    
    return count;
}

-(double)priorNegative{
    return PRIOR_NEGATIVE_COUNT_TWITTER;
}

-(double)priorPositive{
    return PRIOR_POSITIVE_COUNT_TWITTER;
}

-(double)vocab{
    NSInteger count = [self.corpus count];
    return (double)count;
}

+(TwitterSentiment*)instance{
    if(sentiment == nil){
        sentiment = [[TwitterSentiment alloc]init];
    }
    
    return sentiment;
}

@end
