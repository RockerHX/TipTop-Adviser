//
//  HXReservationDetailViewController.m
//  TipTop-Adviser
//
//  Created by ShiCang on 15/10/25.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXReservationDetailViewController.h"
#import "HXReservationAddRemarkViewController.h"
#import "HXReservationDetailContainerViewController.h"


static NSString *SendOrderApi       = @"/order/confirm";
static NSString *DeleteRemarkApi    = @"/order/remarkDelete";


@interface HXReservationDetailViewController () <
HXReservationAddRemarkContainerViewControllerDelegate
>
@end

@implementation HXReservationDetailViewController {
    HXReservationDetailContainerViewController *_cantainerViewController;
}

#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    _cantainerViewController = segue.destinationViewController;
    _cantainerViewController.orderID = _orderID;
}

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initConfig];
    [self viewConfig];
}

#pragma mark - Config Methods
- (void)initConfig {
    ;
}

- (void)viewConfig {
    ;
}

#pragma mark - Setter And Getter
- (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameMyReservation;
}

#pragma mark - Event Response
- (IBAction)remarkButtonPressed {
    HXReservationAddRemarkViewController *addRemarkViewController = [HXReservationAddRemarkViewController instance];
    addRemarkViewController.delegate = self;
    addRemarkViewController.orderID = _orderID;
    [self.navigationController pushViewController:addRemarkViewController animated:YES];
}

#pragma mark - HXReservationAddRemarkContainerViewControllerDelegate Methods
- (void)addRevervationViewAddSuccess:(HXReservationAddRemarkViewController *)viewContaoller {
    [_cantainerViewController loadData];
}

@end
