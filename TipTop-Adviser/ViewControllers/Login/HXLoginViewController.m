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
    __weak __typeof__(self)weakSelf = self;
    NSDictionary *parameters = @{@"staff_id": _staffIDTextField.text,
                                 @"password": _passwordTextField.text};
    [HXAdviser loginWithParameters:parameters success:^(HXApiResponse *response, HXAdviser *adviser) {
        __strong __typeof__(self)strongSelf = weakSelf;
        [MBProgressHUD hideHUDForView:strongSelf.view animated:YES];
        if (response.errorCode == HXAppApiRequestErrorCodeNoError) {
            [[HXUserSession share] updateAdviser:adviser];
            if (strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(loginViewControllerLoginSuccess:)]) {
                [strongSelf.delegate loginViewControllerLoginSuccess:strongSelf];
            }
        } else {
            [self showAlertWithMessage:response.message];
        }
    } failure:^(HXApiResponse *response) {
        __strong __typeof__(self)strongSelf = weakSelf;
        [MBProgressHUD hideHUDForView:strongSelf.view animated:YES];
    }];
}

@end
