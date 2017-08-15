//
//  ViewController.m
//  AppliTools XCUI Demo
//
//  Created by Anton Chuev on 6/23/16.
//  Copyright © 2016 appli-tools. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UIButton *sayHelloButton;
@property (nonatomic, weak) IBOutlet UIButton *showStuffButton;
@property (nonatomic, weak) IBOutlet UILabel *footerLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupColors];
    [self.sayHelloButton addTarget:self action:@selector(sayHello) forControlEvents:UIControlEventTouchUpInside];
    self.sayHelloButton.accessibilityIdentifier = @"the button";
    
    self.showStuffButton.accessibilityIdentifier = @"show elements";
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    CGFloat seconds = 10;
    int64_t delta = seconds * NSEC_PER_SEC;
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, delta);
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [self.sayHelloButton setTitle:@"Ciao" forState:UIControlStateNormal];
    });
}

- (void)setupColors {
    [self.sayHelloButton setTitleColor:[UIColor colorWithRed:0.15 green:0.68 blue:0.38 alpha:1] forState:UIControlStateNormal];
    [self.showStuffButton setTitleColor:[UIColor colorWithRed:0.15 green:0.68 blue:0.38 alpha:1] forState:UIControlStateNormal];
    self.footerLabel.textColor = [UIColor colorWithRed:0.66 green:0.66 blue:0.73 alpha:1.];
}

#pragma mark

- (void)sayHello {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Hello" message:@"Sup?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:dismissAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
