//
//  BaseModel.h
//  Demo
//
//  Created by Will on 12/10/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NotifyChangeDelegate.h"

@interface BaseModel : NSObject
    

@property(nonatomic, weak) id<NotifyChangeDelegate> delegate;

-(void)addMethodPointer: (NSString*) identif arg:(void(^)(id item))val;
-(void(^)(id item))getMethodForString:(NSString*) identif;
@end
