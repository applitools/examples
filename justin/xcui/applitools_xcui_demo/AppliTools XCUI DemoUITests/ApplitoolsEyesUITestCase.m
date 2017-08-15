//
//  ApplitoolsEyesUITestCase.m
//  AppliTools XCUI Demo
//
//  Created by Anton Chuev on 9/6/16.
//  Copyright © 2016 appli-tools. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <EyesXCUI/EyesXCUI.h>
#import <EyesXCUI/BatchInfo.h>

@interface ApplitoolsEyesUITestCase : XCTestCase

@end

@implementation ApplitoolsEyesUITestCase

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    XCUIApplication *app = [XCUIApplication new];
    
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [app launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCheckWindow {
    // Create an instance of XCUIEyes class
    EyesXCUI *eyes = [EyesXCUI new];
    
    // This is your api key, make sure you use it in all your tests.
    eyes.apiKey = @"9RkMajXrzS1Zu110oTWQps102CHiPRPmeyND99E9iL0G7yAc110";
    eyes.matchLevel = MatchLevelLayout;
    
    // Start testing.
    [eyes eyesXCUIOpenWithApplicationName:@"App name" testName:@"Test name"];
    
    // Tap "show table view" button and go to the 2d screen.
    [[[XCUIApplication alloc] init].buttons[@"show table view"] tap];
    
    //sleep(2);
    
    // Make one more screenshot and send it to the server.
    [eyes checkWindowWithTag:@"Tag"];
    
    // End testing.
    [eyes close];
}

- (void)testCheckRegion {
    // Create an instance of XCUIEyes class
    EyesXCUI *eyes = [EyesXCUI new];
    eyes.apiKey = @"9RkMajXrzS1Zu110oTWQps102CHiPRPmeyND99E9iL0G7yAc110";
    eyes.matchLevel = MatchLevelExact;

    // Tap "show table view" button and go to the 2d screen.
    [[[XCUIApplication alloc] init].buttons[@"show table view"] tap];
    
    XCUIApplication *app = [XCUIApplication new];
    [eyes eyesXCUIOpenWithApplicationName:@"App name" testName:@"Test name"];
    
    XCUIElement *element = app.tables.staticTexts[@"[P] Phosphorus (15)"];
    
    [eyes checkRegionOfElement:element tag:@"Tag"];
    
    // End testing.
    [eyes close];
}

- (void)testCheckRegionWithBatch {
    // Create an instance of XCUIEyes class
    EyesXCUI *eyes = [EyesXCUI new];
    
    // This is your api key, make sure you use it in all your tests.
    eyes.apiKey = @"9RkMajXrzS1Zu110oTWQps102CHiPRPmeyND99E9iL0G7yAc110";
    
    // Tap "show table view" button and go to the 2d screen.
    [[[XCUIApplication alloc] init].buttons[@"show table view"] tap];
    
    XCUIApplication *app = [XCUIApplication new];
    
    BatchInfo *batch = [[BatchInfo alloc] initWithName:@"Test batch" startedAt:[NSDate date]];
    batch.batchId = @"Test Batch ID new";
    
    for (NSInteger i = 0; i < 2; i++) {
        // Start testing.
        [eyes eyesXCUIOpenWithApplicationName:@"App name" testName:@"Test name"];
        eyes.batch = batch;
        
        // Select element.
        XCUIElement *element = app.tables.staticTexts[@"[Al] Aluminum (13)"];
        
        // Check region of selected element.
        NSString *tag = [NSString stringWithFormat:@"A tag #%li", (long)i];
        [eyes checkRegionOfElement:element tag:tag];
        
        // End testing.
        [eyes close];        
    }
}

- (void)testFullpageScreenshotOfTableView {
    // Tap "show table view" button and go to the 2d screen.
    [[[XCUIApplication alloc] init].buttons[@"show table view"] tap];
    
    // Create an instance of XCUIEyes class
    EyesXCUI *eyes = [EyesXCUI new];
    
    // This is your api key, make sure you use it in all your tests.
    eyes.apiKey = @"9RkMajXrzS1Zu110oTWQps102CHiPRPmeyND99E9iL0G7yAc110";
    eyes.matchLevel = MatchLevelExact;
    
    [eyes eyesXCUIOpenWithApplicationName:@"App name" testName:@"Test name"];
    // Set forceFullPageScreenshot flag to YES for making full page screenshot.
    eyes.forceFullPageScreenshot = YES;
    
    [eyes checkWindowWithTag:@"Tag"];
    [eyes close];
}

@end
