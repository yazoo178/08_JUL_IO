//
//  GameModelBase.m
//  miCity
//
//  Created by Will on 18/12/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import "GameModelBase.h"
#import "Car.h"

@implementation GameModelBase

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)applyAffect:(Car *)source{
    return;
}

@end
