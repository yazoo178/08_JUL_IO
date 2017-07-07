//
//  PlaceDbModel.h
//  Demo
//
//  Created by acp16w on 13/12/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GooglePlacePicker/GooglePlacePicker.h>

@interface Place : NSObject

@property (strong) NSString* placeName;
@property (strong) NSString* placeId;
@property (strong) NSString* placeAddress;
@property (strong) NSString* placePhone;
@property (strong) NSString* placeWebsite;
@property (strong) NSString* placeComments;

@property (assign) double longitude;
@property (assign) double latitude;

-(id)initWithGmsPlace:(GMSPlace*)place;
-(id)initWithId:(NSString*)iD;

@end
