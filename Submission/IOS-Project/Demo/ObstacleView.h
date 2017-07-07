//
//  ObstacleView.h
//  miCity
//
//  Created by Will on 20/12/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import "GameViewBase.h"
#import "Obstacle.h"

@interface ObstacleView : GameViewBase

-(id)initWithImage:(UIImage *)image withObstacle:(Obstacle*)obstacle;

@property (weak) Obstacle* obs;

@end
