//
//  ObstacleView.m
//  miCity
//
//  Created by Will on 20/12/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import "ObstacleView.h"

@implementation ObstacleView

-(id)initWithImage:(UIImage *)image withObstacle:(Obstacle *)obstacle{
    self = [super initWithImage:image];
    
    if(self){
        self.obs = obstacle;
        [self hookUpObservers];
        self.needs_removing = false;
    }
    
    return self;
    
}


-(void)hookUpObservers{
    [self.obs addObserver:self forKeyPath:@"locX" options:NSKeyValueObservingOptionNew context:Nil];
    [self.obs addObserver:self forKeyPath:@"locY"  options:NSKeyValueObservingOptionNew context:Nil];
}

-(void)removeObservers{
    [self.obs removeObserver:self forKeyPath:@"locY"];
    [self.obs removeObserver:self forKeyPath:@"locX"];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    self.center = CGPointMake(self.center.x, self.obs.locY);
    
    [self update];
    if([self removeIfAtEnd]){
        self.obs.isOutOfBounds = true;
    }
    
}
@end
