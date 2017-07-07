//
//  GeneralMethods.h
//  Kappenball
//
//  Created by Will on 24/10/2016.
//  Copyright © 2016 acp16w. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface GeneralMethods : NSObject

+ (void)processSubviewsRecur:(UIView *)view onFound:(void(^)(UIView*))found;
+(void)scaleThenRevert:(UIView *)view fromFloat:(CGFloat)from durationFloat:(CGFloat)duration onComplete:(void (^)())complete withRotate:(BOOL)rotate revertTo:(CGAffineTransform)revert;
+(void)rotateRecur:(UIImageView*)view withDuration:(float)dur;
+(void)scaleAppear:(UIView *)view toFloat:(CGFloat)to durationFloat:(CGFloat)duration onComplete:(void (^)())complete revertTo:(CGAffineTransform) revert;
+(void)upDownAnimate:(UIView*)view xTo:(CGFloat)to dur:(CGFloat)duration dir:(BOOL)direction;
+(void)growRevertRecur:(UIView*)view xTo:(CGFloat)to dur:(CGFloat)duration;
+(void)dispatchAfter:(double)seconds codeBlock:(void (^)())block;
+(void)rotateRecurWithMovement:(UIImageView*)view withDuration:(float)dur withMovement:(float)amount;

@end
