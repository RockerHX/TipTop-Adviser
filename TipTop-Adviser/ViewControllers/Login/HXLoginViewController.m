//
//  HXLoginViewController.m
//  TipTop-Consultant
//
//  Created by ShiCang on 15/10/5.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>
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
        [self startLoginRequest];
    }
}

- (void)userForgotPassword {
    
}

- (void)userNeedRegister {
    
}

#pragma mark - Request Methods
- (void)startLoginRequest {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary *parameters = @{@"staff_id": _phoneNumberTextField.text,
                                 @"password": _passwordTextField.text};
    [HXAdviser loginWithParameters:parameters success:^(HXApiResponse *response, HXAdviser *adviser) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(HXApiResponse *response) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

@end
