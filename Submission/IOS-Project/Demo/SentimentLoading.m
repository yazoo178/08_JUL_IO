//
//  SentimentLoading.m
//  Demo
//
//  Created by acp16w on 29/11/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import "SentimentLoading.h"
#import "Constants.h"
#import "Lexicons.h"

@implementation SentimentLoading

+(void)GenerateSentimentFile{
    
        NSMutableDictionary* wordsToSentimentCounts = [[NSMutableDictionary alloc]init];
        
        NSString *filepath = [[NSBundle mainBundle] pathForResource:@"Sentiment Analysis Dataset" ofType:@"csv"];
    
       Lexicons* lexicons = [[Lexicons alloc]initWithPositiveLexiconFile:@"positive-words" negativeLexiconFile:@"negative-words" withNegationWords:@"negation_words" withPresup:@"Presuppositional-words"];
    
        __block NSString* content = [NSString stringWithContentsOfFile:filepath
                                                              encoding:NSUTF8StringEncoding
                                                                 error:nil];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    
    int positiveC = 0;
    int negativeC = 0;
        bool headerLoaded = false;
        for (NSString* line in [content componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]]){
            if(!headerLoaded){
                headerLoaded = true;
                continue;
            }
            
            if([line isEqualToString:@""]){
                continue;
            }
            
            
            // Tweet* tweet = [[Tweet alloc]init];
            NSArray<NSString *> * vals = [line componentsSeparatedByString:@","];
            //tweet.tweet_id = [vals[0] intValue];
            //tweet.sentiment = [vals[1] isEqualToString:@"1"];
            // tweet.tweet = [vals[3] lowercaseString];
            
            NSString* lowerLine = [vals[3] lowercaseString];
            
            NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:TWITTER_TOKEN_MATCH_REGEX options:0 error:nil];
            
            NSArray *matches = [expression matchesInString:lowerLine options: NSMatchingCompleted range:NSMakeRange(0, lowerLine.length)];

            
            bool sentiment = [vals[1] isEqualToString:@"1"];
            if(sentiment) {positiveC++;} else {negativeC++;}
            bool negateNextWord = false;
            bool shifter = false;
            
            for (NSTextCheckingResult *result in matches){
                
                NSString *word = [lowerLine substringWithRange:result.range];stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet];
                
                if([lexicons.negationWords containsObject:word]){
                    negateNextWord = true;
                    shifter = false;
                    continue;
                }
                
                else if([lexicons.generalShifters containsObject:word]){
                    shifter = true;
                    negateNextWord = false;
                    continue;
                }
                
                //word = [PorterStemmer stemFromString:word];
                if([lexicons.positiveLexicons containsObject:word] || [lexicons.negativeLexicons containsObject:word]){
                    
                    if(negateNextWord){
                        negateNextWord = false;
                        word = [NSString stringWithFormat:@"%@%@", @"NOT_", word];
                    }
                    
                    
                    
                     if([wordsToSentimentCounts objectForKey:word]){
                        NSMutableArray* list = [wordsToSentimentCounts objectForKey:word];
                        
                        if(sentiment){
                            int value = [list[0] intValue];
                            list[0] = [NSNumber numberWithInt:value + 1];
                            
                        }
                        else{
                            int value = [list[1] intValue];
                            list[1] = [NSNumber numberWithInt:value + 1];
                        }
                    }
                    else{
                        NSMutableArray* list = [[NSMutableArray alloc]initWithCapacity:2];
                        
                        if(sentiment){
                            [list addObject:[NSNumber numberWithInt:1]];
                            [list addObject:[NSNumber numberWithInt:0]];
                        }
                        else{
                            [list addObject:[NSNumber numberWithInt:0]];
                            [list addObject:[NSNumber numberWithInt:1]];
                        }
                        
                        [wordsToSentimentCounts setObject:list forKey:word];
                        
                    }
                }
                }
                
            
            //[sent addTweet:tweet];
            
        }
        
        NSMutableDictionary * filteredDict = [[NSMutableDictionary alloc]init];
        
        for (NSString* key in wordsToSentimentCounts){
            NSArray* arr = wordsToSentimentCounts[key];
            
            if([arr[0] integerValue] > 2 || [arr[1] integerValue] > 2){
                [filteredDict setObject:arr forKey:key];
            }
        }
        
    
    NSString  *arrayPath;
    NSString  *dictPath;
    
    
    if ([paths count] > 0)
    {
        // Path to save array data
        arrayPath = [[paths objectAtIndex:0]
                     stringByAppendingPathComponent:@"array.out"];
        
        // Path to save dictionary
        dictPath = [[paths objectAtIndex:0]
                    stringByAppendingPathComponent:@"filter_2.xml"];
                
        [filteredDict writeToFile:dictPath atomically:YES];
        
    }
    
    }


@end
