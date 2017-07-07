//
//  CarView.m
//  miCity
//
//  Created by Will on 17/12/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import "CarView.h"


@implementation CarView

-(id)initWithCarModel:(Car *)car withImage:(UIImage *)image{
    self = [super initWithImage:image];
    
    if(self){
        self.car = car;
        self.currently_intersecting = false;
        [self hookUpObservers];
        self.needs_removing = false;
        self.defaultImage = image;
    }
    
    return self;
}

-(void)hookUpObservers{
    [self.car addObserver:self forKeyPath:@"locX" options:NSKeyValueObservingOptionNew context:Nil];
    [self.car addObserver:self forKeyPath:@"locY"  options:NSKeyValueObservingOptionNew context:Nil];
    [self.car addObserver:self forKeyPath:@"speed"  options:NSKeyValueObservingOptionNew context:Nil];
    [self.car addObserver:self forKeyPath:@"destructionLevel"  options:NSKeyValueObservingOptionNew context:Nil];
    [self.car addObserver:self forKeyPath:@"shrinkModeActive" options:NSKeyValueObservingOptionNew context:Nil];
    [self.car addObserver:self forKeyPath:@"distortedControlsActive" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)applyShrinkTimer{
    CGRect before = self.bounds;
    [UIView animateWithDuration:SHRINK_TIME animations:^{
        self.frame = CGRectMake(self.center.x, self.center.y, (self.bounds.size.width / 100) * SHRINK_PERCENTAGE, (self.bounds.size.height / 100) * SHRINK_PERCENTAGE);
    } completion:^(BOOL finished) {
        [GeneralMethods dispatchAfter:SHRINK_POWER_UP_DURATION codeBlock:^{
            [UIView animateWithDuration:SHRINK_TIME animations:^{
                self.bounds = before;
            } completion:^(BOOL finished) {
                self.car.shrinkModeActive = false;
            }];
        }];
    }];
}

-(void)distortControls{
    hitCount = 0;
    distortTimer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                               target:self
                                             selector:@selector(updateControls)
                                             userInfo:nil
                                              repeats:YES];
}
NSTimer* distortTimer;
int hitCount = 0;
-(void)updateControls{
    if(hitCount == DISTORT_CONTROLS_DURATION * 10){
        [distortTimer invalidate];
        distortTimer = nil;
        self.car.distortedControlsActive = false;
        return;
    }
    
    int direction = arc4random() % 2;
    int judderAmount = arc4random() % 20;
    UIView* parent = self.superview;
    
    if(direction == 0){
        if(self.frame.origin.x + self.frame.size.width + judderAmount < parent.bounds.size.width){
            self.car.locX+=judderAmount;
        }
    }
    
    else if(direction == 1){
        if(self.frame.origin.x - judderAmount > parent.bounds.origin.x){
            self.car.locX-=judderAmount;
        }
        
    }
    
    hitCount++;
    
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    if([keyPath isEqualToString:@"locX"] ||[keyPath isEqualToString:@"locY"]){
        self.center = CGPointMake(self.car.locX, self.car.locY);
    }

    else if([keyPath isEqualToString:@"destructionLevel"]){
        [self setNextImage];
        return;
    }
    
    else if([keyPath isEqualToString:@"shrinkModeActive"]){
        if(self.car.shrinkModeActive){
            [self applyShrinkTimer];
            return;
        }
    }
    
    else if([keyPath isEqualToString:@"distortedControlsActive"]){
        if(self.car.distortedControlsActive){
            [self distortControls];
            return;
        }
    }
    
    [self update];
    
    if([self removeIfAtEnd]){
        self.car.isOutOfBounds = true;
    }

}

-(void)update{
    for(CarView* cv in self.superview.subviews){
        if(cv == self){
            continue;
        }
        
        if([cv isKindOfClass:[CarView class]])
        {
            float widthPercentage = 0.175;
            float heightPercentage = 0.250;
            CGRect currentRectPres = CGRectInset(self.frame, CGRectGetWidth(self.frame)*widthPercentage/2, CGRectGetHeight(self.frame)*heightPercentage/2);
            CGRect checkRectPres = CGRectInset(cv.frame, CGRectGetWidth(cv.frame)*widthPercentage/2, CGRectGetHeight(cv.frame)*heightPercentage/2);
            
            
            if(CGRectIntersectsRect(currentRectPres, checkRectPres)){
                if(self.onContactWith != nil && !self.needs_removing){
                    self.onContactWith(self, cv);
                    self.needs_removing = true;
                }
            }
        }
    }
}

-(void)setNextImage{
    if(self.car.destructionLevel == -1){
        self.image = self.defaultImage;
    }
    else{
        self.image = self.destructionImages[self.car.destructionLevel];
    }
}

-(void)removeObservers{
    @try {
        [self.car removeObserver:self forKeyPath:@"locX"];
        [self.car removeObserver:self forKeyPath:@"locY"];
        [self.car removeObserver:self forKeyPath:@"speed"];
        [self.car removeObserver:self forKeyPath:@"destructionLevel"];
        [self.car removeObserver:self forKeyPath:@"shrinkModeActive"];
        [self.car removeObserver:self forKeyPath:@"distortedControlsActive"];
    } @catch (NSException *exception) {
    }
        

}

@end
