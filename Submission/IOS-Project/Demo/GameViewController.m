//
//  GameViewController.m
//  Demo
//
//  Created by acp16w on 14/12/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import "GameViewController.h"
#import "GeneralMethods.h"
#import "PowerUpView.h"
#import "PopUpViewController.h"
#include <math.h>
#include "GeneralMethods.h"

@interface GameViewController ()


@end

@implementation GameViewController

CALayer *backGroundLayer;
CABasicAnimation *backGroundLayerAnimiation;
UIView* roadView;
int acc;
UIImage* road;
bool paused = true;
int direction = 0;
NSPredicate* predi;
//Timer for handling when a touch is held down
NSTimer *touchTimer;

NSTimer *mainGameTimer;

NSTimer* countDownTimer;

NSTimer* waveTimer;

UILabel* middleLabel;

//Captures the last location the user held on screen
UIImageView* lastLocation;

- (void)viewDidLoad {
    [super viewDidLoad];

}

-(void)viewDidAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
    
    self.gameData = [[GameData alloc]init];
    [super viewDidAppear:animated];
    [self setDefaultFactory];
    
    self.gameObjects = [[NSMutableArray alloc]init];
    predi = [NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        GameModelBase* element = evaluatedObject;
        return !element.isOutOfBounds;
    }];
    
    self.emotion = [[EmotionWidget alloc]initWithSourceController:self];
    [self.emotionWidget addSubview:self.emotion];
    self.emotion.frame = self.emotion.superview.bounds;
    self.scoreLabel.text = @"0";
    self.waveLabel.text = @"Wave:0";
    [self createRoadScroll];
    [self createCar];
    [self createLabel];
    [self configSentimentWid];
    road = [UIImage imageNamed:@"road.png"];
    
    self.leftDefault = [UIImage imageNamed:@"left"];
    self.rightDefault = [UIImage imageNamed:@"right"];
    
    self.left = [[UIImageView alloc]initWithImage:self.leftDefault];
    self.right = [[UIImageView alloc]initWithImage:self.rightDefault];
    
    self.leftDown = [UIImage imageNamed:@"left_b"];
    self.rightDown = [UIImage imageNamed:@"right_b"];
    
    self.left.frame  = CGRectMake(0, 0, self.arrowView.frame.size.width / 2, self.arrowView.frame.size.height);
    self.right.frame = CGRectMake(self.arrowView.frame.size.width / 2, 0, self.arrowView.frame.size.width / 2, self.arrowView.frame.size.height);
    self.left.alpha = 0.45;
    self.right.alpha = 0.45;
    self.left.contentMode = UIViewContentModeScaleAspectFit;
    self.right.contentMode = UIViewContentModeScaleAspectFit;
    self.left .clipsToBounds = YES;
    self.right.clipsToBounds = YES;
    self.left .userInteractionEnabled = YES;
    self.right.userInteractionEnabled  = YES;
    [self.arrowView addSubview:self.left ];
    [self.arrowView addSubview:self.right];
    [self.view bringSubviewToFront:self.arrowView];
    self.arrowView.center = CGPointMake(roadView.center.x, (roadView.frame.size.height / 7) * 6);
    
    UILongPressGestureRecognizer* leftPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(leftPress:)];
    leftPress.minimumPressDuration = 0.001;
    leftPress.view.userInteractionEnabled = YES;
    leftPress.cancelsTouchesInView = NO;
    
    UILongPressGestureRecognizer* rightPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(rightPress:)];
    rightPress.minimumPressDuration = 0.001;
    rightPress.view.userInteractionEnabled = YES;
    rightPress.cancelsTouchesInView = NO;
    
    [self.left  addGestureRecognizer:leftPress];
    [self.right  addGestureRecognizer:rightPress];
    [self.emotion updateEmotion];
}

-(void)rightPress:(UILongPressGestureRecognizer*)rec{
    [self holdPress:rec withSender:self.right];
}

