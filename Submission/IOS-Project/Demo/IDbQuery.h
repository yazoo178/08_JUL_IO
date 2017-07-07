//
//  IDbCaller.h
//  Demo
//
//  Created by Will on 15/10/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IDbQuery <NSObject>

-(bool)insertWithType:(id)param;
-(id)pullWithId:(NSString*)iD;
-(id)pullWithCustomQuery:(NSString*)query;
-(void)deleteForId:(NSString*)iD;

@end
