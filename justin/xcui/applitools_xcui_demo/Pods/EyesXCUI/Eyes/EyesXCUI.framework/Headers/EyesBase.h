//
//  ATEyesBase.h
//  ApplitoolsEyes
//
//  Created by Anton Chuev on 8/31/16.
//  Copyright © 2016 Applitools. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MatchLevel.h"
#import "ImageMatchSettings.h"
#import "BatchInfo.h"

@interface EyesBase : XCTestCase {
@protected
    NSString *_apiKey;
    NSString *_serverURL;
    BatchInfo *_batch;
    CGSize _viewportSize;
    MatchLevel _matchLevel;
    ImageMatchSettings *_defaultMatchSettings;
}

// The API key of your applitools Eyes account.
@property (strong, nonatomic, nullable) NSString *apiKey;

// The current server URL used by the rest client.
@property (strong, nonatomic, nullable) NSString *serverURL;

// The batch in which context future tests will run or nil if tests are to run standalone.
@property (strong, nonatomic, nullable) BatchInfo *batch;

// The test-wide match level to use when checking application screenshot with the expected output.
@property (assign, nonatomic) MatchLevel matchLevel;

// Whether to ignore or the blinking caret or not when comparing images.
@property (assign, nonatomic) BOOL ignoreCaret;

// The match settings to be used for the session.
@property (strong, readonly, nonatomic, nullable) ImageMatchSettings *defaultMatchSettings;

// The client's viewport size (i.e., the visible part screen content witout status bar)
@property (assign, readonly, nonatomic) CGSize viewportSize;

/*
 @abstract Creates a new Eyes instance that interacts with the Eyes Server at the specified url.
 @param serverUrl The Eyes server URL string.
 */
- (nullable instancetype)initWithServerURL:(nonnull NSString *)serverURL;

/*
 @abstract Takes a snapshot of the application under test and sends it to the server.
 @param rect Frame to check.
 @param tag An optional tag to be associated with the snapshot.
 @param ignoreMismatch Whether to ignore this check if a mismatch is found.
 */
- (void)checkWindowBaseWithRect:(CGRect)rect tag:(nullable NSString *)tag ignoreMismatch:(BOOL)ignoreMismatch;

/*
 @abstract Takes a snapshot of the application under test and sends it to the server.
 @param rect Frame to check.
 @param tag An optional tag to be associated with the snapshot.
 @param ignoreMismatch Whether to ignore this check if a mismatch is found.
 @param completionHandler A handler block to execute.
 */
- (void)checkWindowBaseWithRect:(CGRect)rect tag:(nullable NSString *)tag ignoreMismatch:(BOOL)ignoreMismatch completionHandler:(nullable void(^)())completionHandler;

/*
 @abstract Starts a test.
 @param appName The name of the application under test.
 @param testName The test name.
 */
- (void)eyesBaseOpenWithApplicationName:(nullable NSString *)appName testName:(nullable NSString *)testName;

/*
 @abstract Ends a test.
 */
- (void)close;

/*
 @abstract Add property to start info.
 @param name Property name.
 @param value Property value.
 */
- (void)addProperty:(nonnull NSString *)name value:(nonnull NSString *)value;

/*
 @abstract Returns default server url string.
 */
+ (nonnull NSString *)defaultServerURL;

@end
