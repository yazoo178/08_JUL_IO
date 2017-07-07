//
//  GameData.h
//  miCity
//
//  Created by Will on 21/12/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameConstants.h"

@interface GameData : NSObject

@property (assign) int currentWave;
@property (assign) double trafficLevel;
@property (assign) int speedFrom;
@property (assign) int speedTo;
@property (assign) double obstacleRate;
@property (assign) int scrollSpeed;
@property (strong) NSString* score;
@property (strong) NSString* emotion;
@end
