//
//  PopUpViewController.m
//  miCity
//
//  Created by Will on 29/12/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import "PopUpViewController.h"

@interface PopUpViewController ()

@end

@implementation PopUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = self.titleText;
    self.line1.text = self.line1Text;
    self.line2.text = self.line2Text;
    self.line3.text = self.line3Text;
    self.line4.text = self.line4Text;
    self.middleView.image = self.imgPath;
    [self animateMiddleView];
    
    
}

-(void)animateMiddleView{
    [GeneralMethods rotateRecurWithMovement:self.middleView withDuration:0.5 withMovement:12];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
