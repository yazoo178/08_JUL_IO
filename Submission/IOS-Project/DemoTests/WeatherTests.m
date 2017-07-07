//
//  WeatherTests.m
//  miCity
//
//  Created by Projects on 18/01/2017.
//  Copyright © 2017 Will. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WeatherExtraction.h"

@interface WeatherTests : XCTestCase

@end

@implementation WeatherTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testAsynchronousURLConnection {
    XCTestExpectation *expectation =
    [self expectationWithDescription:@"Weather request got data"];
    
    WeatherExtraction* ex = [[WeatherExtraction alloc]initWithLatitude:53.381129 longitude:-1.470085];
    
    ex.weatherChanged = ^(NSDictionary* data, NSData* tempCity){
        XCTAssertTrue(data!= nil && tempCity != nil);
        if(data != nil && tempCity != nil){
            [expectation fulfill];
        }
    };
    
    [ex manualWeatherUpdate:53.381129 longitude:1.470085];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

- (void)testWeatherDescriptionAsynchronousURLConnection {
    XCTestExpectation *expectation =
    [self expectationWithDescription:@"Weather request got descrption"];
    
    WeatherExtraction* ex = [[WeatherExtraction alloc]initWithLatitude:53.381129 longitude:-1.470085];
    
    ex.weatherChanged = ^(NSDictionary* data, NSData* tempCity){
        NSString* desc = [data valueForKey:@"description"];
        XCTAssertTrue(desc != nil);
        if(data != nil && tempCity != nil){
            [expectation fulfill];
        }
    };
    
    [ex manualWeatherUpdate:53.381129 longitude:1.470085];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

- (void)testTempatureAsynchronousURLConnection{
    XCTestExpectation *expectation =
    [self expectationWithDescription:@"Weather request got temperature"];
    
    WeatherExtraction* ex = [[WeatherExtraction alloc]initWithLatitude:53.381129 longitude:-1.470085];
    
    ex.weatherChanged = ^(NSDictionary* data, NSData* tempCity){
        XCTAssertTrue(tempCity != nil);
        if(data != nil && tempCity != nil){
            [expectation fulfill];
        }
    };
    
    [ex manualWeatherUpdate:53.381129 longitude:1.470085];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

- (void)testIconAsynchronousURLConnection{
    XCTestExpectation *expectation =
    [self expectationWithDescription:@"Weather request got weather icon"];
    
    WeatherExtraction* ex = [[WeatherExtraction alloc]initWithLatitude:53.381129 longitude:-1.470085];
    
    ex.weatherChanged = ^(NSDictionary* data, NSData* tempCity){
        NSString* icon = [data valueForKey:@"icon"];
        XCTAssertTrue(icon != nil);
        if(data != nil && tempCity != nil){
            [expectation fulfill];
        }
    };
    
    [ex manualWeatherUpdate:53.381129 longitude:1.470085];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}





- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
