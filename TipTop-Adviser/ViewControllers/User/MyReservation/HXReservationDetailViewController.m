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

@interface HXReservationDetailViewController ()
@end

@implementation HXReservationDetailViewController

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initConfig];
    [self viewConfig];
}

#pragma mark - Segue Methods
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    HXReservationDetailContainerViewController *reservationDetailContainerViewController = segue.destinationViewController;
    reservationDetailContainerViewController.orderID = _orderID;
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
    addRemarkViewController.orderID = _orderID;
    [self.navigationController pushViewController:addRemarkViewController animated:YES];
}

@end
