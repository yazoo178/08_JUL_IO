//
//  DbTableCreator.h
//  Demo
//
//  Created by Will on 09/10/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DbTableCreator : NSObject
@property (strong, nonatomic) NSMutableArray<NSString*>* dbCreators;
-(id)initDbCreator;

-(void)addDbStr:(NSString*)name;

@end
