//
//  HXForgotPWViewController.m
//  TipTop-Adviser
//
//  Created by ShiCang on 15/10/7.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXForgotPWViewController.h"
#import "HXSecurityCodeButton.h"

@interface HXForgotPWViewController ()
@end

@implementation HXForgotPWViewController

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initConfig];
    [self viewConfig];
}

#pragma mark - Config Methods
- (void)initConfig {
    _codeButton.duration = 5;
    [_codeButton start:^{
        ;
    } complete:^{
        ;
    }];
}

- (void)viewConfig {
    
}

#pragma mark - Event Response
- (IBAction)backButtonPressed {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