-(void)leftPress:(UILongPressGestureRecognizer*)rec{
    [self holdPress:rec withSender:self.left];
}



-(void)configSentimentWid{
    __weak GameViewController *weakSelf = self;
    
    self.emotion.configPopup = ^(PopUpViewController* popup){
        popup.line3Text = [NSString stringWithFormat:@"Multiplier: %f", weakSelf.emotionFactor];
    };
    
    self.emotion.emotionChanged = ^(EmotionType type){
        weakSelf.emotionFactor = type == Happy ? POSITVE_INTENSIFIER : (type == Sad ? NEGATIVE_INTENSIFIER : 1);
    };
}


-(void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController{
    
}

-(void)createLabel{
    middleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 400, 250)];
    middleLabel.center = roadView.center;
    middleLabel.numberOfLines = 0;
    middleLabel.font = [UIFont boldSystemFontOfSize:50];
    middleLabel.textColor = [UIColor whiteColor];
    middleLabel.alpha = 1.0f;
    [self.view addSubview:middleLabel];
}


-(void)viewDidDisappear:(BOOL)animated{
    for(GameViewBase* cv in roadView.subviews){
        if([cv isKindOfClass:[GameViewBase class]])
        {
            [cv removeObservers];
        }
    }
    
    [self cleanUp];
}

-(void)cleanUp{
    [self.emotion removeFromSuperview];
    [mainGameTimer invalidate];
    [touchTimer invalidate];
    [waveTimer invalidate];
    lastLocation = nil;
    waveTimer = nil;
    mainGameTimer = nil;
    touchTimer = nil;
    self.gameFactory = nil;
    road = nil;
    backGroundLayerAnimiation = nil;
    backGroundLayer = nil;
    self.car = nil;
    self.carView = nil;
    self.gameObjects = nil;
    paused = true;
    firstTimeStart = true;
    self.gameData = nil;
    acc = 0;
}



-(void)createCar{
    
    self.car = [[Car alloc]initCarWithFileName:@"car.png"];
    self.car.locX = roadView.center.x - 60;
    self.car.locY = roadView.center.y + 150;
    self.carView = [self.gameFactory createCarViewWithModelData:self.car];
    self.carView.destructionImages = @[[UIImage imageNamed:@"car_damage_1.png"],
                                       [UIImage imageNamed:@"car_damage_2.png"],
                                        [UIImage imageNamed:@"car_damage_3.png"],
                                        [UIImage imageNamed:@"car_damage_4.png"],
                                       [UIImage imageNamed:@"car_damage_5.png"]];
    
    
    [roadView addSubview:self.carView];
}

-(void)gameTic:(NSTimer*)timer{
    
    [self addCarRand];
    [self addPowerUpRand];
    [self addObstacleRand];
    [self addPointRand];
    
    self.car.locX +=direction;
    direction = direction < 0 ? direction + 1 : (direction > 0 ? direction - 1 : 0);
    NSArray* cpy = [self.gameObjects filteredArrayUsingPredicate:predi];
    for(GameModelBase* obj in cpy){
        if([obj isKindOfClass:[Car class]]){
            Car* c = (Car*)obj;
            c.locY +=c.speed;
        }
        else if([obj isKindOfClass:[PowerUp class]] || [obj isKindOfClass:[Obstacle class]] || [obj isKindOfClass:[ScorePoint class]]){
             obj.locY +=10;
        }
    }
}

-(void)addCarRand{
    int traffic = round(self.gameData.trafficLevel);
    
    int num = arc4random() % traffic + 2;
    
    if(num == traffic){
        [self createDriverCar];
    }
    
}

-(void)addPowerUpRand{
    int rate = round(self.emotionFactor * DEFAULT_POWER_UP_RATE) - DEFAULT_POWER_UP_RATE;
    int num = arc4random() % (DEFAULT_POWER_UP_RATE - rate) + 1;
    
    if(num == DEFAULT_POWER_UP_RATE - rate){
        [self createPowerUp];
    }
}

