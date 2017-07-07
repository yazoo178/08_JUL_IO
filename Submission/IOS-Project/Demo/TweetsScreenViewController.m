//
//  TweetsScreenViewController.m
//  Demo
//
//  Created by acp16w on 06/10/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import "TweetsScreenViewController.h"
#import "Tweet.h"
#import "GeneralMethods.h"
#import <QuartzCore/QuartzCore.h>
#import "Constants.h"

@interface TweetsScreenViewController ()

@end

@implementation TweetsScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tweetsView.delegate = self;
    self.tweetsView.dataSource = self;
    [self.titleLable setText:self.sourceLabelText];
    [self.titleLable setTextColor:self.headerColor];
    [self.infoLabel setText:self.phrase];
    [GeneralMethods scaleAppear:self.titleLable toFloat:3 durationFloat:0.5 onComplete:nil revertTo:CGAffineTransformIdentity];
    [self animateTweetBird];
    [self syleizeTableView];
    [self syleizeTweetBox];
    [self hookImageTap];

    
}

-(void)hookImageTap{
    //When taking picture we might want to zoom in on it
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap)];
    singleTap.numberOfTapsRequired = 1;
    [self.tweetImage setUserInteractionEnabled:YES];
    [self.tweetImage addGestureRecognizer:singleTap];
    
    //Allow image to be removed by holding it
    UILongPressGestureRecognizer* rec = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress)];
    rec.minimumPressDuration = 2;
    [self.tweetImage addGestureRecognizer:rec];
    
}

-(void)removeImageTap{
    //Remove the image
    [zoomer removeFromSuperview];
    zoomer = nil;
    
    [GeneralMethods processSubviewsRecur:self.view onFound:^(UIView* foundView){
        foundView.alpha = 1.0f;
        
    }];
}

-(void)longPress{
    //Remove the image
    if(self.tweetImage.image != nil){
        self.tweetImage.image = nil;
    }
}

UIImageView* zoomer;
-(void)imageTap{
    
    if(self.tweetImage.image != nil){
        
        //Set the frame
        zoomer = [[UIImageView alloc]initWithImage:self.tweetImage.image];
        zoomer.frame = self.tweetImage.bounds;
        zoomer.contentMode = UIViewContentModeScaleAspectFit;
        
        //Add input gesture to remove image when tapped
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeImageTap)];
        singleTap.numberOfTapsRequired = 1;
        [zoomer setUserInteractionEnabled:YES];
        [zoomer addGestureRecognizer:singleTap];
        
        
        [self.view addSubview:zoomer];
        CGRect zoomFrameTo = [UIScreen mainScreen].bounds;
    
        //Animate the image to zoom in
        [UIView animateWithDuration:0.5 animations:
         ^{
             zoomer.frame = zoomFrameTo;
         
             [GeneralMethods processSubviewsRecur:self.view onFound:^(UIView* foundView){
                 if(foundView != zoomer){
                     foundView.alpha = 0.5;
                 }
             }];
         
         } completion:^(BOOL finished){
             
         }];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    //Select the first row in the grid
    if([self.tweets count] > 0){
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
        [self.tweetsView selectRowAtIndexPath:indexPath animated:YES  scrollPosition:UITableViewScrollPositionBottom];
        [self tableView:self.tweetsView didSelectRowAtIndexPath:indexPath];
    }
    
}



-(void)syleizeTableView{
    //Set the table view to use rounded corners and black border
    self.tweetsView.layer.borderColor = [UIColor blackColor].CGColor;
    self.tweetsView.layer.borderWidth = 5;
    self.tweetsView.layer.cornerRadius = 25;
    
}

-(void)syleizeTweetBox{
    //Set the tweet box to have rounded corners
    self.tweetBox.layer.borderColor = [UIColor whiteColor].CGColor;
    self.tweetBox.layer.borderWidth = 2;
    self.tweetBox.layer.cornerRadius = 25;
    
}

