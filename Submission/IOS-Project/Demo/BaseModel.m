//
//  BaseModel.m
//  Demo
//
//  Created by Will on 12/10/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import "BaseModel.h"

@interface BaseModel()
{
    @protected
    NSMutableDictionary *pointersToCallBacks;
}

@end

@implementation BaseModel

-(id)init{
    self = [super init];
    
    if(self){
        pointersToCallBacks = [[NSMutableDictionary alloc]init];
    }
    
    return self;
}

-(void) addMethodPointer:(NSString *)identif arg:(void (^)(id))val{
    pointersToCallBacks[identif] = val;
}

-(void (^)(id))getMethodForString:(NSString *)identif{
    return pointersToCallBacks[identif];
}


@end
