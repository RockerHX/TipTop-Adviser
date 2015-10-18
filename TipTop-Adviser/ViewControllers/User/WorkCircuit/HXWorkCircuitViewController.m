//
//  HXWorkCircuitViewController.m
//  TipTop-Adviser
//
//  Created by ShiCang on 15/10/18.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXWorkCircuitViewController.h"

@interface HXWorkCircuitViewController ()

@end

@implementation HXWorkCircuitViewController

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Setter And Getter
- (NSString *)navigationControllerIdentifier {
    return @"HXMyWorkCircuitNavigationController";
}

- (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameWorkCircuit;
}

@end