-(void)animateTweetBird{
    //Start the bird in the corner animiating
    self.tweetBird.animationImages = @[
                                       [UIImage imageNamed:TWITTER_IMG_2],
                                       [UIImage imageNamed:TWITTER_IMG_3],
                                       [UIImage imageNamed:TWITTER_IMG_4]];
    
    self.tweetBird.animationDuration = 0.5;
    [self.tweetBird startAnimating];
    [GeneralMethods upDownAnimate:self.tweetBird xTo:6 dur:0.5 dir:YES];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    //Creates new view using the width of the table view
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(self.tweetsView.frame.origin.x, self.tweetsView.frame.origin.y, tableView.frame.size.width, 0)];
    
    view.backgroundColor = [UIColor blackColor];
    
    //Create a header for the user label
    UILabel *userLabel = [[UILabel alloc] initWithFrame:CGRectMake(tableView.frame.origin.x, 2.5, 50, 20)];
    
    userLabel.font = [UIFont boldSystemFontOfSize:12];
    userLabel.textColor = [UIColor whiteColor];
    userLabel.text = USER_HEADER;
    
    //Create a header for the tweet label
    UILabel *tweetLabel = [[UILabel alloc] initWithFrame:CGRectMake(tableView.frame.origin.x + 125, 2.5, 50, 20)];
    
    tweetLabel.font = [UIFont boldSystemFontOfSize:12];
    tweetLabel.textColor = [UIColor whiteColor];
    tweetLabel.text = TWEET_HEADER;
    
    [view addSubview:userLabel];
    [view addSubview:tweetLabel];
    return view;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //If we select a row then update the text view to show this
    Tweet* tweet = [self.tweets objectAtIndex:indexPath.row];
    self.tweetBox.text = [NSString stringWithFormat:@"@%@ ", tweet.userScreenName];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 25;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.tweets.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    //Remove existing data, as it's causing the text to override
    for(UIView* view in cell.subviews){
        [view removeFromSuperview];
    }
    
    Tweet* tweet = [self.tweets objectAtIndex:indexPath.row];
    
    //create a new view to place the labels
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    
    //Create the user label
    UILabel *userLabel = [[UILabel alloc] initWithFrame:CGRectMake(tableView.frame.origin.x, 0, tableView.frame.size.width / 4, cell.frame.size.height)];
    
    userLabel.font = [UIFont boldSystemFontOfSize:12];
    userLabel.textColor = [UIColor blackColor];
    userLabel.text = tweet.userScreenName;
    
    //Create the tweet label
    UILabel *tweetLabel = [[UILabel alloc] initWithFrame:CGRectMake(tableView.frame.origin.x + 125, 2.5, view.bounds.size.width - userLabel.bounds.size.width, 25)];
    
    
    UIColor* color = [tweet getWordSentiment:self.sourceLabelText] == 1 ? [UIColor positiveGreenColor] : [UIColor negativeRedColor];
    
    //Use a regex to set the colour of matching words in the tweet string
    NSRange   searchedRange = NSMakeRange(0, [tweet.tweetString length]);
    NSRegularExpression* exp = [NSRegularExpression regularExpressionWithPattern:[NSString stringWithFormat:@"%@|%@|%@",self.sourceLabelText, [self.sourceLabelText lowercaseString], [self.sourceLabelText uppercaseString]] options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray* matches = [exp matchesInString:tweet.tweetString options:0 range: searchedRange];
    
    tweetLabel.numberOfLines = 0;
    tweetLabel.lineBreakMode = NSLineBreakByWordWrapping;
    tweetLabel.font = [UIFont boldSystemFontOfSize:12];
    tweetLabel.textColor = [UIColor blackColor];
    
    NSMutableAttributedString* tweetS = [[NSMutableAttributedString alloc]initWithString:tweet.tweetString];
    for (NSTextCheckingResult* match in matches){
        [tweetS addAttribute:NSForegroundColorAttributeName value:color range:match.range];
        
    }

    //
    tweetLabel.attributedText = tweetS;
    [tweetLabel sizeToFit];
    
    //Attach the views
    [view addSubview:userLabel];
    [view addSubview:tweetLabel];
    [cell addSubview:view];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Calculate the default height for a row
    //Use the text length
    UIFont * font = [UIFont boldSystemFontOfSize:12.0f];
    Tweet* tw = [self.tweets objectAtIndex:indexPath.row];
    NSString * text = tw.tweetString;
    
    CGFloat height = [text boundingRectWithSize:CGSizeMake(self.tweetsView.frame.size.width, 200) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName: font} context:nil].size.height;
    
    return height + 5;
}





// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

- (void)tableView: (UITableView*)tableView willDisplayCell: (UITableViewCell*)cell forRowAtIndexPath: (NSIndexPath*)indexPath
{
    if(indexPath.row % 2 == 0){
        cell.backgroundColor = [UIColor whiteColor];
    }
    else
    {
        cell.backgroundColor = [self.phrase containsString:@"happy"] ?  [UIColor lightPositiveColor] : ([self.phrase containsString:@"neutral"] ? [UIColor lightNeutralBlueColor] : [UIColor lightNegativeColor]);
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

-(IBAction)sendTweet:(id)sender{
    //Open tweet controller
    SLComposeViewController *controller = [SLComposeViewController
                                           composeViewControllerForServiceType:SLServiceTypeTwitter];
    
    [controller setInitialText:self.tweetBox.text];
    
    if(self.tweetImage.image != nil){
        [controller addImage:self.tweetImage.image];
    }
    
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]){
        controller.completionHandler = ^(SLComposeViewControllerResult result){
            
        };
        
        [self presentViewController:controller animated:YES completion:nil];
    }

}

-(IBAction)addPhoto:(id)sender{
    //Check in the camera is avaliable
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera] == NO) {
        NSLog(@"No camera!");
        return;
    }
    
    //Create image picker controller and assossicate delegate
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.allowsEditing = NO;
    imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

-(void) imagePickerControllerDidCancel: (UIImagePickerController *) picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void) imagePickerController: (UIImagePickerController *) picker didFinishPickingMediaWithInfo: (NSDictionary *) info {
    
    //Taken a photo
    UIImage *picture = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    self.tweetImage.image = picture;
    
    // dismiss the camera dialog and clean up
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
