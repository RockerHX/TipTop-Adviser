//
//  HXUserViewController.m
//  TipTop-Adviser
//
//  Created by ShiCang on 15/10/5.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXUserViewController.h"
#import "HXSettingViewController.h"
#import "HXMyReservationViewController.h"
#import "HXOnlinePayViewController.h"
#import "HXWorkCircuitViewController.h"
#import "HXMyBiddingViewController.h"
#import "HXMyServiceViewController.h"
#import "HXMessageCenterViewController.h"
#import "HXMyCommentViewController.h"

typedef NS_ENUM(NSUInteger, HXMenuRow) {
    HXMenuRowMyReservation = 0,
    HXMenuRowOnlinePay     = 1,
    HXMenuRowWorkCircuit   = 2,
    HXMenuRowMyBidding     = 4,
    HXMenuRowMyService     = 5,
    HXMenuRowMyComment     = 7,
    HXMenuRowMessageCenter = 8,
    HXMenuRowMyAddress     = 9
};

@interface HXUserViewController ()

@end

@implementation HXUserViewController

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Event Response
- (IBAction)settingButtonPressed {
    if (_delegate && [_delegate respondsToSelector:@selector(userCenterShouldHiddenAndShowViewController:)]) {
        UINavigationController *settingNavigationController = [HXSettingViewController navigationControllerInstance];
        [_delegate userCenterShouldHiddenAndShowViewController:settingNavigationController];
    }
}

- (IBAction)editButtonPressed {
    
}

#pragma mark - Table View Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UINavigationController *navigationController = nil;
    if (_delegate && [_delegate respondsToSelector:@selector(userCenterShouldHiddenAndShowViewController:)]) {
        switch (indexPath.row) {
            case HXMenuRowMyReservation: {
                navigationController = [HXMyReservationViewController navigationControllerInstance];
                break;
            }
            case HXMenuRowOnlinePay: {
                navigationController = [HXOnlinePayViewController navigationControllerInstance];
                break;
            }
            case HXMenuRowWorkCircuit: {
                navigationController = [HXWorkCircuitViewController navigationControllerInstance];
                break;
            }
            case HXMenuRowMyBidding: {
                navigationController = [HXMyBiddingViewController navigationControllerInstance];
                break;
            }
            case HXMenuRowMyService: {
                navigationController = [HXMyServiceViewController navigationControllerInstance];
                break;
            }
            case HXMenuRowMyComment: {
                navigationController = [HXMessageCenterViewController navigationControllerInstance];
                break;
            }
            case HXMenuRowMessageCenter: {
                navigationController = [HXMyCommentViewController navigationControllerInstance];
                break;
            }
            case HXMenuRowMyAddress: {
                
                break;
            }
        }
        [_delegate userCenterShouldHiddenAndShowViewController:navigationController];
    }
}

@end
