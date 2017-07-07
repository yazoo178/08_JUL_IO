//
//  WebpageDataGrabber.h
//  Demo
//
//  Created by Will on 20/11/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IDataGrabber.h"


@interface WebpageDataGrabber : NSOperation<IDataGrabber>
@property (nonatomic, strong) NSString* URL;
-(id)initWithURL:(NSString*)url;

@end
