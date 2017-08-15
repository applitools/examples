//
//  ATXCUIEyes.h
//  ApplitoolsEyes
//
//  Created by Anton Chuev on 9/1/16.
//  Copyright © 2016 Applitools. All rights reserved.
//

#import "EyesBase.h"

@interface EyesXCUI : EyesBase

/**
 Whether Eyes should force a full page screenshot or not.
 Current version of the SDK supports getting the full page screenshot only if scrollable view is UITableView or inherited from it.
 */
@property (assign, nonatomic) BOOL forceFullPageScreenshot;

/**
 @abstract Takes a snapshot of the application under test and matches it with the expected output.
 @param tag An optional tag to be associated with the snapshot.
 */
- (void)checkWindowWithTag:(nullable NSString *)tag;

/**
 @abstract Takes a snapshot of the application under test and matches a region of a specific element with the expected region output.
 @param element The element which represents the region to check.
 @param tag An optional tag to be associated with the snapshot.
 */
- (void)checkRegionOfElement:(nonnull XCUIElement *)element tag:(nullable NSString *)tag;

/**
 @abstract Starts a test.
 @param appName The name of the application under test.
 @param testName The test name.
 */
- (void)eyesXCUIOpenWithApplicationName:(nullable NSString *)appName testName:(nullable NSString *)testName;

@end
