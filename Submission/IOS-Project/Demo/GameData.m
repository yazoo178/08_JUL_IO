//
//  GameData.m
//  miCity
//
//  Created by Will on 21/12/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import "GameData.h"

@implementation GameData

-(id)init{
    
    self = [super init];
    if(self){
        self.currentWave = 0;
        self.trafficLevel = DEFAULT_CAR_RATE;
        self.speedFrom = MIN_SPEED;
        self.speedTo = MAX_SPEED;
        self.obstacleRate = DEFAULT_OBSTACLE_RATE;
        self.scrollSpeed = 1;
        
    }
    
    return self;
}


@end
