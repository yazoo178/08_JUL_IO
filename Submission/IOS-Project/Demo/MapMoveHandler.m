//
//  MapMoveHandler.m
//  Demo
//
//  Created by Will on 01/10/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import "MapMoveHandler.h"

@implementation MapMoveHandler

GMSGeocoder* geocoder;
GMSMarker* marker;
GMSPlacePicker* picker;

- (id) init{
    self = [super init];
    if(self){
        geocoder =  [[GMSGeocoder alloc] init];
        marker = [[GMSMarker alloc]init];
    }
    
    return self;
}

-(void)updatePickerBasedOnLastLocation{
    return;
}

- (void)mapView:(GMSMapView *)mapView didLongPressAtCoordinate:(CLLocationCoordinate2D)coordinate{
    [self updateLocationWithCoord:coordinate];
    
}

-(void)updateLocationWithCoord:(CLLocationCoordinate2D)loc{
    
    [geocoder reverseGeocodeCoordinate:loc completionHandler:^(GMSReverseGeocodeResponse* response, NSError* error) {
        GMSAddress* current = [self mostSuitableAddress:[response results]];

        if(current != Nil)
        {
            NSString* resultString = [current.lines componentsJoinedByString:@"\n"];
            [self labelForCity].text = resultString;            
        }
        
    }];
}



- (GMSAddress*)mostSuitableAddress:(NSArray<GMSAddress*>*)vals{
    GMSAddress* current = Nil;
    for(GMSAddress* item in vals){
        if(current == Nil){
            current = item;
            continue;
        }
        else{
            if(item.lines.count > current.lines.count){
                current = item;
            }
        }
    }
    
    return current;
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *currentLocation = [locations lastObject];
    self.lastLoc = currentLocation;
    marker.position = currentLocation.coordinate;
    marker.title = @"Current Location";
    marker.map = _middleView;
    [_middleView animateToLocation:currentLocation.coordinate];
    [self updateLocationWithCoord:currentLocation.coordinate];
    
    if(self.locationChangedFirstTime != nil){
        self.locationChangedFirstTime();
        self.locationChangedFirstTime = nil;
    }
    else
    {
        if(self.locationChanged != nil){
            self.locationChanged();
        }
    }
    
    
}

-(BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker{
    marker.map = nil;
    return YES;
}






@end
