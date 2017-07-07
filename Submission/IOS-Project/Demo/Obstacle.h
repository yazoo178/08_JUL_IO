//
//  Obstacle.h
//  miCity
//
//  Created by Will on 20/12/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import "GameModelBase.h"


@interface Obstacle : GameModelBase

typedef NS_ENUM(NSInteger, ObstacleType) {
    Oil,
    ObstaclTypeCount = 1
};


@property (assign)ObstacleType obstacleType;

@end
