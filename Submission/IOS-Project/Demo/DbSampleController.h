//
//  DbSampleController.h
//  Demo
//
//  Created by Will on 07/10/2016.
//  Copyright © 2016 Will. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "DbAccess.h"

@interface DbSampleController : UIViewController
- (IBAction)addtoDb:(id)sender;

@property (weak) IBOutlet UITextField *FirstName;
@property (weak) IBOutlet UITextField *LastName;

@end
