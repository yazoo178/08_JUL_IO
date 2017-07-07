//
//  Car.h
//  miCity
//
//  Created by acp16w on 16/12/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import "GameModelBase.h"

@interface Car : GameModelBase

-(id)initCarWithFileName:(NSString*)file;

@property (assign) float speed;
@property (assign) int destructionLevel;
@property (assign) bool shrinkModeActive;
@property (assign) bool distortedControlsActive;
@property (assign) bool hitPoint;

@end
