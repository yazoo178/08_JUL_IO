//
//  Highscore.h
//  miCity
//
//  Created by Will on 01/01/2017.
//  Copyright © 2017 Will. All rights reserved.
//

#import "BaseModel.h"

@interface Highscore : BaseModel

@property (strong) NSString* name;
@property (strong) NSString* score;
@property (strong) NSString* emotion;
@property (strong) NSString* Id;
@property (strong) NSString* wave;
@end
