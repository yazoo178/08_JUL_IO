//
//  Popups.h
//  Kappenball
//
//  Created by Will on 22/10/2016.
//  Copyright © 2016 acp16w. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DbAccess.h"
#import <UIKit/UIKit.h>
#import "GameData.h"
#import "HighScoresInserter.h"

@interface Popups : NSObject

///Used for creating a popup when wishing to submit a score
+(UIAlertController*)createPopupForScoreSubmis:(GameData*)data;
@end
