//
//  WordColorSettings.h
//  Demo
//
//  Created by Will on 11/12/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define Rgb2UIColor(r, g, b)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]

@interface UIColor (WordColorSettings)

+(UIColor*)positiveGreenColor;
+(UIColor*)negativeRedColor;
+(NSArray*)cloudColorDefault;
+(NSString*)cloudFontDefault;
+(UIColor*)lightPositiveColor;
+(UIColor*)lightNegativeColor;
+(UIColor*)lightNeutralBlueColor;
@end
