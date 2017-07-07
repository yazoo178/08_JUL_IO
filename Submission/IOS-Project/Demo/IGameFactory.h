//
//  IGameFactory.h
//  miCity
//
//  Created by acp16w on 16/12/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Car.h"
#import "CarView.h"
#import "PowerUpView.h"
#import "PowerUp.h"
#import "Obstacle.h"
#import "ObstacleView.h"
#import "ScorePoint.h"
#import "ScorePointView.h"

@protocol IGameFactory <NSObject>

-(CarView*)createCarViewWithModelData:(Car*)car;
-(PowerUpView*)createPowerUpWithModelData:(PowerUp*)pu;
-(ObstacleView*)createObstacleWithModelData:(Obstacle*)obs;
-(ScorePointView*)createScoreViewWithModelData:(ScorePoint*)point;


@end
