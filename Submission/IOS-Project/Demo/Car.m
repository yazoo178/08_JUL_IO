//
//  Car.m
//  miCity
//
//  Created by acp16w on 16/12/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import "Car.h"

@implementation Car

-(id)initCarWithFileName:(NSString *)file{
    self = [super init];
    
    if(self) {
        self.path = file;
        self.isOutOfBounds = false;
        self.destructionLevel = -1;
        self.shrinkModeActive = false;
        self.distortedControlsActive = false;
    }
    
    return self;
}

@end
