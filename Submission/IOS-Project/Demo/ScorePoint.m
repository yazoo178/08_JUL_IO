//
//  ScorePoint.m
//  miCity
//
//  Created by Will on 22/12/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import "ScorePoint.h"
#import "Car.h"

@implementation ScorePoint

-(void)applyAffect:(Car *)source{
    source.hitPoint = YES;
}

@end
