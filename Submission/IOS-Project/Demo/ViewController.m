//
//  ViewController.m
//  Demo
//
//  Created by Will on 30/09/2016.
//  Copyright © 2016 Will. All rights reserved.
//
//AIzaSyDMtrJXX1EDWF-GJL43btV3dueyQF5u_wo
//
//

#import "ViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "MapMoveHandler.h"
#import <GooglePlacePicker/GooglePlacePicker.h>
#import "FavePlaceInserter.h"
#import "SocialViewController.h"
#import "Place.h"

@interface ViewController ()

@end

@implementation ViewController

CLLocationManager *_manager;
GMSMapView        *mapView;
MapMoveHandler    *MoveLogger;
GMSPlacesClient *_placesClient;

//MAIN VIEW CONTROLLER
//HOME SCREEN

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self Init];
    self.markers = [[NSMutableArray alloc]init];
    [self stylizeView:self.middleView width:5 rad:5];
    [self popoutView:self.middleView];
    
    [self stylizeView:self.socialButton width:5 rad:5];
    [self popoutView:self.socialButton];
    
    [self stylizeView:self.nearPlacesButton width:5 rad:5];
    [self popoutView:self.nearPlacesButton];
    
    [self stylizeView:self.gameButton width:5 rad:5];
    [self popoutView:self.gameButton];
    


}

- (void)viewDidAppear:(BOOL)animated{
    for(GMSMarker* marker in self.markers){
        marker.map = mapView;
    }
    
    //Update the emotion widget
    self.emotionWidget = [[EmotionWidget alloc]initWithSourceController:self];
    [self.emotionWidgetView addSubview:self.emotionWidget];
    self.emotionWidget.frame = self.emotionWidget.superview.bounds;
    
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [self.emotionWidget removeFromSuperview];
    self.emotionWidget = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)Init{
    if([CLLocationManager locationServicesEnabled])
    {
        _manager = [[CLLocationManager alloc]init];
        _manager.desiredAccuracy = kCLLocationAccuracyKilometer;
        _manager.distanceFilter = 500;
        
        if([_manager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
            [_manager requestAlwaysAuthorization];
        }
             
        [_manager startUpdatingLocation];
    }
    
    _placesClient = [GMSPlacesClient sharedClient];
    
    
    MoveLogger = [[MapMoveHandler alloc] init];
    
    MoveLogger.locationChangedFirstTime = ^{
        double longi = MoveLogger.lastLoc.coordinate.longitude;
        double latitude = MoveLogger.lastLoc.coordinate.latitude;
        
        self.weatherWidget = [[WeatherWidget alloc]initWithLongitude:longi withLatitude:latitude];
        [self.weatherWidgetView addSubview:self.weatherWidget];
        self.weatherWidget.frame = self.weatherWidget.superview.bounds;
    };
    
    MoveLogger.locationChanged = ^{
        double longi = MoveLogger.lastLoc.coordinate.longitude;
        double latitude = MoveLogger.lastLoc.coordinate.latitude;
        
       [self.weatherWidget.extractor manualWeatherUpdate:latitude longitude:longi];
    };
    
    _manager.delegate = MoveLogger;
    
    self.view.autoresizesSubviews = YES;
    [self.view setAutoresizingMask:UIViewAutoresizingFlexibleWidth |
     UIViewAutoresizingFlexibleHeight];
    
    mapView = [self gettMapView:nil];
    MoveLogger.middleView = mapView;
    MoveLogger.labelForCity = self.labelForCity;
    
    [self.middleView addSubview:mapView];
    [self.middleView bringSubviewToFront:mapView];
    
}

- (GMSMapView*) gettMapView:(GMSCameraPosition*)cam{
     GMSMapView* _mapView = [GMSMapView mapWithFrame:_middleView.bounds camera:cam];
    _mapView.settings.myLocationButton = NO;
    _mapView.settings.indoorPicker = NO;
    _mapView.delegate = MoveLogger;
    _mapView.myLocationEnabled = YES;
    _mapView.autoresizesSubviews = YES;
    
    [_mapView setAutoresizingMask:UIViewAutoresizingFlexibleWidth |
     UIViewAutoresizingFlexibleHeight];
    return _mapView;
    
}

- (IBAction)zoomchange:(id)sender{
    if(sender == self.plus){
        [mapView animateToZoom:mapView.camera.zoom+1];
    }
    else{
        [mapView animateToZoom:mapView.camera.zoom-1];
    }
}

- (IBAction)getCurrentPlace:(UIButton *)sender {
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(MoveLogger.lastLoc.coordinate.latitude, MoveLogger.lastLoc.coordinate.longitude);
    CLLocationCoordinate2D northEast = CLLocationCoordinate2DMake(center.latitude + 0.001, center.longitude + 0.001);
    CLLocationCoordinate2D southWest = CLLocationCoordinate2DMake(center.latitude - 0.001, center.longitude - 0.001);
    
    GMSCoordinateBounds *viewport = [[GMSCoordinateBounds alloc] initWithCoordinate:northEast
                                                                         coordinate:southWest];
    GMSPlacePickerConfig *config = [[GMSPlacePickerConfig alloc] initWithViewport:viewport];
    GMSPlacePicker* _placePicker = [[GMSPlacePicker alloc] initWithConfig:config];
    
    
    [_placePicker pickPlaceWithCallback:^(GMSPlace *place, NSError *error) {
        if (error != nil) {
            NSLog(@"Pick Place error %@", [error localizedDescription]);
            return;
        }
        
        if (place != nil) {
            self.addPlaceCont = [self.storyboard instantiateViewControllerWithIdentifier:@"AddPlace"];
            UINavigationController* cont =  (UINavigationController *)self.view.window.rootViewController;
            
            Place* newPlace = [[Place alloc]initWithGmsPlace:place];
            
            [self.addPlaceCont setPlace:newPlace];
            [cont pushViewController:self.addPlaceCont animated:YES];
            //[_inserter insertWithType:place];
           
        }
    }];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue destinationViewController]isKindOfClass:[SocialViewController class]]){
        SocialViewController* cont = [segue destinationViewController];
        cont.URL = self.URLSample.text;
        double longi = MoveLogger.lastLoc.coordinate.longitude;
        double latitude = MoveLogger.lastLoc.coordinate.latitude;
        cont.service = [[TweetService alloc]initWithLocation:TWEET_AMOUNT latitude:latitude longitude:longi radius:RADIUS_FOR_TWEETS];
    }
    
}




@end


