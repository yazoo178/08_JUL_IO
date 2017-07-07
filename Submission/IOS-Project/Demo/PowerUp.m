//
//  PowerUp.m
//  miCity
//
//  Created by Will on 18/12/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import "PowerUp.h"

@implementation PowerUp


-(void)applyAffect:(Car *)source{
    switch(self.powerUpType){
        case Repair:
            source.destructionLevel = -1;
            break;
        case Shrink:
            if(!source.shrinkModeActive){
                source.shrinkModeActive = true;
            }
            break;
            
        case PowerUpCount:
            break;
                    
    }
}

@end
