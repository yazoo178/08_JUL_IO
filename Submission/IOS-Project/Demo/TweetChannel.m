//
//  TweetChannel.m
//  Demo
//
//  Created by acp16w on 06/12/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import "TweetChannel.h"
#import "TwitterSentiment.h"
#import <Math.h>

@implementation TweetChannel

TwitterSentiment* sentiment;

-(id)initWithSentimentData:(TwitterSentiment *)data{
    self = [super init];
    
    if(self){
        sentiment = data;
    }
    
    return self;
}

-(void)sendTweetThroughChannel:(Tweet *)tweet{
    
    double positiveProduct = 0;
    double negativeProduct = 0;
    
    double priorPostive = [sentiment priorPositive] / ([sentiment priorPositive] + [sentiment priorNegative]);
    double priorNegative = [sentiment priorNegative] / ([sentiment priorPositive] + [sentiment priorNegative]);
    
    bool negateNextWord = false;
    bool shifter = false;
    
    Lexicons* lex = [sentiment lexicons];
    
    for (NSString* __strong word in tweet.tokenString){

        if([lex.negationWords containsObject:word]){
            negateNextWord = true;
            continue;
        }
        
        else if([lex.generalShifters containsObject:word]){
            negateNextWord = false;
            shifter = true;
        }
        
        if([lex.positiveLexicons containsObject:word] || [lex.negativeLexicons containsObject:word]){
            
            if(negateNextWord){
                negateNextWord = false;
                word = [NSString stringWithFormat:@"%@%@", @"NOT_", word];
            }
            
            else if(shifter){
                shifter = false;
                
                word = [NSString stringWithFormat:@"%@%@", @"SHIFT_", word];
            }
            
            double poswordRate =  log((([sentiment countGivenPositiveWord:word] + 1) / ([sentiment positiveWordCount] + [sentiment vocab])));
            
            double negativeRate = log((([sentiment countGivenNegativeWord:word] + 1) / ([sentiment negativeWordCount] + [sentiment vocab])));
            
            positiveProduct = positiveProduct + poswordRate;
            negativeProduct = negativeProduct + negativeRate;
        }
        
    }
    
    positiveProduct = (positiveProduct * priorPostive);
    negativeProduct = (negativeProduct * priorNegative);
    
    tweet.positiveRanking = positiveProduct;
    tweet.negativeRanking = negativeProduct;
    
}

-(bool)isTweetSubjective:(Tweet *)tweet{
    Lexicons* lex = [sentiment lexicons];
    
    for (NSString* __strong word in tweet.tokenString){
        
        if([lex.positiveLexicons containsObject:word] || [lex.negativeLexicons containsObject:word]){
            return true;
        }
    }
    
    return false;
}

@end
