//
//  AppDelegate.m
//  AppliTools XCUI Demo
//
//  Created by Anton Chuev on 6/23/16.
//  Copyright © 2016 appli-tools. All rights reserved.
//

#import "AppDelegate.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setupAppearance];
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSLog(@"Path to bundle: %@", bundle.bundlePath);
    
//    NSInteger str = USE_SETTINGS_XY;
    
//    NSString *buildID = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"USE_SETTINGS_XY"];
//[[[NSBundle mainBundle] infoDictionary] valueForKey:@"BUILD_ID"];
    
    
    NSLog(@"Screen frame: %@", NSStringFromCGRect([UIScreen mainScreen].bounds));
    
    //NSLog(@"Main bundle: %@", [bundle infoDictionary]);
    
    
//    NSLog(@"iOS major version: %li", (long)[[NSProcessInfo processInfo] operatingSystemVersion].majorVersion);
  //  NSLog(@"iOS minor version: %li", (long)[[NSProcessInfo processInfo] operatingSystemVersion].minorVersion);
    //NSLog(@"iOS patch version: %li", (long)[[NSProcessInfo processInfo] operatingSystemVersion].patchVersion);
    //NSLog(@"iOS major version string: %@", [[NSProcessInfo processInfo] operatingSystemVersionString]);
    
    return YES;
}

- (void)setupAppearance {
    [UINavigationBar appearance].barTintColor = [UIColor colorWithRed:0.15 green:0.68 blue:0.38 alpha:1];
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    [UINavigationBar appearance].titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
}

@end
