//
//  HXHomeViewController.m
//  TipTop-Adviser
//
//  Created by ShiCang on 15/10/5.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXHomeViewController.h"
#import "HXSocketManager.h"
#import "MBProgressHUD.h"
#import "UIConstants.h"
#import "HXNewOrder.h"
#import "HXOrderAlertView.h"
#import "UIAlertView+BlocksKit.h"
#import "HXThemeManager.h"
#import "HXUserSession.h"

typedef NS_ENUM(NSUInteger, HXHomePageConnectState) {
    HXHomePageConnectStateOnline,
    HXHomePageConnectStateOffline,
};

static NSString *NewOrderEvent = @"new_order";

@interface HXHomeViewController ()
@end

@implementation HXHomeViewController {
    HXNewOrder *_newOrder;
}

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initConfig];
    [self viewConfig];
}

#pragma mark - Config Methods
- (void)initConfig {
}

- (void)viewConfig {
    _orderTitleLabel.text = @"暂无需求";
    _subTitleLabel.text = @"等待发单";
}

- (void)openSocket {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak __typeof__(self)weakSelf = self;
    [[HXSocketManager manager] openWithURL:[NSURL URLWithString:@"ws://115.29.45.120:8081"] opened:^(HXSocketManager *manager) {
        __strong __typeof__(self)strongSelf = weakSelf;
        [MBProgressHUD hideHUDForView:strongSelf.view animated:YES];
        [strongSelf loginAction];
        [strongSelf displayWithConnectSatae:HXHomePageConnectStateOnline];
    } receiveData:^(HXSocketManager *manager, id data) {
        __strong __typeof__(self)strongSelf = weakSelf;
        [strongSelf handleData:data];
    } closed:^(HXSocketManager *manager, NSInteger code) {
        __strong __typeof__(self)strongSelf = weakSelf;
        [MBProgressHUD hideHUDForView:strongSelf.view animated:YES];
        [manager reConnect];
    } failed:^(HXSocketManager *manager, NSError *error) {
        __strong __typeof__(self)strongSelf = weakSelf;
        [strongSelf displayWithConnectSatae:HXHomePageConnectStateOffline];
    }];
}

#pragma mark - Event Response
- (void)grabButtonPressed {
    if (_newOrder) {
        NSDictionary *data = @{@"event": @"grab",
                               @"order_id": _newOrder.ID};
        [[HXSocketManager manager] sendData:data];
    }
}

#pragma mark - Private Methods
- (void)loginAction {
    NSDictionary *data = @{@"event": @"login",
                            @"type": @"agent",
                    @"access_token": [HXUserSession share].adviser.accessToken};
    [[HXSocketManager manager] sendData:data];
}

- (void)handleData:(NSString *)data {
    NSData *jsonData = [data dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *receiveData = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
    [self hanleEventWithReceiveData:receiveData];
}

- (void)hanleEventWithReceiveData:(NSDictionary *)receiveData {
    NSInteger errorCode = [receiveData[@"error"] integerValue];
    if (!errorCode) {
        NSString *event = receiveData[@"event"];
        NSString *extra = receiveData[@"extra"];
        if ([event isEqualToString:NewOrderEvent]) {
            _newOrder = [HXNewOrder mj_objectWithKeyValues:extra];
            [self displayWithNewOrder:_newOrder];
        } else if ([event isEqualToString:@"grab"]) {
            [self showOrderAlertWithOrder:[HXGrabOrder mj_objectWithKeyValues:extra]];
        }
    } else {
        NSString *message = receiveData[@"msg"];
        [UIAlertView bk_showAlertViewWithTitle:@"温馨提示"
                                       message:message
                             cancelButtonTitle:@"确定"
                             otherButtonTitles:nil
                                       handler:nil];
    }
}

- (void)displayWithNewOrder:(HXNewOrder *)newOrder {
    _orderTitleLabel.text = newOrder.cate;
    _subTitleLabel.text = newOrder.subCate;
    _promptLabel.text = @"收到 1 个需求";
}

- (void)displayWithConnectSatae:(HXHomePageConnectState)state {
    switch (state) {
        case HXHomePageConnectStateOnline: {
            [self adviseOnline];
            break;
        }
        case HXHomePageConnectStateOffline: {
            [self adviserOffline];
            break;
        }
    }
}

- (void)adviseOnline {
    self.view.backgroundColor = [HXThemeManager share].themeColor;
    
    _locationIcon.image = [UIImage imageNamed:@"HP-LocationOnlineIcon"];
    
    UIColor *textColor = [UIColor whiteColor];
    _locationLabel.textColor = textColor;
    _promptLabel.textColor = textColor;
    _orderTitleLabel.textColor = textColor;
    _subTitleLabel.textColor = textColor;
    
    _cylindrical.image = [UIImage imageNamed:@"HP-CylindricalOnlineIcon"];
    _innerCircle.image = [UIImage imageNamed:@"HP-InnerCircleOnlineIcon"];
    
    _grabButton.enabled = YES;
    _grabButton.backgroundColor = self.view.backgroundColor;
    _grabButton.layer.borderColor = [UIColor whiteColor].CGColor;
}

- (void)adviserOffline {
    self.view.backgroundColor = UIColorWithRGBA(219.0f, 212.0f, 212.0f, 1.0f);
    
    _locationIcon.image = [UIImage imageNamed:@"HP-LocationOfflineIcon"];
    
    UIColor *textColor = [UIColor lightGrayColor];
    _locationLabel.textColor = textColor;
    _promptLabel.textColor = textColor;
    
    UIColor *titleColor = UIColorWithRGBA(84.0f, 71.0f, 71.0f, 1.0f);
    _orderTitleLabel.textColor = titleColor;
    _subTitleLabel.textColor = titleColor;
    
    _cylindrical.image = [UIImage imageNamed:@"HP-CylindricalOfflineIcon"];
    _innerCircle.image = [UIImage imageNamed:@"HP-InnerCircleOFFlineIcon"];
    
    _grabButton.enabled = NO;
    _grabButton.backgroundColor = UIColorWithRGBA(205.0f, 199.0f, 199.0f, 1.0f);
    _grabButton.layer.borderColor = _grabButton.backgroundColor.CGColor;
}

- (void)showOrderAlertWithOrder:(HXGrabOrder *)order {
    [HXOrderAlertView showWithNewOrder:order hanlde:^(HXGrabOrder *newOrder) {
        NSLog(@"handle");
    }];
}

@end
