//
//  HXAddBiddingViewController.m
//  TipTop-Adviser
//
//  Created by ShiCang on 15/11/1.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXAddBiddingViewController.h"
#import "HXBiddingServiceViewController.h"
#import "HXBiddingService.h"


@interface HXAddBiddingViewController () <HXBiddingServiceViewControllerDelegate>
@end

@implementation HXAddBiddingViewController {
    HXBiddingSubService *_subService;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma Segue Methods
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:NSStringFromClass([HXBiddingServiceViewController class])]) {
        HXBiddingServiceViewController *biddingServiceViewController = segue.destinationViewController;
        biddingServiceViewController.delegate = self;
    }
}

#pragma mark - Table View Delegete Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - HXBiddingServiceViewControllerDelegate Methods
- (void)serviceDidSelected:(HXBiddingSubService *)subService {
    _subService = subService;
    _serviceNameLabel.text = subService.name;
}

@end
