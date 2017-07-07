//
//  ScorePointView.h
//  miCity
//
//  Created by Will on 22/12/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import "GameViewBase.h"
#import "ScorePoint.h"

@interface ScorePointView : GameViewBase

-(id)initWithImage:(UIImage *)image withScore:(ScorePoint*)obstacle;

@property (weak) ScorePoint* obs;

@end
