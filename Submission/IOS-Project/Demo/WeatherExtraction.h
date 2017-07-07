//
//  WeatherExtraction.h
//  miCity
//
//  Created by Projects on 31/12/2016.
//  Copyright © 2016 acp16ssc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherExtraction : NSObject

-(id)initWithLatitude :(float)latitude longitude:(float)longitude;

@property (assign) float cityLatitude;
@property (assign) float cityLongitude;

@property (nonatomic, copy) void (^weatherChanged)(NSDictionary* weatherChange, NSData* tempCity);

-(void)manualWeatherUpdate:(float)latitude longitude:(float)longitude;

-(void)getWeather;
@end
