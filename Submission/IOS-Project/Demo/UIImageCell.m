//
//  UIImageCell.m
//  Demo
//
//  Created by acp16w on 14/12/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import "UIImageCell.h"

@implementation UIImageCell

-(id)init{
    self = [super init];
    
    if(self){
        //[self popoutView:self.imageView];
    }
    
    return self;
}

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if(self){
        //[self popoutView:self.imageView];
    }
    
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    
    if(self){
        //[self popoutView:self.imageView];
    }
    
    return self;
}

-(void)popoutView:(UIView*)view{
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowOffset = CGSizeMake(10, 10);
    view.layer.shadowOpacity = 0.8;
    view.layer.shadowRadius = 5.0;
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    return YES;
}

-(void)fullScreen:(id)arg{
    
}

@end
