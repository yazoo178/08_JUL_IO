//
//  GameConstants.m
//  miCity
//
//  Created by Will on 17/12/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import "GameConstants.h"

@implementation GameConstants

float const CAR_WIDTH = 80.0f;
float const CAR_HEIGHT = 200.0f;

float const POWER_UP_WIDTH = 50.0f;
float const POWER_UP_HEIGHT = 50.0f;

float const STAR_WIDTH = 30.0f;
float const STAR_HEIGHT = 30.0f;

int const MAX_SPEED = 800; // /100
int const MIN_SPEED = 100; // /100

int const DEFAULT_CAR_RATE = 200; //The lower the higher
int const DEFAULT_POWER_UP_RATE = 1000; //the lower the higher
int const DEFAULT_OBSTACLE_RATE = 1000; //the lower the higher
int const DEFAULT_RATE_OF_STAR = 25;

float const SHRINK_TIME = 0.6;
int const  SHRINK_PERCENTAGE = 40;
int const SHRINK_POWER_UP_DURATION = 10;

NSString * const POWER_UP_FILE_NAMES[] = { @"repair.png", @"shrink.png" };
NSString * const CAR_FILE_NAMES[] = {@"green_car.png", @"red_car.png", @"light_blue_car.png", @"purple_car.png", @"black_stripe_car.png"};
NSString * const OBSTACLE_FILE_NAMES[] = {@"oil.png"};

int const CAR_COUNTS = 5;

int const DISTORT_CONTROLS_DURATION = 5;

double const POSITVE_INTENSIFIER = 1.50;
double const NEGATIVE_INTENSIFIER = 0.75;

@end
