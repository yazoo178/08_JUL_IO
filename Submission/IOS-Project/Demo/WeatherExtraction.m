//
//  WeatherExtraction.m
//  miCity
//
//  Created by Projects on 31/12/2016.
//  Copyright © 2016 acp16ssc. All rights reserved.
//

#import "WeatherExtraction.h"

@implementation WeatherExtraction

NSTimer *timerForWeather;

-(id)initWithLatitude :(float)latitude longitude:(float)longitude
{
    self = [super init];
    
    if(self)
    {
        self.cityLatitude = latitude;
        self.cityLongitude = longitude;
        [self startWeatherTimer];
    }
    return self;
}

// Initialise timer
-(void)startWeatherTimer
{
    timerForWeather = [NSTimer scheduledTimerWithTimeInterval:1800.0f
                                                       target:self
                                                     selector:@selector(tickHandler:)
                                                     userInfo:nil
                                                      repeats:YES];
    //[timerForWeather release];
}

-(void)stopTimer
{
    if (timerForWeather)
    {
        [timerForWeather invalidate];
        timerForWeather = nil;
    }
}

-(void)tickHandler:(NSTimer *)timerForWeather
{
    [self getWeather];
}

-(void) getWeather
{
    //float latitude = -0.13;
    //float longitude = 51.51;
    NSString * urlString = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?lat=%f&lon=%f&units=metric&APPID=ddcd64f7609648cd9f3f94552a33b557", self.cityLatitude, self.cityLongitude];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
    {
      if (data)
      {
          NSHTTPURLResponse * httpResponse  = (NSHTTPURLResponse*)response;
          NSInteger statusCode = httpResponse.statusCode;
          if (statusCode == 200)
          {
              NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
              NSArray *weatherArray = [dictionary objectForKey:@"weather"];
              NSDictionary *weatherDict = [weatherArray firstObject];

              NSArray *weatherArrayTemp = [dictionary objectForKey:@"main"];
              //NSDictionary *weatherDictTemp = [weatherArrayTemp firstObject];
              NSData * tempCity = [weatherArrayTemp valueForKey:@"temp"];
              
              NSString* mainWeather = [weatherDict valueForKey:@"main"];
              NSString* weatherDescription = [weatherDict valueForKey:@"description"];
              NSString* icon = [weatherDict valueForKey:@"icon"];
              //NSLog(@"Weather: %@\n%@\n%@\n%@\n", mainWeather, weatherDesc, weatherIcon, weatherDict);
              if((mainWeather != NULL) && (weatherDescription != NULL) && (icon != NULL))
              {
                  // update weather widget
                  NSLog(@"Weather: %@\n", mainWeather);
                  
              }
              else
              {
                  NSLog(@"Error in getting weather information from webpage");
              }
              
              if(self.weatherChanged != nil){
                  dispatch_async(dispatch_get_main_queue(), ^{
                      self.weatherChanged(weatherDict, tempCity);
                  });
                  
              }
              
          }
      }
      else if (error)
      {
          NSLog(@"Error in getting weather information");
      }
      
    }];
    
    [dataTask resume];
    [session finishTasksAndInvalidate];
    
    
}

-(void)manualWeatherUpdate:(float)latitude longitude:(float)longitude
{
    self.cityLatitude = latitude;
    self.cityLongitude = longitude;
    [self getWeather];
}


@end
