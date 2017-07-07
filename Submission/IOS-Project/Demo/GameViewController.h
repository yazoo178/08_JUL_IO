//
//  GameViewController.h
//  Demo
//
//  Created by acp16w on 14/12/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import "MiCityViewController.h"
#import "IGameFactory.h"
#import "Car.h"
#import "GameConstants.h"
#import "StandardGameFactory.h"
#import "CarView.h"
#import "Obstacle.h"
#import "ObstacleView.h"
#import "GameData.h"
#import "TwitterSentiment.h"
#include <math.h>
#include "Tweet.h"
#include "EmotionWidget.h"
#include "Popups.h"

@interface GameViewController : MiCityViewController<UIGestureRecognizerDelegate>

@property (strong) Car* car;
@property (strong) NSObject<IGameFactory>* gameFactory;
@property (strong) CarView* carView;
@property (strong) NSMutableArray* gameObjects;
@property (weak) IBOutlet UILabel* waveLabel;
@property (weak) IBOutlet UILabel* scoreLabel;
@property (strong) GameData* gameData;

@property (weak) IBOutlet UIView* emotionWidget;
@property (strong) EmotionWidget* emotion;
-(IBAction)startPress:(id)sender;
-(IBAction)stopPress:(id)sender;
@property (assign) double emotionFactor;
@property (assign) IBOutlet UIView* arrowView;
@property (strong) UIImageView* right;
@property (strong) UIImageView* left;

@property (strong) UIImage* leftDefault;
@property (strong) UIImage* rightDefault;

@property (strong) UIImage* leftDown;
@property (strong) UIImage* rightDown;
@end
