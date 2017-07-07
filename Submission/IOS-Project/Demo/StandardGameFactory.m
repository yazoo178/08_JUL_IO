//
//  StandardGameFactory.m
//  miCity
//
//  Created by acp16w on 16/12/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import "StandardGameFactory.h"
#import "GameConstants.h"
#import "GeneralMethods.h"

@implementation StandardGameFactory

-(CarView*)createCarViewWithModelData:(Car*)car{
    
    UIImage* img = [UIImage imageNamed:car.path];
    CarView* carView = [[CarView alloc]initWithCarModel:car withImage:img];
    carView.frame = CGRectMake(car.locX, car.locY, CAR_WIDTH, CAR_HEIGHT);
    carView.contentMode = UIViewContentModeScaleAspectFit;
    carView.clipsToBounds = YES;
    return carView;
}

-(PowerUpView*)createPowerUpWithModelData:(PowerUp *)pu{
    UIImage* img = [UIImage imageNamed:pu.path];
    PowerUpView* view = [[PowerUpView alloc]initWithImage:img withPowerUp:pu];
    view.frame = CGRectMake(pu.locX, pu.locY, POWER_UP_WIDTH, POWER_UP_HEIGHT);
    view.contentMode = UIViewContentModeScaleAspectFit;
    view.clipsToBounds = YES;
    
    [GeneralMethods growRevertRecur:view xTo:20 dur:0.4];
    return view;
    
}

-(ObstacleView*)createObstacleWithModelData:(Obstacle *)obs{
    UIImage* img = [UIImage imageNamed:obs.path];
    ObstacleView* view = [[ObstacleView alloc]initWithImage:img withObstacle:obs];
    view.frame = CGRectMake(obs.locX, obs.locY, POWER_UP_WIDTH, POWER_UP_HEIGHT);
    view.contentMode = UIViewContentModeScaleAspectFit;
    view.clipsToBounds = YES;
    
    return view;
}

-(ScorePointView*)createScoreViewWithModelData:(ScorePoint *)point{
    UIImage* img = [UIImage imageNamed:point.path];
    ScorePointView* view = [[ScorePointView alloc]initWithImage:img withScore:point];
    view.frame = CGRectMake(point.locX, point.locY, STAR_WIDTH, STAR_HEIGHT);
    view.contentMode = UIViewContentModeScaleAspectFit;
    view.clipsToBounds = YES;
    
    [GeneralMethods growRevertRecur:view xTo:20 dur:0.4];
    return view;
}

@end
