//
//  SocialViewController.m
//  Demo
//
//  Created by Will on 30/09/2016.
//  Copyright © 2016 Will. All rights reserved.

#import "SocialViewController.h"
#import "CloudLayoutOperation.h"
#import "GeneralMethods.h"
#import "WebpageDataGrabber.h"
#import "TwitterSentiment.h"
#import "WordUILabel.h"
#import "Tweet.h"
#import "TweetChannel.h"

@interface SocialViewController ()

@end

@implementation SocialViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        // Custom initialization
        self.queue = [[NSOperationQueue alloc] init];
        self.tweetSentimentWordsToTweets = [[NSMutableDictionary alloc]init];
        self.tweets = [[NSMutableArray alloc]init];
        self.channel = [[TweetChannel alloc]initWithSentimentData:[TwitterSentiment instance]];
    }
    return self;
}


-(void)tweetBatchRecieved:(NSArray *)tweets{
    self.service.requestMade = false;
    for(TweetRaw* rawTweet in tweets){
        Tweet* tw = [[Tweet alloc]initWithTweetRaw:rawTweet];
        [self.channel sendTweetThroughChannel:tw];
        [self.tweets addObject:tw];
    }
    
    for(Tweet* t in self.tweets){
        for(NSString* word in t.tokenString){
            NSMutableArray* arr;
            if([t getWordSentiment:word] >=0){
                if([self.tweetSentimentWordsToTweets objectForKey:word]){
                    arr = [self.tweetSentimentWordsToTweets objectForKey:word];
                    [arr addObject:t];
                }
                else{
                    arr = [[NSMutableArray alloc]init];
                    [arr addObject:t];
                }
                [self.tweetSentimentWordsToTweets setObject:arr forKey:word];
            }
            
        }
        
    }
    
    [self layoutCloudWords];
}

-(void)pullTweets:(NSTimer*)timer{
    [self.activityView startAnimating];
    self.service.requestMade = YES;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self pullTweets:nil];
    [self.queue addOperation:self.service];
    self.service.tweetDelegate = self;
    self.currentOperation = self.service;
    
    NSMutableArray* imgAr = [[NSMutableArray alloc]init];
    for(int i = 2; i <=12; i++){
        UIImage* img = [UIImage imageNamed:[NSString stringWithFormat:@"cloud_dl_%d", i]];
        [imgAr addObject:img];
    }
    [self.cloudButton setImage:[UIImage imageNamed:@"cloud_dl.png"] forState:UIControlStateNormal];
    self.cloudButton.imageView.animationImages = imgAr;
    self.cloudButton.imageView.animationDuration = 0.8;

    [self.cloudButton.imageView startAnimating];
    
}

-(void)viewDidAppear:(BOOL)animated{
    self.tweetPuller = [NSTimer scheduledTimerWithTimeInterval:80.0 target:self selector:@selector(pullTweets:) userInfo:nil repeats:YES];
    
    self.emotionWidget = [[EmotionWidget alloc]initWithSourceController:self];
    [self.emotionWidgetView addSubview:self.emotionWidget];
    
    //I'm seriously sick to death of constraints. I've spent 2 hours trying to get this stupid widget into position and i've had enough
    //Thereofre force it into the bottom corner
    self.emotionWidgetView.frame = CGRectMake(self.view.frame.size.width - 75, self.view.frame.size.height - 150, self.emotionWidgetView.frame.size.width, self.emotionWidgetView.frame.size.height);
    
    self.emotionWidget.frame = self.emotionWidget.superview.bounds;
    
    if(self.tweetSentimentWordsToTweets.count > 0){
        [self layoutCloudWords];
    }
    

}

-(void)viewDidDisappear:(BOOL)animated{
    [self.tweetPuller invalidate];
    self.tweetPuller = nil;
    [self.emotionWidget removeFromSuperview];
    [self removeCloudWords];
    
}

