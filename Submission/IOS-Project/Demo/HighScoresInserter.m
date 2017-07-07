//
//  HighScoresInserter.m
//  miCity
//
//  Created by Will on 01/01/2017.
//  Copyright © 2017 Will. All rights reserved.
//

#import "HighScoresInserter.h"

@implementation HighScoresInserter


-(id)pullWithId:(NSString *)iD{
    DbAccess* dbEx = [DbAccess instance];
    NSString* pullStr = @"SELECT * FROM HIGHSCORES";
    
    NSMutableArray* results = [[NSMutableArray alloc]init];
    
    [dbEx selectStatement:pullStr itempulledBack:^(id result){
        Highscore* score = [[Highscore alloc]init];
        score.name = [result objectForKey:@"NAME"];
        score.score = [result objectForKey:@"SCORE"];
        score.emotion = [result objectForKey:@"GAME_EMOTION"];
        score.wave = [result objectForKey:@"WAVE"];
        score.Id = [result objectForKey:@"ID"];
        [results addObject:score];
    }];
    
    return results;
    
}

-(bool)insertWithType:(id)param{
    DbAccess* dbEx = [DbAccess instance];
    NSString* name = [param objectForKey:@"NAME"];
    NSString* score = [param objectForKey:@"SCORE"];
    NSString* emotion = [param objectForKey:@"GAME_EMOTION"];
    NSString* wave = [param objectForKey:@"WAVE"];
    [dbEx executeStatement: [NSString stringWithFormat:HIGHSCORE_INSERT_STR, name, score, emotion, wave]];
    
    
    return YES;
}

-(void)deleteForId:(NSString *)iD{
    DbAccess* dbEx = [DbAccess instance];
    NSString* query = [NSString stringWithFormat:@"DELETE FROM HIGHSCORES WHERE ID = '%@'", iD];
    [dbEx executeStatement:query];
}

-(id)pullWithCustomQuery:(NSString *)query{
    DbAccess* dbEx = [DbAccess instance];
    NSMutableArray* results = [[NSMutableArray alloc]init];
    
    [dbEx selectStatement:query itempulledBack:^(id result){
        Highscore* score = [[Highscore alloc]init];
        score.name = [result objectForKey:@"NAME"];
        score.score = [result objectForKey:@"SCORE"];
        score.emotion = [result objectForKey:@"GAME_EMOTION"];
        score.wave = [result objectForKey:@"WAVE"];
        score.Id = [result objectForKey:@"ID"];
        [results addObject:score];
    }];
    
    return results;
    
    
}


@end
