//
//  WebpageDataGrabber.m
//  Demo
//
//  Created by Will on 20/11/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import "WebpageDataGrabber.h"

@implementation WebpageDataGrabber

@synthesize resultData;
bool isComplete = true;

-(id)initWithURL:(NSString *)url{
    self = [super init];
    
    if(self){
        self.URL = url;
    }
    
    return self;
}

-(void)start{
    isComplete = false;
    self.resultData = [self getData];
    
    dispatch_sync(dispatch_get_main_queue(), ^{
        self.completionBlock();
        isComplete = true;
    });
    
}

-(BOOL)isFinished{
    return isComplete;
}

-(NSString*)getData{
    NSURL* url = [NSURL URLWithString:self.URL];
    
    NSData* data = [NSData dataWithContentsOfURL:url];
    
    NSString *string = [NSString stringWithUTF8String:[data bytes]];
    
    return [self stringByStrippingHTML:string];
}

-(NSString *) stringByStrippingHTML:(NSString*)data {
    NSRange r;
    NSString *s = [data copy];
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    return s;
}

@end
