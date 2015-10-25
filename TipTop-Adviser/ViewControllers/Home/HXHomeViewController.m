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

typedef NS_ENUM(NSUInteger, HXHomePageConnectState) {
    HXHomePageConnectStateOnline,
    HXHomePageConnectStateOffline,
};

@interface HXHomeViewController ()
@end

@implementation HXHomeViewController

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initConfig];
    [self viewConfig];
}

#pragma mark - Config Methods
- (void)initConfig {
    
    [self socketConfig];
}

- (void)viewConfig {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)socketConfig {
    __weak __typeof__(self)weakSelf = self;
    [[HXSocketManager manager] openWithURL:[NSURL URLWithString:@"ws://115.29.45.120:8081"] opened:^(HXSocketManager *manager) {
        __strong __typeof__(self)strongSelf = weakSelf;
        [MBProgressHUD hideHUDForView:strongSelf.view animated:YES];
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
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (IBAction)cylindricalTaped {
    if ([HXSocketManager manager].socket.readyState == SR_CLOSED) {
        
    }
}

#pragma mark - Private Methods
- (void)handleData:(NSString *)data {
    NSData *jsonData = [data dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *receiveData = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
    NSLog(@"%@", receiveData);
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
    self.view.backgroundColor = UIColorWithRGBA(252.0f, 139.0f, 69.0f, 1.0f);
    
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

@end
