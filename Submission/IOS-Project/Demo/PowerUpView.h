//
//  PowerUpView.h
//  miCity
//
//  Created by Will on 18/12/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import "GameViewBase.h"
#import "PowerUp.h"

@interface PowerUpView : GameViewBase

-(id)initWithImage:(UIImage *)image withPowerUp:(PowerUp*)powerUp;

@property (weak) PowerUp* powerUp;


@end
