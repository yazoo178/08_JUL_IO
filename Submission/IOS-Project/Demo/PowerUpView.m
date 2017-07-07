//
//  PowerUpView.m
//  miCity
//
//  Created by Will on 18/12/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import "PowerUpView.h"

@implementation PowerUpView

-(id)initWithImage:(UIImage *)image withPowerUp:(PowerUp *)powerUp{
    self= [super initWithImage:image];
    
    if(self){
        self.powerUp = powerUp;
        [self hookUpObservers];
        self.needs_removing = false;
    }
    
    return self;
}


-(void)hookUpObservers{
    [self.powerUp addObserver:self forKeyPath:@"locX" options:NSKeyValueObservingOptionNew context:Nil];
    [self.powerUp addObserver:self forKeyPath:@"locY"  options:NSKeyValueObservingOptionNew context:Nil];
}

-(void)removeObservers{
    [self.powerUp removeObserver:self forKeyPath:@"locY"];
    [self.powerUp removeObserver:self forKeyPath:@"locX"];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    self.center = CGPointMake(self.center.x, self.powerUp.locY);
    
    [self update];
    if([self removeIfAtEnd]){
        self.powerUp.isOutOfBounds = true;
    }
    
}

@end
