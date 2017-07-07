//
//  GeneralMethods.m
//  Kappenball
//
//  Created by Will on 24/10/2016.
//  Copyright © 2016 acp16w. All rights reserved.
//

#import "GeneralMethods.h"

@implementation GeneralMethods

//Loops through all the subviews of a view specified
//Invokes the block on each view
//Recursivly goes through each child view
+ (void)processSubviewsRecur:(UIView *)view onFound:(void(^)(UIView*))found {
    
    NSArray *views = [view subviews];
    
    if ([views count] < 1) return;
    
    for (UIView *subview in views) {
        found(subview);
        //Recursive call, now loop all the sub views
        [self processSubviewsRecur:subview onFound:found];
    }
}

//Shrinks then grows a ui view
//Over a specified duration
//Callback when the whole process has completed
+(void)scaleThenRevert:(UIView *)view fromFloat:(CGFloat)from durationFloat:(CGFloat)duration onComplete:(void (^)())complete withRotate:(BOOL)rotate revertTo:(CGAffineTransform) revert{
    if([self areWeBeingUnitTested] || [self isRunningUITest]){ return; }
    
    [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        CGAffineTransform shrink = CGAffineTransformMakeScale(from, from);
        
        view.transform = rotate ? CGAffineTransformConcat(shrink, CGAffineTransformRotate(view.transform, M_PI))
        : shrink;
        
    }completion:^(BOOL finished){
        [UIView animateWithDuration:duration animations:^{
            
            view.transform = revert;
        } completion:^(BOOL finished){
            if(complete != nil)
            {
                complete();
            }
        }];
    }];
}

//Shrinks then grows a ui view
//Over a specified duration
//Callback when the whole process has completed
+(void)scaleAppear:(UIView *)view toFloat:(CGFloat)to durationFloat:(CGFloat)duration onComplete:(void (^)())complete revertTo:(CGAffineTransform) revert{
    if([self areWeBeingUnitTested] || [self isRunningUITest]){ return; }
    
    [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        CGAffineTransform shrink = CGAffineTransformMakeScale(to, to);
        view.transform = shrink;
    }completion:^(BOOL finished){
        [UIView animateWithDuration:duration animations:^{
            
            view.transform = revert;
        } completion:^(BOOL finished){
            if(complete != nil)
            {
                complete();
            }
        }];
    }];
}


//Rotates a ui view forever
//with a specified duration to complete a 90 degree cycle
//with movement from left to right
+(void)rotateRecurWithMovement:(UIImageView*)view withDuration:(float)dur withMovement:(float)amount{
    if([self areWeBeingUnitTested] || [self isRunningUITest]){ return; }
    
    [UIView animateWithDuration:dur delay:0 options:UIViewAnimationOptionCurveLinear  animations:^{
        view.transform = CGAffineTransformRotate(view.transform, M_PI / 2);
        view.center = CGPointMake(view.center.x + amount, view.center.y);
        
    }completion:^(BOOL finished){
        [self rotateRecurWithMovement:view withDuration:dur withMovement:amount];
        if(view.frame.origin.x >= view.superview.frame.size.width){
            view.center = CGPointMake(view.superview.frame.origin.x - (view.bounds.size.width / 2), view.center.y);
        }
    }];
}

//Rotates a ui view forever
//with a specified duration to complete a 90 degree cycle
+(void)rotateRecur:(UIImageView*)view withDuration:(float)dur{
    if([self areWeBeingUnitTested] || [self isRunningUITest]){ return; }
    
    [UIView animateWithDuration:dur delay:0 options:UIViewAnimationOptionCurveLinear  animations:^{
        view.transform = CGAffineTransformRotate(view.transform, M_PI / 2);
        
    }completion:^(BOOL finished){
        [self rotateRecur:view withDuration:dur];
    }];
}


+(void)upDownAnimate:(UIView *)view xTo:(CGFloat)to dur:(CGFloat)duration dir:(BOOL)direction{
    if([self areWeBeingUnitTested] || [self isRunningUITest]){ return; }
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionAutoreverse|UIViewAnimationOptionRepeat  animations:^{
        view.center = CGPointMake(view.center.x, view.center.y + to);
    }completion:^(BOOL finished){
        //[self upDownAnimate:view xTo:to dur:duration dir:direction];
    }];
     
    
}

+(void)growRevertRecur:(UIView*)view xTo:(CGFloat)to dur:(CGFloat)duration{
    if([self areWeBeingUnitTested] || [self isRunningUITest]){ return; }
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionAutoreverse|UIViewAnimationOptionRepeat|UIViewAnimationOptionAllowUserInteraction animations:^{
        view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width+to, view.frame.size.height+to);
    } completion:^(BOOL finished) {

    }];
}


+(void)dispatchAfter:(double)seconds codeBlock:(void (^)())block{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        block();
    });
}

+(BOOL)isRunningUITest{
    NSDictionary *environment = [[NSProcessInfo processInfo] environment];
    if (environment[@"isUITest"]) {
        return YES;
    }
    
    return NO;
}

// Returns YES if we are currently being unittested.
+ (BOOL)areWeBeingUnitTested {
    BOOL answer = NO;
    Class testProbeClass;
#if GTM_USING_XCTEST // you may need to change this to reflect which framework are you using
    testProbeClass = NSClassFromString(@"XCTestCase");
#else
    testProbeClass = NSClassFromString(@"SenTestProbe");
#endif
    if (testProbeClass != Nil) {
        // Doing this little dance so we don't actually have to link
        // SenTestingKit in
        SEL selector = NSSelectorFromString(@"isTesting");
        NSMethodSignature *sig = [testProbeClass methodSignatureForSelector:selector];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:sig];
        [invocation setSelector:selector];
        [invocation invokeWithTarget:testProbeClass];
        [invocation getReturnValue:&answer];
    }
    return answer;
}



@end
