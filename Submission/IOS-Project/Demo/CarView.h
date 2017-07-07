//
//  CarView.h
//  miCity
//
//  Created by Will on 17/12/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import "Car.h"
#import "GameViewBase.h"

@interface CarView : GameViewBase

-(id)initWithCarModel:(Car*)car withImage:(UIImage*)image;
-(void)hookUpObservers;
-(void)removeObservers;
-(void)setNextImage;
@property (strong) NSArray* destructionImages;
@property (assign) bool currently_intersecting;
@property (weak) Car* car;
@property (strong) UIImage* defaultImage;
@end
