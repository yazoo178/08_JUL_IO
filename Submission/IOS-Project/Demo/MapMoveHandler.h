//
//  MapMoveHandler.h
//  Demo
//
//  Created by Will on 01/10/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

#import <GoogleMaps/GoogleMaps.h>
#import <GooglePlacePicker/GooglePlacePicker.h>
#import "BaseModel.h"

@interface MapMoveHandler : BaseModel<GMSMapViewDelegate, CLLocationManagerDelegate>

@property (weak) NSString *creator;
@property (weak) GMSMapView *middleView;
@property (weak) UILabel *labelForCity;
@property (strong) CLLocation* lastLoc;

@property (nonatomic, copy) void (^locationChangedFirstTime)();
@property (nonatomic, copy) void (^locationChanged)();

-(void)updateLocationWithCoord:(CLLocationCoordinate2D)loc;
-(id)init;
-(void)updatePickerBasedOnLastLocation;


@end

