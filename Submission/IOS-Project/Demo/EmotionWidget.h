//
//  EmotionWidget.h
//  miCity
//
//  Created by Will on 30/12/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TwitterSentiment.h"
#import "Constants.h"
#import "MiCityViewController.h"
#import "PopUpViewController.h"

@interface EmotionWidget : UIView<UIPopoverPresentationControllerDelegate>

typedef enum EmotionType
{
    Happy,
    Sad,
    Normal
} EmotionType;

-(void)updateEmotion;
-(id)initWithSourceController:(MiCityViewController*)source;

@property (strong) UIImageView* face;
@property (strong) UIImageView* arrow;
@property (weak) MiCityViewController* sourceController;
@property (nonatomic, copy) void (^configPopup)(PopUpViewController* popOver);
@property (nonatomic, copy) void (^facePress)(void);
@property (nonatomic, copy) void (^emotionChanged)(EmotionType emotionType);
@property (strong) NSString* currentEmotionImg;
@end
