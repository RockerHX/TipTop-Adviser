//
//  HXMainViewController.m
//  TipTop-Adviser
//
//  Created by ShiCang on 15/10/10.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXMainViewController.h"
#import "HXStoryBoardManager.h"
#import "HXHomeViewController.h"
#import "HXUserViewController.h"
#import "HXLoginViewController.h"
#import "HXGuideView.h"
#import "HXAppConstants.h"
#import "HXSocketManager.h"

@interface HXMainViewController () <HXLoginViewControllerDelegate, HXUserViewControllerDelegate>
@end

@implementation HXMainViewController {
    __block BOOL _logined;
}

#pragma mark - Init Methods
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initConfig];
}

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self viewConfig];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if ([HXUserSession share].state == HXUserSessionStateLogout) {
        [self showLoginViewController];
    } else {
        if (!_logined) {
            [self showHomePageViewController];
        }
    }

}

#pragma mark - Config Methods
- (void)initConfig {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLogout) name:kUserLogoutNotification object:nil];
    [self setupAppStructure];
}

- (void)setupAppStructure {
    self.contentViewController = [HXHomeViewController navigationControllerInstance];
    HXUserViewController *userViewController = [HXStoryBoardManager viewControllerWithClass:[HXUserViewController class]
                                                                             storyBoardName:HXStoryBoardNameUser];
    userViewController.delegate = self;
    self.menuViewController = userViewController;
}

- (void)viewConfig {
}

#pragma mark - Private Methods
- (void)showLoginViewController {
    HXLoginViewController *loginViewController = [HXLoginViewController instance];
    loginViewController.delegate = self;
    loginViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:loginViewController animated:NO completion:nil];
}

- (void)showHomePageViewController {
    HXHomeViewController *homePageViewController = [((UINavigationController *)self.contentViewController).viewControllers firstObject];
    [homePageViewController openSocket];
}

- (void)userLogout {
    [[HXSocketManager manager] close];
    [self showLoginViewController];
}

#pragma mark - HXLoginViewControllerDelegate Methods
- (void)loginViewControllerLoginSuccess:(HXLoginViewController *)loginViewController {
    _logined = YES;
    __weak __typeof__(self)weakSelf = self;
    [self dismissViewControllerAnimated:YES completion:^{
        __strong __typeof__(self)strongSelf = weakSelf;
        [strongSelf showHomePageViewController];
    }];
}

#pragma mark - HXUserViewControllerDelegate Methods
- (void)userCenterShouldHiddenAndShowViewController:(UIViewController *)viewController {
    UINavigationController *contentNavigationController = (UINavigationController *)self.contentViewController;
    HXHomeViewController *homeViewController = [contentNavigationController.viewControllers firstObject];
    [homeViewController.navigationController pushViewController:viewController animated:YES];
    [self hideMenuViewController];
}

@end
