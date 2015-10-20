//
//  HXUserInformationViewController.m
//  TipTop-Adviser
//
//  Created by ShiCang on 15/10/20.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXUserInformationViewController.h"

@interface HXUserInformationViewController ()

@end

@implementation HXUserInformationViewController

#pragma mark - View Controller Life Cycle
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.canPan = YES;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.navigationController.canPan = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Setter And Getter
- (NSString *)navigationControllerIdentifier {
    return @"HXUserInformationNavigationController";
}

- (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameUser;
}

@end
