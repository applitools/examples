//
//  ElementsViewController.m
//  AppliTools XCUI Demo
//
//  Created by Anton Chuev on 6/24/16.
//  Copyright © 2016 appli-tools. All rights reserved.
//

#import "ElementsViewController.h"
#import "ElementFormatter.h"

@interface ElementsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSArray *elements;
@property (nonatomic, strong) ElementFormatter *elementFormatter;

@end

@implementation ElementsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.elementFormatter = [ElementFormatter new];
    
    [self setupElements];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
}

- (void)setupElements {
    NSError *error = nil;
    NSString *JSONFilePath = [[NSBundle mainBundle] pathForResource:@"periodic_table" ofType:@"json"];
    NSData *JSONData = [NSData dataWithContentsOfFile:JSONFilePath];
    self.elements = (NSArray *)[NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:&error];
}

#pragma mark

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 80;//self.elements.count/2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;//43;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSString *element = [self.elementFormatter formattedElementString:self.elements[indexPath.row]];
    cell.textLabel.text = element;
//    cell.textLabel.font = [UIFont systemFontOfSize:5.f];
//    cell.textLabel.text = [NSString stringWithFormat:@"%li", (long)(indexPath.row)];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Cell was selected");
}

@end
