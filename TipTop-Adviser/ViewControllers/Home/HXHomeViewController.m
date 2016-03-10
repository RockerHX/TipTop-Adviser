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
#import <BaiduMapAPI_Search/BMKGeocodeSearch.h>
#import "HXLocationManager.h"
#import "UIImageView+WebCache.h"
#import "REFrostedViewController.h"

typedef NS_ENUM(NSUInteger, HXHomePageConnectState) {
    HXHomePageConnectStateOnline,
    HXHomePageConnectStateOffline,
};

static NSString *NewOrderEvent = @"new_order";

@interface HXHomeViewController () <BMKGeoCodeSearchDelegate>
@end

@implementation HXHomeViewController {
    HXNewOrder *_newOrder;
    CGFloat _angle;
    NSTimer *_timer;
}

#pragma mark - View Controller Life Cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initConfig];
    [self viewConfig];
}

- (void)dealloc {
    [self invaliDateTimer];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
}

#pragma mark - Setter And Getter
- (NSString *)navigationControllerIdentifier {
    return @"HXHomeNavigationController";
}

- (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameHome;
}

#pragma mark - Config Methods
- (void)initConfig {
    [_adviserHeader addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self.frostedViewController action:@selector(presentMenuViewController)]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openSocket) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)viewConfig {
    _orderTitleLabel.text = @"暂无需求";
    _subTitleLabel.text = @"等待发单";
    
    [self displayHomePage];
}

- (void)openSocket {
    HXSocketManager *manager = [HXSocketManager manager];
    if (manager.socket.readyState != SR_OPEN) {
        [self showHUD];
        [manager openWithURL:[NSURL URLWithString:@"ws://115.29.45.120:8081"] opened:^(HXSocketManager *manager) {
            [self hiddenHUD];
            [self loginAction];
            [self displayWithConnectSatae:HXHomePageConnectStateOnline];
        } receiveData:^(HXSocketManager *manager, id data) {
            [self hiddenHUD];
            [self handleData:data];
        } closed:^(HXSocketManager *manager, NSInteger code) {
            [self hiddenHUD];
            [self displayWithConnectSatae:HXHomePageConnectStateOffline];
        } failed:^(HXSocketManager *manager, NSError *error) {
            [self hiddenHUD];
            [self displayWithConnectSatae:HXHomePageConnectStateOffline];
        }];
    }
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
- (void)showHUD {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)hiddenHUD {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)displayHomePage {
    [_adviserHeader sd_setImageWithURL:[NSURL URLWithString:[HXUserSession share].adviser.avatar] placeholderImage:[UIImage imageNamed:@"HP-AvatarDefaultIcon"]];
    [self displayUserLocation];
}

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
    BOOL error = [receiveData[@"error"] boolValue];
    if (!error) {
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
        [self showAlertWithMessage:message];
        [self resetUI];
    }
}

- (void)displayWithNewOrder:(HXNewOrder *)newOrder {
    _orderTitleLabel.text = newOrder.cate;
    _subTitleLabel.text = newOrder.subCate;
    _promptLabel.text = @"收到 1 个需求";
}

- (void)resetUI {
    _orderTitleLabel.text = @"暂无订单";
    _subTitleLabel.text = @"等待发单";
    _promptLabel.text = @"收到 0 个需求";
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
    
    [self startTimer];
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
    
    [self invaliDateTimer];
    
    [self openSocket];
}


- (void)startTimer {
    [_timer invalidate];
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.01f target:self selector:@selector(startCylindricalAnmation) userInfo:nil repeats:YES];
}

- (void)invaliDateTimer {
    [_timer invalidate];
}

- (void)startCylindricalAnmation {
    _angle += 0.05;
    if (_angle > 6.283) {
        _angle = 0;
    }
    [UIView animateWithDuration:0.5f animations:^{
        _cylindrical.transform = CGAffineTransformMakeRotation(_angle);
    }];
}

- (void)stopCylindricalAnmation {
    [self invaliDateTimer];
    [UIView animateWithDuration:1.0f animations:^{
        _cylindrical.transform = CGAffineTransformIdentity;
    }];
}

- (void)showOrderAlertWithOrder:(HXGrabOrder *)order {
    [HXOrderAlertView showWithNewOrder:order hanlde:^(HXGrabOrder *newOrder) {
        
        [self resetUI];
    }];
}

- (void)displayUserLocation {
    __weak __typeof__(self)weakSelf = self;
    [[HXLocationManager share] getLocationSuccess:^(BMKUserLocation *userLocation, NSString *latitude, NSString *longitude) {
        __strong __typeof__(self)self = weakSelf;
        [self getStartAddressWithLocation:userLocation.location];
    } failure:^(NSString *latitude, NSString *longitude, NSError *error) {
    }];
}

- (void)getStartAddressWithLocation:(CLLocation *)location {
    BMKReverseGeoCodeOption *option = [[BMKReverseGeoCodeOption alloc] init];
    option.reverseGeoPoint = location.coordinate;
    BMKGeoCodeSearch *search = [[BMKGeoCodeSearch alloc] init];
    search.delegate = self;
    [search reverseGeoCode:option];
}

#pragma mark - BMKGeoCodeSearchDelegate Methods
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
    _locationLabel.text = result.address;
}

@end
