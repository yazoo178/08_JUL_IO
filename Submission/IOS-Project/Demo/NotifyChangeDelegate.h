//
//  NotifyChangeDelegate.h
//  Demo
//
//  Created by Will on 12/10/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NotifyChangeDelegate <NSObject>

- (void) notify:(id)sender val:(id)value;
@end
