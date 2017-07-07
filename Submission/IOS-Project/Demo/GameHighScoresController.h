//
//  GameHighScoresController.h
//  miCity
//
//  Created by Will on 01/01/2017.
//  Copyright © 2017 Will. All rights reserved.
//

#import "MiCityViewController.h"
#import "HighScoresInserter.h"
#import "Highscore.h"

@interface GameHighScoresController : MiCityViewController<UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate,UINavigationControllerDelegate>


@property (weak) IBOutlet UITableView* highScores;
@property (nonatomic,strong) NSMutableArray *scores;

@end
