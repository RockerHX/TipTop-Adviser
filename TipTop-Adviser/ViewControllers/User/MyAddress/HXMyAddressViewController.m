//
//  HXMyAddressViewController.m
//  TipTop-Adviser
//
//  Created by ShiCang on 15/10/19.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXMyAddressViewController.h"
#import <REFrostedViewController/REFrostedViewController.h>

@implementation HXMyAddressViewController

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Event Response
- (IBAction)menuButtonPressed {
    [self.frostedViewController presentMenuViewController];
}

#pragma mark - Setter And Getter
- (NSString *)navigationControllerIdentifier {
    return @"HXMyAddressNavigationController";
}

- (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameMyAddress;
}

@end
