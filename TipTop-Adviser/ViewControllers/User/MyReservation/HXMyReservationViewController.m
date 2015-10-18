//
//  HXMyReservationViewController.m
//  TipTop-Adviser
//
//  Created by ShiCang on 15/10/15.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXMyReservationViewController.h"

@interface HXMyReservationViewController ()

@end

@implementation HXMyReservationViewController

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Setter And Getter
- (NSString *)navigationControllerIdentifier {
    return @"HXMyReservationNavigationController";
}

- (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameMyReservation;
}

@end