-(void)updateSpin:(NSTimer*)arg{
    NSMutableArray* arr = [[NSMutableArray alloc]init];
    [GeneralMethods processSubviewsRecur:self.view onFound:^(UIView* found){
        if([found isKindOfClass:WordUILabel.class]){
            [arr addObject:found];
        }
    }];
    if([arr count] > 0)
    {
        int num = (int)1 + arc4random() % ([arr count]-1+1);
        UILabel* selected = arr[num - 1];
        [GeneralMethods scaleThenRevert:selected fromFloat:1.0 durationFloat:0.5 onComplete:nil withRotate:YES revertTo:selected.transform];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didMoveToParentViewController:(UIViewController *)parent
{
    if (![parent isEqual:self.parentViewController]) {
        [self.spinTimer invalidate];
        [self.queue cancelAllOperations];
        [self removeCloudWords];  
    }
}

- (void)insertWord:(NSString *)word pointSize:(CGFloat)pointSize color:(NSUInteger)color center:(CGPoint)center vertical:(BOOL)isVertical buzzin:(BOOL)isBuzzin
{
    WordUILabel *wordLabel = [[WordUILabel alloc]initWithTweetsView:self.storyboard tweetArray:self.tweetSentimentWordsToTweets[word]];
    
    wordLabel.text = word;
    wordLabel.textAlignment = NSTextAlignmentCenter;
    wordLabel.textColor = self.cloudColors[color < self.cloudColors.count ? color : 0];
    wordLabel.font = [UIFont fontWithName:self.cloudFontName size:pointSize];
    wordLabel.backgroundColor = [UIColor clearColor];
    
    [wordLabel sizeToFit];
    
    // Round up size to even multiples to "align" frame without ofsetting center
    CGRect wordLabelRect = wordLabel.frame;
    wordLabelRect.size.width = ((NSInteger)((CGRectGetWidth(wordLabelRect) + 3) / 2)) * 2;
    wordLabelRect.size.height = ((NSInteger)((CGRectGetHeight(wordLabelRect) + 3) / 2)) * 2;
    wordLabel.frame = wordLabelRect;
    
    wordLabel.center = center;
    
    if (isVertical)
    {
        [GeneralMethods scaleAppear:wordLabel toFloat:2 durationFloat:0.5 onComplete:nil revertTo:CGAffineTransformMakeRotation(M_PI_2)];
        
    }
    
    else{
        [GeneralMethods scaleAppear:wordLabel toFloat:2 durationFloat:0.5 onComplete:nil revertTo:CGAffineTransformIdentity];
        
    }
    
    int rndValue = 5 + arc4random() % (20 - 5);
    
    wordLabel.userInteractionEnabled = YES;
    [GeneralMethods growRevertRecur:wordLabel xTo:rndValue dur:0.75];
    [self.drawingView addSubview:wordLabel];
}


#pragma mark - Private methods

/**
 Remove all words from the cloud view
 */
- (void)removeCloudWords
{
    NSMutableArray *removableObjects = [[NSMutableArray alloc] init];
    
    // Remove cloud words (UILabels)
    
    for (id subview in self.drawingView.subviews)
    {
        if ([subview isKindOfClass:[WordUILabel class]])
        {
            [removableObjects addObject:subview];
        }
    }
    
    [removableObjects makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
#ifdef DEBUG
    // Remove bounding boxes
    
    [removableObjects removeAllObjects];
    
    for (id sublayer in self.view.layer.sublayers)
    {
        if ([sublayer isKindOfClass:[CALayer class]] && ((CALayer *)sublayer).borderWidth && ![sublayer delegate])
        {
            [removableObjects addObject:sublayer];
        }
    }
    
    [removableObjects makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
#endif
}

- (void)layoutCloudWords
{
    [self.spinTimer invalidate];
    self.spinTimer = nil;
    [self removeCloudWords];
    
    self.cloudColors = [UIColor cloudColorDefault];
    self.cloudFontName = [UIColor cloudFontDefault];
    
    NSMutableDictionary* tweetWordsToCounts = [[NSMutableDictionary alloc]init];
        
    for(NSString* key in self.tweetSentimentWordsToTweets){
        NSNumber* count = [NSNumber numberWithInteger:[self.tweetSentimentWordsToTweets[key]count]];
        [tweetWordsToCounts setObject:count forKey:key];
    }
        
    self.currentOperation = [[CloudLayoutOperation alloc] initWithCloudWords:tweetWordsToCounts
                                                            forContainerWithSize:self.drawingView.frame.size
                                                                        scale:[[UIScreen mainScreen] scale]
                                                                        delegate:self maxWords:200];
        
    __weak SocialViewController *weakSelf = self;
    self.currentOperation.completionBlock = ^{
        if([NSThread isMainThread]){
            [weakSelf startTimer];
            [weakSelf.activityView stopAnimating];
            [[TwitterSentiment instance]updateReflectionForTweets:weakSelf.tweets];
            [weakSelf.emotionWidget updateEmotion];
        }
    };
        
    [self.queue addOperation:self.currentOperation];
    
}




-(void)happyPressed:(id)sender{
    
    NSPredicate* pred = [NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        
        Tweet* cur = (Tweet*)evaluatedObject;
        return [cur getPolarity] == Positive;
    }];
    
    [self showTweetsView:pred withTitle:@"Who's Happy?" withColour:[UIColor positiveGreenColor] withPhraseText: @"Who's being really happy in YOUR city?"];
}

-(void)sadPressed:(id)sender{
    NSPredicate* pred = [NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        
        Tweet* cur = (Tweet*)evaluatedObject;
        return [cur getPolarity] == Negative;
    }];
    
    [self showTweetsView:pred withTitle:@"Who's Sad?" withColour:[UIColor negativeRedColor] withPhraseText:@"Who's bringing YOUR city down?"];
}


-(void)neutralPressed:(id)sender{
    NSPredicate* pred = [NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        
        Tweet* cur = (Tweet*)evaluatedObject;
        return [cur getPolarity] == Neutral;
    }];
    
    [self showTweetsView:pred withTitle:@"Emotionless?" withColour:[UIColor blackColor] withPhraseText: @"Who's neutral and expressing no emotion?"];
}

-(void)showTweetsView:(NSPredicate*)filter withTitle:(NSString*)title withColour:(UIColor*)color withPhraseText:(NSString*)phrase{
    TweetsScreenViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"TweetsScreen"];
    NSArray* filterdTeeets = [self.tweets filteredArrayUsingPredicate:filter];
    
    vc.tweets = filterdTeeets;
    vc.sourceLabelText = title;
    vc.headerColor = color;
    vc.phrase = phrase;
    [self.navigationController pushViewController:vc animated:TRUE];
    
}

-(void)startTimer{
    self.spinTimer  = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(updateSpin:) userInfo:nil repeats:YES];
}

-(IBAction)getMoreWords:(id)sender{
    if(!self.currentOperation.isExecuting){
        self.service.requestMade = YES;
    }
}


@end
