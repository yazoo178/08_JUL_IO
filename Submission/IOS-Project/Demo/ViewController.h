//
//  ViewController.h
//  Demo
//
//  Created by Will on 30/09/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "IDbQuery.h"
#import <GoogleMaps/GoogleMaps.h>
#import "MiCityViewController.h"
#import "AddPlaceViewController.h"
#import "EmotionWidget.h"
#import "WeatherWidget.h"

@interface ViewController : MiCityViewController<CLLocationManagerDelegate, GMSMapViewDelegate>

@property (weak) IBOutlet UIView *middleView;
@property (weak) IBOutlet UILabel *labelForCity;
@property (weak) IBOutlet UISlider *zoom;
@property (weak) IBOutlet UILabel *nearLocations;
@property (weak) IBOutlet UITextField* URLSample;
@property (weak) IBOutlet UIButton* socialButton;
@property (weak) IBOutlet UIButton* nearPlacesButton;
@property (weak) IBOutlet UIButton* gameButton;
@property (weak) IBOutlet UIButton* plus;
@property (weak) IBOutlet UIButton* down;
@property (weak) IBOutlet UIView* emotionWidgetView;
@property (strong) EmotionWidget* emotionWidget;
@property (strong) AddPlaceViewController* addPlaceCont;
@property (weak) IBOutlet UIView* weatherWidgetView;
@property (strong) WeatherWidget* weatherWidget;

@property (strong) NSMutableArray* markers;

- (IBAction)zoomchange:(id)sender;
- (IBAction)getCurrentPlace:(UIButton *)sender;



@end

