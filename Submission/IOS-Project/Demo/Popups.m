//
//  Popups.m
//  Kappenball
//
//  Created by Will on 22/10/2016.
//  Copyright © 2016 acp16w. All rights reserved.
//

#import "Popups.h"

@implementation Popups


//Creates and shows a popup for submitting highsocre data
+(UIAlertController*)createPopupForScoreSubmis:(GameData *)data{
    //Create a new alert
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Submit Score"
                                 message:@"Enter Name:"
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    
        UIAlertAction* submit = [UIAlertAction
                                 actionWithTitle:@"Submit"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action) {
                                     dispatch_async(dispatch_get_main_queue(), ^{
                                         //Insert score into db
                                         NSString* name = alert.textFields[0].text;
                                         
                                         HighScoresInserter* ins = [[HighScoresInserter alloc]init];
                                         NSMutableDictionary* dict = [[NSMutableDictionary alloc]init];
                                         [dict setObject:name forKey:@"NAME"];
                                         [dict setObject:data.score forKey:@"SCORE"];
                                         [dict setObject:data.emotion forKey:@"GAME_EMOTION"];
                                         [dict setObject:[NSString stringWithFormat:@"%d", data.currentWave] forKey:@"WAVE"];
                                         [ins insertWithType:dict];
                                     });
                                     
                                 }];
        
        [alert addAction:submit];
        [alert addTextFieldWithConfigurationHandler:^(UITextField* field){
            field.placeholder = @"Enter Name...";
        }];
    
    
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action) {
                                 
                             }];
    
    
    
    
    [alert addAction:cancel];
    return alert;
}
@end
