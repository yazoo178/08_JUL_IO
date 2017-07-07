//
//  AddPlaceViewController.h
//  Demo
//
//  Created by acp16w on 13/12/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import "MiCityViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import <GooglePlacePicker/GooglePlacePicker.h>
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

#import "IDbQuery.h"
#import "FavePlaceInserter.h"
#import "ImagePathInserter.h"

@interface AddPlaceViewController : MiCityViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate>


@property (weak) IBOutlet UITextField* name;
@property (weak) IBOutlet UITextField* website;
@property (weak) IBOutlet UITextView* address;
@property (weak) IBOutlet UITextView* comments;
@property (weak) IBOutlet UITextField* phone;
@property (weak) IBOutlet UIView* inputView;
@property (weak) IBOutlet UICollectionView* imageView;
@property (strong) NSMutableArray* images;
@property (strong) NSMutableArray* imageURLS;
@property (strong) NSObject<IDbQuery>* imageInserter;
@property (strong)PHImageRequestOptions* options;

@property (strong) NSString* placeId;
@property (strong) Place* currentPlace;

-(void)setPlace:(Place*)place;

-(IBAction)takeSnapAddToGal:(UIButton*)sender;
-(IBAction)browseForImage:(UIButton*)sender;
- (IBAction)save:(UIButton *)sender;
-(IBAction)addMarker:(UIButton *)sender;



@end
