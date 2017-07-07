//
//  GameModelBase.h
//  miCity
//
//  Created by Will on 18/12/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Car;


@interface GameModelBase : NSObject

@property (assign) int locX;
@property (assign) int locY;
@property (strong) NSString* path;
@property (assign) bool isOutOfBounds;
-(void)applyAffect:(Car*)source;

@end
