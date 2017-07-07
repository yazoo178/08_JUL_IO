//
//  Obstacle.m
//  miCity
//
//  Created by Will on 20/12/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import "Obstacle.h"
#import "Car.h"

@implementation Obstacle

-(void)applyAffect:(Car *)source{
    switch(self.obstacleType){
        case Oil:
            if(!source.distortedControlsActive){
                source.distortedControlsActive = true;
            }
        case ObstaclTypeCount:
            break;
    }
    
}

@end