-(void)addObstacleRand{
    
    int rate = round(self.gameData.obstacleRate);
    
    int num = arc4random() % rate + 2;
    
    if(num == self.gameData.obstacleRate){
        [self createObstacle];
    }
}

-(void)addPointRand{
    int rate = round(self.emotionFactor * DEFAULT_RATE_OF_STAR) - DEFAULT_RATE_OF_STAR;
    
    int num = arc4random() % (DEFAULT_RATE_OF_STAR - rate) + 1;
    
    if(num == DEFAULT_RATE_OF_STAR - rate){
        [self createPoint];
    }
}

-(void)createPoint{
    ScorePoint* obs = [[ScorePoint alloc]init];

    obs.path = @"score.png";

    obs.locX = arc4random() % (int)(roadView.bounds.size.width - STAR_WIDTH);
    obs.locY = roadView.frame.origin.y - STAR_HEIGHT;
    
    ScorePointView* view = [self.gameFactory createScoreViewWithModelData:obs];
    
    if([self doesIntersectOther:view]) {
        return;
    }
    
    view.onContactWith = ^(GameViewBase* model, UIView* view){
        if(self.carView == view){
            model.needs_removing = true;
            [self addScore:self.gameData.currentWave];
            [model removeObservers];
            [model removeFromSuperview];
        }
    };
    
    [roadView insertSubview:view belowSubview:self.carView];
    [self.gameObjects addObject:obs];
}

-(void)addScore:(int)amount{
    amount = round(amount * self.emotionFactor);
    int val = [self.scoreLabel.text intValue] + amount;
    NSString* newScore = [NSString stringWithFormat:@"%d", val];
    self.scoreLabel.text = newScore;
    self.gameData.score = newScore;
}

-(void)createObstacle{
    Obstacle* obs = [[Obstacle alloc]init];
    int type = arc4random_uniform(ObstaclTypeCount);
    obs.path = OBSTACLE_FILE_NAMES[type];
    
    obs.locX = arc4random() % (int)(roadView.bounds.size.width - POWER_UP_WIDTH);
    obs.locY = roadView.frame.origin.y - POWER_UP_HEIGHT;
    obs.obstacleType = type;
    
    ObstacleView* view = [self.gameFactory createObstacleWithModelData:obs];
    
    if([self doesIntersectOther:view]) {
        return;
    }
    
    view.onContactWith = ^(GameViewBase* model, UIView* view){
        if(self.carView == view){
            model.needs_removing = true;
            ObstacleView* pv = (ObstacleView*)model;
            [pv.obs applyAffect:self.car];
           // [model removeObservers];
            //[model removeFromSuperview];
        }
    };
    
    [roadView insertSubview:view belowSubview:self.carView];
    [self.gameObjects addObject:obs];

}

-(void)createPowerUp{
    PowerUp* powup = [[PowerUp alloc]init];
    int type = arc4random_uniform(PowerUpCount);
    powup.path = POWER_UP_FILE_NAMES[type];
    powup.locX = arc4random() % (int)(roadView.bounds.size.width - POWER_UP_WIDTH);
    powup.locY = roadView.frame.origin.y - POWER_UP_HEIGHT;
    powup.powerUpType = type;
    PowerUpView* powerUpView = [self.gameFactory createPowerUpWithModelData:powup];
    
    if([self doesIntersectOther:powerUpView]) {
        return;
    }
    
    powerUpView.onContactWith = ^(GameViewBase* model, UIView* view){
        if(self.carView == view){
            model.needs_removing = true;
            PowerUpView* pv = (PowerUpView*)model;
            [pv.powerUp applyAffect:self.car];
            [model removeObservers];
            [model removeFromSuperview];
        }
    };
    
    [roadView addSubview:powerUpView];
    [self.gameObjects addObject:powup];
}

