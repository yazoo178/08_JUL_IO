//
//  PopUpViewController.h
//  miCity
//
//  Created by Will on 29/12/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GeneralMethods.h"

@interface PopUpViewController : UIViewController

@property (weak) IBOutlet UILabel* titleLabel;
@property (weak) IBOutlet UILabel* line1;
@property (weak) IBOutlet UILabel* line2;
@property (weak) IBOutlet UILabel* line3;
@property (weak) IBOutlet UILabel* line4;

@property (weak) NSString* titleText;
@property (weak) NSString* line1Text;
@property (weak) NSString* line2Text;
@property (weak) NSString* line3Text;
@property (weak) NSString* line4Text;

@property (weak) UIImage* imgPath;

@property (weak) IBOutlet UIImageView* middleView;

@end
