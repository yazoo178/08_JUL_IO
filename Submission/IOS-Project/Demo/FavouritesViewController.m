//
//  FavouritesTableViewController.m
//  Demo
//
//  Created by Will on 18/11/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import "FavouritesViewController.h"
#import "AddPlaceViewController.h"

@interface FavouritesViewController ()

@end

@implementation FavouritesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.faveViews.delegate = self;
    self.faveViews.dataSource = self;
    [self syleizeTableView];
    [self populateData];
}

-(void) populateData{
    //Get the fave places from database
    NSMutableArray* data = [self.inserter pullWithCustomQuery:@"SELECT * FROM FAVE_PLACES"];
    self.favePlaces = data;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.favePlaces.count;
}

-(void)createInserterForThisView{
    self.inserter = [[FavePlaceInserter alloc]init];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //Navigate to our editor/add place view
    Place* p = [self.favePlaces objectAtIndex:indexPath.row];
    
    AddPlaceViewController* editor = [self.storyboard instantiateViewControllerWithIdentifier:@"AddPlace"];
    UINavigationController* cont =  (UINavigationController *)self.view.window.rootViewController;
    
    [editor setPlace:p];
    [cont pushViewController:editor animated:YES];
    //[_inserter insertWithType:place];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //Create a new row for the cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    Place* place = [self.favePlaces objectAtIndex:indexPath.row];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(tableView.frame.origin.x, 10, tableView.frame.size.width, 25)];
    label.text = place.placeName;
    label.font = [UIFont boldSystemFontOfSize:15];
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    [cell addSubview:label];
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 25;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    //Creates new view using the width of the table view
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(self.faveViews.frame.origin.x, self.faveViews.frame.origin.y, tableView.frame.size.width, 0)];
    
    view.backgroundColor = [UIColor blackColor];
    
    //Set the header label
    UILabel *header = [[UILabel alloc] initWithFrame:CGRectMake(tableView.frame.origin.x, 2.5, 50, 20)];
    
    header.font = [UIFont boldSystemFontOfSize:12];
    header.textColor = [UIColor whiteColor];
    header.text = @"Name";
    
    [view addSubview:header];

    return view;
    
}

-(void)syleizeTableView{
    self.faveViews.layer.borderColor = [UIColor blackColor].CGColor;
    self.faveViews.layer.borderWidth = 5;
    self.faveViews.layer.cornerRadius = 25;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //Get the row the user swiped
        Place* toDelete = self.favePlaces[indexPath.row];
        
        //Remove from the highscores collection first
        [self.favePlaces removeObjectAtIndex:indexPath.row];
        
        //Remove row from grid
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];

        ImagePathInserter* inserter = [[ImagePathInserter alloc]init];
        [inserter deleteForId:toDelete.placeId];
        [self.inserter deleteForId:toDelete.placeId];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}



// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
