//
//  MiCityViewController.h
//  Demo
//
//  Created by William Briggs on 12/12/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IDbQuery.h"

//Base Controller for ALL miCity View Controllers
@interface MiCityViewController : UIViewController


@property (nonatomic, strong) id<IDbQuery> inserter;
-(void)createInserterForThisView;
-(void)stylizeView:(UIView*)view width:(int)boarderWidth rad:(int)radius;
-(void)popoutView:(UIView*)view;
@end
