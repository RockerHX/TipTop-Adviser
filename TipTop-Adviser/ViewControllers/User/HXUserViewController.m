//
//  HXUserViewController.m
//  TipTop-Adviser
//
//  Created by ShiCang on 15/10/5.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXUserViewController.h"
#import "HXUserInformationViewController.h"
#import "HXSettingViewController.h"
#import "HXMyReservationListViewController.h"
#import "HXOnlinePayListViewController.h"
#import "HXWorkCircuitListViewController.h"
#import "HXMyBiddingViewController.h"
#import "HXMyServiceViewController.h"
#import "HXMessageCenterViewController.h"
#import "HXMyCommentViewController.h"
#import "HXMyAddressViewController.h"
#import "UIImageView+WebCache.h"

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
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self updateUserInfo];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initConfig];
    [self viewConfig];
}

#pragma mark - Config Methods
- (void)initConfig {
    
}

- (void)viewConfig {
}

#pragma mark - Event Response
- (IBAction)userHeaderPressed {
    if (_delegate && [_delegate respondsToSelector:@selector(userCenterShouldHiddenAndShowViewController:)]) {
        UINavigationController *userInformationViewController = [HXUserInformationViewController navigationControllerInstance];
        [_delegate userCenterShouldHiddenAndShowViewController:userInformationViewController];
    }
}

- (IBAction)settingButtonPressed {
    if (_delegate && [_delegate respondsToSelector:@selector(userCenterShouldHiddenAndShowViewController:)]) {
        UINavigationController *settingNavigationController = [HXSettingViewController navigationControllerInstance];
        [_delegate userCenterShouldHiddenAndShowViewController:settingNavigationController];
    }
}

- (IBAction)editButtonPressed {
    
}

#pragma mark - Private Methods
- (void)updateUserInfo {
    HXAdviser *adviser = [HXUserSession share].adviser;
    [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:adviser.avatar]];
    _nameLabel.text = adviser.realName;
    _mobileLabel.text = adviser.mobile;
}

#pragma mark - Table View Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UINavigationController *navigationController = nil;
    if (_delegate && [_delegate respondsToSelector:@selector(userCenterShouldHiddenAndShowViewController:)]) {
        switch (indexPath.row) {
            case HXMenuRowMyReservation: {
                navigationController = [HXMyReservationListViewController navigationControllerInstance];
                break;
            }
            case HXMenuRowOnlinePay: {
                navigationController = [HXOnlinePayListViewController navigationControllerInstance];
                break;
            }
            case HXMenuRowWorkCircuit: {
                navigationController = [HXWorkCircuitListViewController navigationControllerInstance];
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
                navigationController = [HXMyAddressViewController navigationControllerInstance];
                break;
            }
        }
        [_delegate userCenterShouldHiddenAndShowViewController:navigationController];
    }
}

@end
