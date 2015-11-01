//
//  HXAddBiddingViewController.m
//  TipTop-Adviser
//
//  Created by ShiCang on 15/11/1.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXAddBiddingViewController.h"

@interface HXAddBiddingViewController ()
@end

@implementation HXAddBiddingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Table View Delegete Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