-(void)endGame{
    [waveTimer invalidate];
    waveTimer = nil;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.carView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self.carView removeObservers];
        [self.carView removeFromSuperview];
        [self stopPress:nil];
        
        self.gameData.emotion = self.emotion.currentEmotionImg;
        
        [self presentViewController:[Popups createPopupForScoreSubmis:self.gameData] animated:YES completion:^{
            
        }];
        
        [self showGameOverScreen];
        
    }];
    
}

-(void)showGameOverScreen{

    middleLabel.alpha = 1.0f;
    middleLabel.textAlignment = NSTextAlignmentLeft;
    middleLabel.font = [UIFont boldSystemFontOfSize:60];
    middleLabel.text = @"Game Over\nTap to Reset";
    
    for(UIGestureRecognizer* rec in self.view.gestureRecognizers){
        [self.view removeGestureRecognizer:rec];
    }
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resetTap)];
    singleTap.numberOfTapsRequired = 1;
    [middleLabel setUserInteractionEnabled:YES];
    [middleLabel addGestureRecognizer:singleTap];
}

-(void)resetTap{
    self.scoreLabel.text = @"0";
    [self viewDidDisappear:false];
    [middleLabel removeFromSuperview];
    [self viewDidAppear:false];
}

-(BOOL)doesIntersectOther:(GameViewBase*)view{
    for(GameViewBase* cv in roadView.subviews){
        if([cv isKindOfClass:[GameViewBase class]])
        {
            if(CGRectIntersectsRect(cv.frame, view.frame)){
                [view removeObservers];
                return YES;
            }
        }
    }
    return NO;
}

-(void)createDriverCar{
    
    int type = arc4random_uniform(CAR_COUNTS);
    
    Car* car = [[Car alloc]initCarWithFileName:CAR_FILE_NAMES[type]];
    car.locX = arc4random() % (int)(roadView.bounds.size.width - CAR_WIDTH);
    car.locY = roadView.frame.origin.y - CAR_HEIGHT;
    car.speed = (self.gameData.speedFrom + arc4random() % (self.gameData.speedTo-self.gameData.speedFrom)) / 100;
    CarView* driver = [self.gameFactory createCarViewWithModelData:car];
    
    if([self doesIntersectOther:driver]) {
        return;
    }
    
    driver.onContactWith = ^(GameViewBase* from, UIView* with){
        
        [UIView animateWithDuration:0.5 animations:^{
            from.alpha = 0;
            if(with == self.carView){
                
                CarView* source = (CarView*) with;
                int length = (int) [source.destructionImages count];
                if(length - 1 > self.car.destructionLevel){
                    self.car.destructionLevel++;
                }
                
                else{
                    [self endGame];
                }
                
                
            }
        } completion:^(BOOL finished) {
            [from removeObservers];
            [from removeFromSuperview];
        }];
        
    };
    
    
    [roadView addSubview:driver];
    [self.gameObjects addObject:car];
    
}


-(void)holdPress:(UILongPressGestureRecognizer*)hold withSender:(UIImageView*)sender{
    if(hold.state == UIGestureRecognizerStateBegan){
        //Start a new timer to update the acceleration
        if(touchTimer != nil){
            [touchTimer invalidate];
            touchTimer = nil;
            direction = 0;
            lastLocation.image = lastLocation == self.left ? self.leftDefault : self.rightDefault;
            lastLocation.alpha = 0.45;
            
            touchTimer  = [NSTimer timerWithTimeInterval:0.0075 target:self selector:@selector(UpdateMovement:) userInfo:nil repeats:YES];
            [[NSRunLoop mainRunLoop] addTimer:touchTimer forMode:NSDefaultRunLoopMode];
            lastLocation = sender;
        }
        else{
            touchTimer  = [NSTimer timerWithTimeInterval:0.0075 target:self selector:@selector(UpdateMovement:) userInfo:nil repeats:YES];
            [[NSRunLoop mainRunLoop] addTimer:touchTimer forMode:NSDefaultRunLoopMode];
            lastLocation = sender;
            lastLocation.alpha = 0.7;
            lastLocation.image = lastLocation == self.left ? self.leftDown : self.rightDown;
            [lastLocation setNeedsDisplay];
        }
    }
    else if(hold.state == UIGestureRecognizerStateEnded){
        [touchTimer invalidate];
        touchTimer = nil;
        direction = 0;
        lastLocation.image = lastLocation == self.left ? self.leftDefault : self.rightDefault;
        lastLocation.alpha = 0.45;
        

    }
}

