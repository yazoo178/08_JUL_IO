//
//  GameViewBase.m
//  miCity
//
//  Created by Will on 18/12/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import "GameViewBase.h"

@implementation GameViewBase

-(void)hookUpObservers{}
-(void)removeObservers{}
    
-(void)update{
    for(GameViewBase* cv in self.superview.subviews){
        if(cv == self){
            continue;
        }
        
        if([cv isKindOfClass:[GameViewBase class]])
        {
            float percentage = 0.175;
            CGRect currentRectPres = CGRectInset(self.frame, CGRectGetWidth(self.frame)*percentage/2, CGRectGetHeight(self.frame)*percentage/2);
            CGRect checkRectPres = CGRectInset(cv.frame, CGRectGetWidth(cv.frame)*percentage/2, CGRectGetHeight(cv.frame)*percentage/2);
            
            if(CGRectIntersectsRect(currentRectPres, checkRectPres)){
                if(self.onContactWith != nil && !self.needs_removing){
                    self.onContactWith(self, cv);
                }
            }
        }
    }
}

-(BOOL)removeIfAtEnd{
    if(self.superview.frame.size.height < self.frame.origin.y && !self.needs_removing){

        [self removeObservers];
        [self removeFromSuperview];
        return true;
    }
    
    return false;
}

@end
