//
//  HXLoginViewController.m
//  TipTop-Adviser
//
//  Created by ShiCang on 15/10/5.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXLoginViewController.h"
#import "HXLoginRequset.h"
#import "MBProgressHUD.h"

@implementation HXLoginViewController

#pragma mark - View Controller Lift Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initConfig];
    [self viewConfig];
}

#pragma mark - Config Methods
- (void)initConfig {
    _staffIDTextField.delegate = self;
    _passwordTextField.delegate = self;
}

- (void)viewConfig {
}

#pragma mark - Setter And Getter
- (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameLogin;
}

#pragma mark - Event Response
- (IBAction)loginButtonPressed {
    [self startLogin];
}

- (IBAction)forgotPasswordButtonPressed {
    [self userForgotPassword];
}

#pragma mark - Private Methods
- (void)startLogin {
    if (_staffIDTextField.text.length < 6) {
        [self showAlertWithMessage:@"请输入正确工号！"];
    } else if (!_passwordTextField.text.length) {
        [self showAlertWithMessage:@"请输入密码！"];
    } else {
        [self startLoginRequest];
    }
}

- (void)userForgotPassword {
    
}

#pragma mark - Request Methods
- (void)startLoginRequest {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary *parameters = @{@"staff_id": _staffIDTextField.text,
                                 @"password": _passwordTextField.text};
    [HXAdviser loginWithParameters:parameters success:^(HXApiResponse *response, HXAdviser *adviser) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (response.errorCode == HXAppApiRequestErrorCodeNoError) {
            [[HXUserSession share] updateAdviser:adviser];
            if (_delegate && [_delegate respondsToSelector:@selector(loginViewControllerLoginSuccess:)]) {
                [_delegate loginViewControllerLoginSuccess:self];
            }
        } else {
            [self showAlertWithMessage:response.message];
        }
    } failure:^(HXApiResponse *response) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

@end
