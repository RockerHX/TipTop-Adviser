//
//  HXOnlinePayViewController.m
//  TipTop-Adviser
//
//  Created by ShiCang on 15/10/18.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXOnlinePayViewController.h"
#import "HXStoryBoardManager.h"

@interface HXOnlinePayViewController ()

@end

@implementation HXOnlinePayViewController

#pragma mark - Instance Methods
+ (UINavigationController *)navigationControllerInstance {
    return [HXStoryBoardManager navigaitonControllerWithIdentifier:@"HXMyOnlinePayNavigationController" storyBoardName:HXStoryBoardNameOnlinePay];
}

+ (instancetype)instance {
    return [HXStoryBoardManager viewControllerWithClass:[HXOnlinePayViewController class] storyBoardName:HXStoryBoardNameOnlinePay];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
