//
//  HXPanGestureNavgaitionController.m
//  TipTop-Adviser
//
//  Created by ShiCang on 15/10/11.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXPanGestureNavgaitionController.h"
#import <REFrostedViewController/REFrostedViewController.h>

@implementation HXPanGestureNavgaitionController

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)]];
}

#pragma mark - Gesture recognizer
- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender {
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController panGestureRecognized:sender];
}

@end
