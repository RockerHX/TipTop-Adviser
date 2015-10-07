//
//  HXLoginViewController.m
//  TipTop-Consultant
//
//  Created by ShiCang on 15/10/5.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXLoginViewController.h"
#import "HXLoginRequset.h"

@implementation HXLoginViewController

#pragma mark - View Controller Lift Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initConfig];
    [self viewConfig];
}

#pragma mark - Config Methods
- (void)initConfig {
    _phoneNumberTextField.delegate = self;
    _passwordTextField.delegate = self;
}

- (void)viewConfig {
}

#pragma mark - Event Response
- (IBAction)loginButtonPressed {
    [self startLogin];
}

- (IBAction)forgotPasswordButtonPressed {
    [self userForgotPassword];
}

- (IBAction)registerButtonPressed {
    [self userNeedRegister];
}

#pragma mark - Private Methods
- (void)startLogin {
    if (!_phoneNumberTextField.text.length) {
        
    } else if (!_passwordTextField.text.length) {
        
    } else {
        NSDictionary *parameters = @{@"staff_id": _phoneNumberTextField.text,
                                     @"password": _passwordTextField.text};
        [HXAdviser loginWithParameters:parameters success:^(HXApiResponse *response, HXAdviser *adviser) {
            adviser.avatar;
        } failure:^(HXApiResponse *response) {
            
        }];
    }
}

- (void)userForgotPassword {
    
}

- (void)userNeedRegister {
    
}

@end
