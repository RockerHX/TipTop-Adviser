//
//  HXMyReservationViewController.m
//  TipTop-Adviser
//
//  Created by ShiCang on 15/10/15.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXMyReservationViewController.h"
#import "HXStoryBoardManager.h"

@interface HXMyReservationViewController ()

@end

@implementation HXMyReservationViewController

#pragma mark - Instance Methods
+ (UINavigationController *)navigationControllerInstance {
    return [HXStoryBoardManager navigaitonControllerWithIdentifier:@"HXMyReservationNavigationController" storyBoardName:HXStoryBoardNameMyReservation];
}

+ (instancetype)instance {
    return [HXStoryBoardManager viewControllerWithClass:[HXMyReservationViewController class] storyBoardName:HXStoryBoardNameMyReservation];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
