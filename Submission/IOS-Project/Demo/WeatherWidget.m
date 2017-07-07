//
//  WeatherWidget.m
//  miCity
//
//  Created by Will on 31/12/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import "WeatherWidget.h"

@implementation WeatherWidget

-(id)initWithLongitude:(float)longitude withLatitude:(float)latitude{
    self = [super init];
    if(self){
        [self createWeatherImg];
        [self createDescriptionLabel];
        [self createTempLabel];
        self.extractor = [[WeatherExtraction alloc]initWithLatitude:latitude longitude:longitude];
        
        __weak WeatherWidget *weakSelf = self;
        self.extractor.weatherChanged = ^(NSDictionary* data, NSData* tempCity){
            [weakSelf weatherUpdateRecieved:data temp:tempCity];
        };
    }
    return self;
}

-(void)createDescriptionLabel{
    self.weatherDesc = [[UILabel alloc]initWithFrame:CGRectMake(5, 40, 200, 50)];
    self.weatherDesc.font = [UIFont fontWithName:@"HelveticaNeue-MediumItalic" size:18];
    self.weatherDesc.textColor = [UIColor blueColor];
    [self addSubview:self.weatherDesc];
}

-(void)createTempLabel{
    self.tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 60, 200, 50)];
    self.tempLabel.font = [UIFont fontWithName:@"HelveticaNeue-MediumItalic" size:18];
    self.tempLabel.textColor = [UIColor blueColor];
    [self addSubview:self.tempLabel];
}

-(void)createWeatherImg{
    self.weatherImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 70, 70)];
    [self addSubview:self.weatherImg];
}

-(void)weatherUpdateRecieved:(NSDictionary*)data temp:(NSData*)tempCity{
    
    UIImage* img = [UIImage imageNamed:[data valueForKey:@"icon"]];
    self.weatherImg.image = img;
    [self.weatherImg setNeedsDisplay];
    self.weatherDesc.text = [[data valueForKey:@"description"] capitalizedString];
    [self.weatherDesc setNeedsDisplay];
    self.tempLabel.text = [NSString stringWithFormat:@"%@%@C", tempCity, @"\u00B0"];
    [self.tempLabel setNeedsDisplay];
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
