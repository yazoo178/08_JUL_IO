//
//  WeatherWidget.h
//  miCity
//
//  Created by Will on 31/12/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherExtraction.h"

@interface WeatherWidget : UIView

-(id)initWithLongitude:(float)longitude withLatitude:(float)latitude;

@property (strong) WeatherExtraction* extractor;
@property (strong) UIImageView* weatherImg;
@property (strong) UILabel* weatherDesc;
@property (strong) UILabel* tempLabel;
@end
