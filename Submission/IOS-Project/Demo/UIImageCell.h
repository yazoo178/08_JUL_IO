//
//  UIImageCell.h
//  Demo
//
//  Created by acp16w on 14/12/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageCell : UICollectionViewCell<UIGestureRecognizerDelegate>
@property IBOutlet UIImageView* imageView;

-(void)fullScreen:(id)arg;
@end
