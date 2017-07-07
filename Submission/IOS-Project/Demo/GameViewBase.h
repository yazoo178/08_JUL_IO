//
//  GameViewBase.h
//  miCity
//
//  Created by Will on 18/12/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GeneralMethods.h"
#import "GameConstants.h"

@interface GameViewBase : UIImageView

-(void)hookUpObservers;
-(void)removeObservers;
-(void)update;
-(BOOL)removeIfAtEnd;
@property (nonatomic, copy) void (^onContactWith)(GameViewBase*from, UIView*with);


@property (assign) bool needs_removing;

@end
