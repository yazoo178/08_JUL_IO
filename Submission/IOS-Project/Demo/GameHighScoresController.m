//
//  GameHighScoresController.m
//  miCity
//
//  Created by Will on 01/01/2017.
//  Copyright © 2017 Will. All rights reserved.
//

#import "GameHighScoresController.h"

@interface GameHighScoresController ()

@end

@implementation GameHighScoresController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.highScores.delegate = self;
    self.highScores.dataSource = self;
    [self syleizeTableView];
    
    NSMutableArray* tmp = [[NSMutableArray alloc]init];
    
    self.scores = [[NSMutableArray alloc]init];
    
    for(Highscore* score in [self.inserter pullWithId:nil]){
        [tmp addObject:score];
    }
    
    [tmp sortUsingComparator:^NSComparisonResult(id left, id right) {
        
        Highscore* one = left;
        Highscore* two = right;
        
        if(one.score == two.score){
            if(one.wave <= two.wave){
                return (NSComparisonResult)NSOrderedDescending;
            }
            else{
                return (NSComparisonResult)NSOrderedAscending;
            }
            
        }
        
        else if(one.score < two.score){
            return (NSComparisonResult)NSOrderedDescending;
        }
        else{
            return (NSComparisonResult)NSOrderedAscending;
        }
        
    }];
    
    for(Highscore* score in tmp){
        [self.scores addObject:score];
    }

}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    //Creates new view using the width of the table view
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(self.highScores.frame.origin.x, self.highScores.frame.origin.y, tableView.frame.size.width, 0)];
    
    view.backgroundColor = [UIColor blackColor];
    int splitter = tableView.frame.size.width / 4;
    
    UILabel *playerLabel = [[UILabel alloc] initWithFrame:CGRectMake(tableView.frame.origin.x, 2.5, 125, 20)];
    
    playerLabel.font = [UIFont boldSystemFontOfSize:12];
    playerLabel.textColor = [UIColor whiteColor];
    playerLabel.text = @"Player";
    
    UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(tableView.frame.origin.x + splitter, 2.5, 125, 20)];
    
    scoreLabel.font = [UIFont boldSystemFontOfSize:12];
    scoreLabel.textColor = [UIColor whiteColor];
    scoreLabel.text = @"Score";
    
    UILabel *waveLabel = [[UILabel alloc] initWithFrame:CGRectMake(tableView.frame.origin.x + splitter *2, 2.5, 125, 20)];
    
    waveLabel.font = [UIFont boldSystemFontOfSize:12];
    waveLabel.textColor = [UIColor whiteColor];
    waveLabel.text = @"Wave";
    
    UILabel *emotionLabel = [[UILabel alloc] initWithFrame:CGRectMake(tableView.frame.origin.x + splitter *3, 2.5, 125, 20)];
    
    emotionLabel.font = [UIFont boldSystemFontOfSize:12];
    emotionLabel.textColor = [UIColor whiteColor];
    emotionLabel.text = @"Emotion of Game";
    
    [view addSubview:playerLabel];
    [view addSubview:scoreLabel];
    [view addSubview:waveLabel];
    [view addSubview:emotionLabel];
    return view;
    
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //Get the row the user swiped
        Highscore* toDelete = self.scores[indexPath.row];
        
        //Remove from the highscores collection first
        [self.scores removeObjectAtIndex:indexPath.row];
        
        //Remove row from grid
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [self.inserter deleteForId:toDelete.Id];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    int splitter = tableView.frame.size.width / 4;
    
    for(UIView* view in cell.subviews){
        [view removeFromSuperview];
    }
    
    Highscore* score = [self.scores objectAtIndex:indexPath.row];
    
    //create a new view to place the labels
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    
    UILabel *playerLabel = [[UILabel alloc] initWithFrame:CGRectMake(tableView.frame.origin.x, 10, splitter, 25)];
    
    playerLabel.font = [UIFont boldSystemFontOfSize:20];
    playerLabel.textColor = [UIColor blackColor];
    playerLabel.text = score.name;
    
    UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(tableView.frame.origin.x + splitter, 10, splitter, 25)];
    
    scoreLabel.font = [UIFont boldSystemFontOfSize:20];
    scoreLabel.textColor = [UIColor blackColor];
    scoreLabel.text = score.score;
    
    UILabel *waveLabel = [[UILabel alloc] initWithFrame:CGRectMake(tableView.frame.origin.x + splitter * 2, 10, splitter, 25)];
    waveLabel.font = [UIFont boldSystemFontOfSize:20];
    waveLabel.textColor = [UIColor blackColor];
    waveLabel.text = score.wave;
    
    
    UILabel *emotionLabel = [[UILabel alloc] initWithFrame:CGRectMake(tableView.frame.origin.x + splitter * 3, 10, splitter, 25)];
    
    
    UIImage* img = [UIImage imageNamed:score.emotion];
    UIImageView* imgViw = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    imgViw.image = img;
    [imgViw setNeedsDisplay];
    imgViw.contentMode = UIViewContentModeScaleAspectFit;
    imgViw.clipsToBounds = YES;
    [emotionLabel addSubview:imgViw];
    
    [view addSubview:playerLabel];
    [view addSubview:scoreLabel];
    [view addSubview:waveLabel];
    [view addSubview:emotionLabel];
    
    [cell addSubview:view];
    
    return cell;
}

-(void)createInserterForThisView{
    self.inserter = [[HighScoresInserter alloc]init];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 25;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.scores.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)syleizeTableView{
    self.highScores.layer.borderColor = [UIColor blackColor].CGColor;
    self.highScores.layer.borderWidth = 5;
    self.highScores.layer.cornerRadius = 25;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
