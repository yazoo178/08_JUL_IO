//
//  WordUILabel.h
//  Demo
//
//  Created by Will on 08/12/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TweetsScreenViewController.h"
#import "Tweet.h"

@interface WordUILabel : UILabel

-(id)initWithTweetsView:(UIStoryboard* )cont tweetArray:(NSArray<Tweet*>*)tweets;

@property (weak) UIStoryboard* storyboard;
@property (weak) NSArray* tweetArrayForThisLabelWord;

@end