//Called by timer when finger is pressed on screen
-(void)UpdateMovement:(NSTimer*)timer{
    
    if(!isShowingWaveAnimiation){
        
        //If finger is to the right
        if((lastLocation == self.right && (self.carView.frame.origin.x + self.carView.frame.size.width) < roadView.bounds.size.width)){

            direction += 1;
        }
    
        //If finger is to the left
        else if(lastLocation == self.left && self.carView.frame.origin.x > roadView.bounds.origin.x){
        
            direction += -1;
        
        }
        else{
        
            direction = 0;
            [touchTimer invalidate];
            touchTimer = nil;
        }
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createRoadScroll {
    UIImage *road = [UIImage imageNamed:@"road.png"];
    UIColor *roadPattern = [UIColor colorWithPatternImage:road];
    
     roadView = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x
, self.view.frame.origin.y,road.size.width * 2 , self.view.frame.size.height)];
    
    
    backGroundLayer = [CALayer layer];
    backGroundLayer.backgroundColor = roadPattern.CGColor;
    
    backGroundLayer.transform = CATransform3DMakeScale(1, -1, 1);
    backGroundLayer.anchorPoint = CGPointMake(0, 1);
    
    CGSize viewSize = roadView.frame.size;
    backGroundLayer.frame = CGRectMake(0, 0, road.size.width * 2, road.size.height + viewSize.height);
    CGPoint startPoint = CGPointZero;
    CGPoint endPoint = CGPointMake(0, -road.size.height);
    
    backGroundLayerAnimiation = [CABasicAnimation animationWithKeyPath:@"position"];
    backGroundLayerAnimiation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    backGroundLayerAnimiation.fromValue = [NSValue valueWithCGPoint:endPoint];
    backGroundLayerAnimiation.toValue = [NSValue valueWithCGPoint:startPoint];
    backGroundLayerAnimiation.repeatCount = HUGE_VALF;
    backGroundLayerAnimiation.duration = self.gameData.scrollSpeed;
    
    [roadView.layer addSublayer:backGroundLayer];
    [self applyAnimiationLayer];
    [self pauseLayer:roadView.layer];
    [self.view addSubview:roadView];
}

- (void)applyAnimiationLayer {
    [backGroundLayer addAnimation:backGroundLayerAnimiation forKey:@"position"];
}

-(void)pauseLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}

-(void)resumeLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
}


- (void)applicationWillEnterForeground:(NSNotification *)note {
    [self applyAnimiationLayer];
}

bool firstTimeStart = true;
-(IBAction)startPress:(id)sender{
    if(paused)
    {
        paused = false;
        countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countdown:) userInfo:Nil repeats:YES];
    }
}

int current = 3;

