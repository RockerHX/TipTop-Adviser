//
//  HXPanGestureNavgaitionController.m
//  TipTop-Adviser
//
//  Created by ShiCang on 15/10/11.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXPanGestureNavgaitionController.h"
#import <REFrostedViewController/REFrostedViewController.h>

@implementation HXPanGestureNavgaitionController {
    BOOL _canPan;
}

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initConfig];
}

#pragma mark - Config Methods
- (void)initConfig {
    _canPan = YES;
    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)]];
}

#pragma mark - Gesture recognizer
- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender {
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    if (self.canPan) {
        [self.frostedViewController panGestureRecognized:sender];
    }
}

#pragma mark - Setter And Getter
- (BOOL)canPan {
    return _canPan;
}

- (void)setCanPan:(BOOL)canPan {
    _canPan = canPan;
}

@end
