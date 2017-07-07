//
//  TweetsScreenViewController.h
//  Demo
//
//  Created by acp16w on 06/10/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import  "UIColor+WordColorSettings.h"
#import "MiCityViewController.h"
#import <Social/Social.h>
#import <Accounts/Accounts.h>


@interface TweetsScreenViewController : MiCityViewController<UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak) IBOutlet UITableView* tweetsView;
@property (nonatomic,strong) NSArray *tweets;
@property (strong) NSString* sourceLabelText;
@property (strong) UIColor* headerColor;
@property (strong) NSString* phrase;
@property (weak) IBOutlet UIButton* sendTweetButton;
@property (weak) IBOutlet UIImageView* tweetImage;
@property (weak) IBOutlet UIImageView* tweetBird;
@property (weak) IBOutlet UILabel* titleLable;
@property (weak) IBOutlet UITextView* tweetBox;
@property (weak) IBOutlet UILabel* infoLabel;

-(IBAction)addPhoto:(id)sender;
-(IBAction)sendTweet:(id)sender;

@end