-(void)countdown:(NSTimer*)sender{
    if(current  == -1){
        [countDownTimer invalidate];
        countDownTimer = nil;
        current = 3;
        middleLabel.alpha = 0.0f;
        
        if(firstTimeStart){
            isShowingWaveAnimiation = true;
            [self incrementWave:^{
                isShowingWaveAnimiation = false;
                firstTimeStart = false;
                [self resumeLayer:roadView.layer];
                [self handleNilTimer];
            }];
        
            
        }

        else{
            direction = 0;
            [self resumeLayer:roadView.layer];
            [self handleNilTimer];
        }
        
        waveTimer = [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(waveComplete:) userInfo:Nil repeats:YES];
        
        
        return;
    }
    
    middleLabel.textAlignment = NSTextAlignmentCenter;
    middleLabel.text = current == 0 ? @"Go!" : [NSString stringWithFormat:@"%d", current];
    middleLabel.font = [UIFont boldSystemFontOfSize:100];
    middleLabel.textColor = [UIColor whiteColor];
    middleLabel.center = roadView.center;
    middleLabel.alpha = 1.0f;
    
    
    //Play the screen animation
    [GeneralMethods scaleThenRevert:middleLabel fromFloat:0.1 durationFloat:0.5 onComplete:nil withRotate:YES revertTo:CGAffineTransformIdentity];
    
    current--;
}
bool isShowingWaveAnimiation = false;
-(void)waveComplete:(NSTimer*)sender{
    isShowingWaveAnimiation = true;
    self.car.destructionLevel = -1;
    direction = 0;
    [touchTimer invalidate];
    touchTimer = nil;

    [self handleNilTimer];
    
    [self incrementWave:^{
        [self handleNilTimer];
        isShowingWaveAnimiation = false;
        
    }];
}

-(IBAction)stopPress:(id)sender{
    if(!paused){
        [self pauseLayer:roadView.layer];
        [waveTimer invalidate];
        waveTimer = nil;
        [self handleNilTimer];
    }
    paused = true;
}

-(void)incrementWave:(void (^)())complete{
    [self.view bringSubviewToFront:self.waveLabel];
    
    double trafficIncrease = ((self.gameData.trafficLevel / 100.0) * 10) + 1;
    double obstacleIncrease =((self.gameData.obstacleRate / 100.0) * 10) + 1;
    
    self.gameData.currentWave++;
    self.gameData.trafficLevel = self.gameData.trafficLevel == 2 ? 2 : self.gameData.trafficLevel -round(trafficIncrease);
    self.gameData.obstacleRate =self.gameData.obstacleRate == 2 ? 2 : self.gameData.obstacleRate -round(obstacleIncrease);
    self.gameData.speedFrom = (self.gameData.speedFrom + 30);
    self.gameData.speedTo = (self.gameData.speedTo + 30);
    self.waveLabel.text = [NSString stringWithFormat:@"Wave:%d", self.gameData.currentWave];
    CGRect old = self.waveLabel.frame;
    
    [UIView animateWithDuration:0.5 animations:^{
        } completion:^(BOOL finished){
            
            [UIView animateWithDuration:0.5 animations:^{
                self.waveLabel.frame = CGRectMake(roadView.center.x, roadView.center.y, self.waveLabel.frame.size.width, self.waveLabel.frame.size.height);
                } completion:^(BOOL finished){
                
                    [UIView animateWithDuration:0.5 animations:^{
                        [GeneralMethods scaleThenRevert:self.waveLabel fromFloat:5 durationFloat:0.5 onComplete:^{
                            [UIView animateWithDuration:0.5 animations:^{
                                //self.waveLabel.transform = CGAffineTransformIdentity;
                                self.waveLabel.frame = old;
                            } completion:^(BOOL finished) {
                                complete();
                            }];
                        }withRotate:NO revertTo:CGAffineTransformIdentity];
                        //self.waveLabel.transform = CGAffineTransformMakeScale(3, 3);
                    } completion:^(BOOL finished) {
                        
                    }];
            }];
    
        }];

}

//Creates a new timer if the timer is null
//Stops the current timer otherwise
-(bool)handleNilTimer{
    if(mainGameTimer == nil){
        mainGameTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(gameTic:) userInfo:Nil repeats:YES];
        return true;
    }
    
    else{
        [mainGameTimer invalidate];
        mainGameTimer = nil;
        return false;
    }
}

-(void)setDefaultFactory{
    self.gameFactory = [[StandardGameFactory alloc]init];
}

@end
