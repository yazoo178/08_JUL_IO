//
//  FavouritesTableViewController.h
//  Demo
//
//  Created by Will on 18/11/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MiCityViewController.h"
#import "FavePlaceInserter.h"
#import "Place.h"
#import "ImagePathInserter.h"

@interface FavouritesViewController : MiCityViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong) IBOutlet UITableView* faveViews;
@property (nonatomic,strong) NSMutableArray *favePlaces;

@end
