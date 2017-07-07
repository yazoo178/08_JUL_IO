//
//  WordUILabel.m
//  Demo
//
//  Created by Will on 08/12/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import "WordUILabel.h"
#import "Tweet.h"

@implementation WordUILabel

-(id)initWithTweetsView:(UIStoryboard *)cont tweetArray:(NSArray<Tweet*>*)tweets{
    self = [super initWithFrame:CGRectZero];
    
    if(self){
        self.storyboard = cont;
        self.tweetArrayForThisLabelWord = tweets;
    }
    
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    TweetsScreenViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"TweetsScreen"];
    vc.tweets = [[NSOrderedSet orderedSetWithArray:self.tweetArrayForThisLabelWord]array];
    UINavigationController* cont =  (UINavigationController *)self.window.rootViewController;
    vc.sourceLabelText = self.text;
    bool sentiment = [[self.tweetArrayForThisLabelWord firstObject] getWordSentiment:self.text] == 1;
    vc.headerColor = sentiment ? [UIColor positiveGreenColor] : [UIColor negativeRedColor];
    vc.phrase = sentiment ? @"Who's being really happy in YOUR city?" : @"Who's bringing YOUR city down?";
    [cont pushViewController:vc animated:YES];
    
    
}



@end
