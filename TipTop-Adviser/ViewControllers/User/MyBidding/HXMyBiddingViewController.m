//
//  HXMyBiddingViewController.m
//  TipTop-Adviser
//
//  Created by ShiCang on 15/10/18.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXMyBiddingViewController.h"

@implementation HXMyBiddingViewController

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Setter And Getter
- (NSString *)navigationControllerIdentifier {
    return @"HXMyBiddingNavigationController";
}

- (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameMyBidding;
}

@end
