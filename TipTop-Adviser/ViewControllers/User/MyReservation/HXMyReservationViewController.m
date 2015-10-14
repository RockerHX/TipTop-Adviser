//
//  HXMyReservationViewController.m
//  TipTop-Adviser
//
//  Created by ShiCang on 15/10/15.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXMyReservationViewController.h"
#import "HXStoryBoardManager.h"

@interface HXMyReservationViewController ()

@end

@implementation HXMyReservationViewController


#pragma mark - Instance Methods
+ (UINavigationController *)navigationControllerInstance {
    return [HXStoryBoardManager navigaitonControllerWithIdentifier:@"HXMyReservationNavigationController" storyBoardName:HXStoryBoardNameMyReservation];
}

+ (instancetype)instance {
    return [HXStoryBoardManager viewControllerWithClass:[HXMyReservationViewController class] storyBoardName:HXStoryBoardNameMyReservation];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

@end
