//
//  MiCityViewController.m
//  Demo
//
//  Created by William Briggs on 12/12/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import "MiCityViewController.h"
#import "Constants.h"

//Base Controller for ALL miCity View Controllers
@interface MiCityViewController ()

@end

@implementation MiCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    int width = self.view.frame.size.width;
    int height = self.view.frame.size.height;
    
    UIImage* bg = [UIImage imageNamed:BACKGROUND_IMG];
    UIImageView * bgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    bgView.image = bg;
    [self.view addSubview:bgView];
    [self.view sendSubviewToBack:bgView];
    [self createInserterForThisView];
}

-(void)stylizeView:(UIView*)view width:(int)boarderWidth rad:(int)radius{
    view.layer.borderColor = [UIColor blackColor].CGColor;
    view.layer.borderWidth = boarderWidth;
    view.layer.cornerRadius = radius;
}

-(void)popoutView:(UIView*)view{
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowOffset = CGSizeMake(10, 10);
    view.layer.shadowOpacity = 0.8;
    view.layer.shadowRadius = 5.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createInserterForThisView{
    self.inserter = nil;
}



@end
