//
//  PowerUp.h
//  miCity
//
//  Created by Will on 18/12/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CarView.h"
#import "GameModelBase.h"

@interface PowerUp : GameModelBase

typedef NS_ENUM(NSInteger, PowerUpType) {
    Repair,
    Shrink,
    PowerUpCount = 2
};

@property (assign)PowerUpType powerUpType;

@end
