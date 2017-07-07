//
//  EmotionWidget.m
//  miCity
//
//  Created by Will on 30/12/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import "EmotionWidget.h"
#import "GeneralMethods.h"

//This is the main emotion widget used on various pages
@implementation EmotionWidget

-(id)init{
    self = [super initWithFrame:CGRectMake(0, 0, 65, 80 * 2)];
    if(self){
        [self addArrow];
        [self addEmotion];
    }
    return self;
}

-(void)addArrow{
    //create image for animiating arrow
    UIImage* img = [UIImage imageNamed:@"arrow.png"];
    
    //create UIView for arrow.
    //start arrow animiating
    self.arrow = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 65, 61)];
    self.arrow.image  = img;
    [GeneralMethods upDownAnimate:self.arrow  xTo:15 dur:0.4 dir:YES];
    [self addSubview:self.arrow];
}

-(void)addEmotion{
    //Add emotion face image
    self.face = [[UIImageView alloc]initWithFrame:CGRectMake(0, 80, 65, 61)];
    [self updateEmotion];
    [self addSubview:self.face];
    
    //Allow image to be tapped
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap)];
    singleTap.numberOfTapsRequired = 1;
    [self.face setUserInteractionEnabled:YES];
    [self.face addGestureRecognizer:singleTap];
}

-(id)initWithSourceController:(MiCityViewController *)source{
    self = [super initWithFrame:CGRectMake(0, 0, 65, 80 * 2)];
    if(self){
        [self addArrow];
        [self addEmotion];
        self.sourceController = source;
    }
    return self;
}

-(void)updateEmotion{
    
    //Get the twitter sentiment instance
    TwitterSentiment* sent = [ TwitterSentiment instance];
    
    //get positive and negative sentiment
    double postive = sent.overallPositive - (double)POLARITY_THRESH_HOLD;
    double negative = sent.overallNegative - (double)POLARITY_THRESH_HOLD;
    
    
    EmotionType type = Normal;
    
    //Set the image based on emotion
    UIImage* img;
    if(postive > sent.overallNegative){
        self.currentEmotionImg = @"smile.png";
        img = [UIImage imageNamed:self.currentEmotionImg];
        type = Happy;
    }
    
    else if(negative > sent.overallPositive){
        self.currentEmotionImg = @"sad.png";
        img = [UIImage imageNamed:self.currentEmotionImg];
        type = Sad;
    }
    
    else{
        self.currentEmotionImg = @"neutral.png";
       img = [UIImage imageNamed:self.currentEmotionImg];
    }
    
    self.face.image = img;
    [self.face setNeedsDisplay];
    
    //invoke delegate to tell subsribers know emotion has changed
    if(self.emotionChanged != nil){
        self.emotionChanged(type);
    }
}

-(void)imageTap{
    if(self.facePress != nil){
        self.facePress();
    }
    else
    {
        PopUpViewController * popup = [self.sourceController.storyboard instantiateViewControllerWithIdentifier:@"Popup"];
        // present the controller
        // on iPad, this will be a Popover
        // on iPhone, this will be an action sheet
        popup.modalPresentationStyle = UIModalPresentationPopover;
        
        if(self.configPopup != nil){
            self.configPopup(popup);
        }
        
        //show the tweet data including emotion stats
        TwitterSentiment* sentiment = [ TwitterSentiment instance];
        popup.titleText = @"Emotional Status";
        popup.line1Text = [NSString stringWithFormat:@"Positive Rating: %f", sentiment.overallPositive];
        popup.line2Text = [NSString stringWithFormat:@"Negative Rating: %f", sentiment.overallNegative];
        popup.line4Text = [NSString stringWithFormat:@"You can get emotion from the social tab"];
        popup.imgPath = self.face.image;
        [self.sourceController presentViewController:popup animated:YES completion:nil];
    
        // configure the Popover presentation controller
        UIPopoverPresentationController *popController = [popup popoverPresentationController];
        popController.permittedArrowDirections = UIPopoverArrowDirectionRight;
        popController.delegate = self;
    
        // in case we don't have a bar button as reference
        popController.sourceView = self.face;
        popController.sourceRect = CGRectMake(12.5, 42.5, 0, 0);
    }
    
}

-(void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController{
    
}

@end
