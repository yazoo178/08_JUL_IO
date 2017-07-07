//
//  GameConstants.h
//  miCity
//
//  Created by Will on 17/12/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameConstants : NSObject

extern float const CAR_WIDTH;
extern float const CAR_HEIGHT;

extern float const POWER_UP_HEIGHT;
extern float const POWER_UP_WIDTH;

extern float const STAR_WIDTH;
extern float const STAR_HEIGHT;

extern int const MAX_SPEED;
extern int const MIN_SPEED;

extern int const DEFAULT_CAR_RATE;
extern int const DEFAULT_POWER_UP_RATE;
extern int const DEFAULT_OBSTACLE_RATE;
extern int const DEFAULT_RATE_OF_STAR;

extern float const SHRINK_TIME;
extern int const SHRINK_PERCENTAGE;
extern int const SHRINK_POWER_UP_DURATION;

extern NSString * const POWER_UP_FILE_NAMES[];
extern NSString * const CAR_FILE_NAMES[];
extern NSString* const OBSTACLE_FILE_NAMES[];

extern int const CAR_COUNTS;

extern int const DISTORT_CONTROLS_DURATION;

extern double const POSITVE_INTENSIFIER;
extern double const NEGATIVE_INTENSIFIER;
@end
