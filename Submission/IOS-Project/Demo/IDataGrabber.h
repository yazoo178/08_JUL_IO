//
//  IDataGrabber.h
//  Demo
//
//  Created by Will on 20/11/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IDataGrabber <NSObject>

-(NSString*)getData;
@property (nonatomic, strong) NSString* resultData;
@end
