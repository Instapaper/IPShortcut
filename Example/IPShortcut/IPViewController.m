//
//  IPViewController.m
//  IPShortcut
//
//  Created by Brian Donohue on 11/29/2018.
//  Copyright (c) 2018 Brian Donohue. All rights reserved.
//

#import "IPViewController.h"

@interface IPViewController () <UITableViewDelegate, UITableViewDataSource>

@end

#define kReuseIdentifier @"reuse"

@implementation IPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"IPShortcut";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.frame = self.view.bounds;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kReuseIdentifier];
    [self.view addSubview:self.tableView];
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 250;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReuseIdentifier];
    cell.textLabel.text = [@(indexPath.row) stringValue];
    return cell;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Selected %lu", indexPath.row);
}

@end
