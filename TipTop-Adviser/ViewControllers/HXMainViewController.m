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

@interface HXMainViewController () <HXUserViewControllerDelegate>

@end

@implementation HXMainViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.contentViewController = [HXStoryBoardManager viewControllerWithClass:[HXHomeViewController class]
                                                               storyBoardName:HXStoryBoardNameHome];
    HXUserViewController *userViewController = [HXStoryBoardManager viewControllerWithClass:[HXUserViewController class]
                                                                             storyBoardName:HXStoryBoardNameUser];
    userViewController.delegate = self;
    self.menuViewController = userViewController;
}

#pragma mark - HXUserViewControllerDelegate Methods
- (void)userCenterShouldHiddenAndShowViewController:(UIViewController *)viewController {
    self.contentViewController = viewController;
    [self hideMenuViewController];
}

@end
