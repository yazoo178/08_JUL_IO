//
//  SocialViewController.m
//  Demo
//
//  Created by Will on 30/09/2016.
//  Copyright © 2016 Will. All rights reserved.

@import UIKit;

#import "MiCityViewController.h"
#import "TweetService.h"
#import "TweetDelegate.h"
#import "CloudLayoutOperation.h"
#import "GeneralMethods.h"
#import "WebpageDataGrabber.h"
#import "TwitterSentiment.h"
#import "WordUILabel.h"
#import "Tweet.h"
#import "TweetChannel.h"
#import "EmotionWidget.h"
#import "MarqueeLabel.h"

@interface SocialViewController : MiCityViewController<TweetDelegate, CloudLayoutOperationDelegate>

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (strong) NSString* URL;
@property (weak) IBOutlet UIView* drawingView;
@property (weak) IBOutlet UIActivityIndicatorView* activityView;
@property (weak) IBOutlet UIButton* happyButton;
@property (weak) IBOutlet UIButton* sadButton;
@property (weak) IBOutlet UIButton* neutral;
@property (strong) TweetService* service;
@property (weak) IBOutlet UIView* textScrollView;

@property (weak) IBOutlet UIView* emotionWidgetView;
@property (strong) EmotionWidget* emotionWidget;

@property (weak) IBOutlet UIButton* cloudButton;
@property (nonatomic, strong) NSArray *cloudColors;
@property (nonatomic, strong) NSString *cloudFontName;
@property (nonatomic, strong) NSOperation* currentOperation;
@property (nonatomic, strong) NSOperationQueue* queue;
@property(nonatomic, strong) NSTimer* spinTimer;
@property (nonatomic, strong) NSMutableDictionary* tweetSentimentWordsToTweets;
@property (nonatomic, strong) NSMutableArray* tweets;
@property (nonatomic, strong) TweetChannel* channel;
@property (strong)NSTimer * tweetPuller;

-(IBAction)happyPressed:(id)sender;
-(IBAction)sadPressed:(id)sender;
-(IBAction)neutralPressed:(id)sender;
-(IBAction)getMoreWords:(id)sender;

@end

