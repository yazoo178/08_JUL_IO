//
//  WordColorSettings.m
//  Demo
//
//  Created by Will on 11/12/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import "UIColor+WordColorSettings.h"

@implementation UIColor(WordColorSettings)

+(UIColor*)positiveGreenColor{
    return [UIColor colorWithHue:126.0/360.0 saturation:0.8 brightness:0.6 alpha:1.0];
}

+(UIColor*)negativeRedColor{
    return [UIColor colorWithHue:  4.0/360.0 saturation:0.9 brightness:0.8 alpha:1.0];
}

+(NSArray*)cloudColorDefault{
    return @[
             [UIColor colorWithHue: 36.0/360.0 saturation:1.0 brightness:0.3 alpha:1.0],
             [UIColor colorWithHue: 36.0/360.0 saturation:0.9 brightness:0.8 alpha:1.0],
             [UIColor colorWithHue: 36.0/360.0 saturation:0.8 brightness:1.0 alpha:1.0],
             [UIColor colorWithHue:  4.0/360.0 saturation:0.9 brightness:0.8 alpha:1.0],
             [UIColor colorWithHue:332.0/360.0 saturation:0.9 brightness:0.8 alpha:1.0],
             ];
}

+(NSString*)cloudFontDefault{
    return @"AvenirNext-Regular";
}

+(UIColor*)lightPositiveColor{
    return Rgb2UIColor(230, 245, 226);
}

+(UIColor*)lightNegativeColor{
     return Rgb2UIColor(246, 231, 233);
}

+(UIColor*)lightNeutralBlueColor{
    return Rgb2UIColor(231, 242, 246);
}

@end
