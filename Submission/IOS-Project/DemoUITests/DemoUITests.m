//
//  DemoUITests.m
//  DemoUITests
//
//  Created by Will on 30/09/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface DemoUITests : XCTestCase

@end

@implementation DemoUITests

XCUIApplication* app;

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    app = [[XCUIApplication alloc] init];
    app.launchEnvironment = @{@"isUITest": @YES};
    [app launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    
}

-(void)testZoomIn{
    
    [app.buttons[@"plus"] tap];
    
    XCUIElement *element = [[[[[[[[XCUIApplication alloc] init].otherElements containingType:XCUIElementTypeNavigationBar identifier:@"View"] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0];
    
 
}

-(void)testEmotionVisible{

    [app.images[@"neutral.png"] tap];
    
    XCUIElement* element = [[[[[[[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeImage] elementBoundByIndex:3];
    
    XCTAssertTrue(element.hittable);
    
    [element tap];
    
}

-(void)testEmotionValue{
    [app.images[@"neutral.png"] tap];
    
    XCUIElement* element = [[[[[[[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeImage] elementBoundByIndex:3];
    
}

-(void)testGameLeftRightPause{
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.buttons[@"Game"] tap];
    
    XCUIElement *rightImage = app.images[@"right"];
    [rightImage tap];
    [rightImage tap];
    [rightImage tap];
    [rightImage tap];
    [app.buttons[@"start"] tap];
    [app.images[@"left"] pressForDuration:0.9];
    [rightImage pressForDuration:1.8];
    [app.buttons[@"stop"] tap];
    
}

-(void)testHighScoresNavigate{
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.buttons[@"Game"] tap];
    [app.buttons[@"start"] tap];
    [app.buttons[@"trophy"] tap];
    [[[[app.navigationBars[@"GameHighScores"] childrenMatchingType:XCUIElementTypeButton] matchingIdentifier:@"Back"] elementBoundByIndex:0] tap];
    
}



-(void)testHappyEmotionTap{
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.buttons[@"Socialize!"] tap];
    
    [app.buttons[@"smile"] tap];
    
    XCUIElement *whoSHappyStaticText = app.staticTexts[@"Who's Happy?"];
    XCTAssertNotNil(whoSHappyStaticText);
}

-(void)testSadEmotionTap{
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.buttons[@"Socialize!"] tap];
    
    [app.buttons[@"sad"] tap];
    
    XCUIElement *whoSHappyStaticText = app.staticTexts[@"Who's Sad?"];
    XCTAssertNotNil(whoSHappyStaticText);
}

-(void)testNoEmotionTap{
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.buttons[@"Socialize!"] tap];
    [app.buttons[@"neutral"] tap];
    XCUIElement *whoSHappyStaticText = app.staticTexts[@"Emotionless?"];
    XCTAssertNotNil(whoSHappyStaticText);
}

-(void)testNameChangeOnTweetSelect{
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.buttons[@"Socialize!"] tap];
    [app.buttons[@"smile"] tap];
    XCUIElementQuery *tablesQuery = app.tables;
    [[tablesQuery.cells elementBoundByIndex:0] tap];
    
    XCUIElement *textView = [[[[[app.otherElements containingType:XCUIElementTypeNavigationBar identifier:@"TweetsScreenView"] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeTextView].element;
    [textView tap];
    [textView tap];
    
}

-(void)testInfoTapOnTweetScreen{
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.buttons[@"Socialize!"] tap];
    [app.buttons[@"smile"] tap];
    [app.buttons[@"More Info"] tap];
    
    
    XCUIElement* element = [[[[[[[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeImage] elementBoundByIndex:1];
    
    XCTAssertTrue(element.hittable);
    
}

-(void)testPullMoreWords{
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.buttons[@"Socialize!"] tap];
    [app.buttons[@"cloud dl"] tap];
    [[[[[[[app.otherElements containingType:XCUIElementTypeNavigationBar identifier:@"SocialView"] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] tap];    
}

-(void)testWidgetPressOnSocialScreen{
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.buttons[@"Socialize!"] tap];
    [app.images[@"neutral.png"] tap];
    
    XCUIElement* element = [[[[[[[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeImage] elementBoundByIndex:3];
    
    XCTAssertTrue(element.hittable);
    
}

-(void)testTweetTextEdit{
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.buttons[@"Socialize!"] tap];
    [app.buttons[@"smile"] tap];
    
    XCUIElement *tweetButtonButton = app.buttons[@"tweet button"];
    [tweetButtonButton tap];
    
    XCUIElement *textView = [[[[[app.otherElements containingType:XCUIElementTypeNavigationBar identifier:@"TweetsScreenView"] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeTextView].element;
    [textView tap];
    [textView typeText:@""];
    [app.buttons[@"Dismiss"] tap];
    [tweetButtonButton tap];
    
}




@end
