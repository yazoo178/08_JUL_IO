//
//  PlaceDbModel.m
//  Demo
//
//  Created by acp16w on 13/12/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import "Place.h"

@implementation Place

-(id)initWithId:(NSString *)iD{
    self = [super init];
    
    if(self){
        self.placeId = iD;
    }
    
    return self;
}

-(id)initWithGmsPlace:(GMSPlace *)place{
    self = [super init];
    
    if(self){
        self.placeId = place.placeID;
        self.placeName = place.name;
        self.placePhone = place.phoneNumber;
        self.placeWebsite = place.website.absoluteString;
        
        for(GMSAddressComponent* addComp in place.addressComponents){
            self.placeAddress = [self.placeAddress stringByAppendingString:addComp.name];
            self.placeAddress = [self.placeAddress stringByAppendingString:@"\n"];
        }
        
        self.longitude = place.coordinate.longitude;
        self.latitude = place.coordinate.latitude;
        
    }
    return self;
        
}

@end
