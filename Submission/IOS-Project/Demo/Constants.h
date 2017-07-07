//
//  Constants.h
//  Demo
//
//  Created by Will on 09/10/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Constants : NSObject

extern NSString *const USER_REVIEW_TABLE_CREATOR;
extern NSString *const USER_FAVE_TABLE_CREATOR;

extern NSString *const TWITTER_TOKEN_MATCH_REGEX;
extern NSString *const PLACE_INSERT_STR;
extern NSString* const FAVE_PLACES_TABLE;
extern NSString* const HIGHSCORES_TABLE;
extern NSString* const PLACE_UPDATE_STR;
extern NSString* const IMAGE_LINK_TABLE;
extern NSString* const IMAGE_LINKS_FOR_PLACE_ID;
extern NSString* const IMAGE_LINKS_INSERT_STR;
extern NSString* const HIGHSCORE_INSERT_STR;


extern double const PRIOR_POSITIVE_COUNT_TWITTER;
extern double const PRIOR_NEGATIVE_COUNT_TWITTER;

extern NSString* const BACKGROUND_IMG;
extern NSString* const TWITTER_IMG_1;
extern NSString* const TWITTER_IMG_2;
extern NSString* const TWITTER_IMG_3;
extern NSString* const TWITTER_IMG_4;


extern int const RADIUS_FOR_TWEETS;
extern int const TWEET_AMOUNT;

extern NSString* const USER_HEADER;
extern NSString* const TWEET_HEADER;

//Db columns
extern NSString* const PLACE_ID;
extern NSString* const ADDRESS;
extern NSString* const PATH;
extern NSString* const PATHS;
extern NSString* const WEBSITE;
extern NSString* const NAME;
extern NSString* const PHONE;
extern NSString* const COMMENTS;


extern double const POLARITY_THRESH_HOLD;

@end
