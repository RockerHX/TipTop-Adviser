//
//  HXMyAddressViewController.m
//  TipTop-Adviser
//
//  Created by ShiCang on 15/10/19.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXMyAddressViewController.h"
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <BaiduMapAPI_Search/BMKGeocodeSearch.h>
#import <REFrostedViewController/REFrostedViewController.h>
#import "HXLocationManager.h"

@interface HXMyAddressViewController () <BMKMapViewDelegate, BMKGeoCodeSearchDelegate>
@end

@implementation HXMyAddressViewController {
    NSTimer *_timer;
}

#pragma mark - View Controller Life Cycle
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    [_timer invalidate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initConfig];
    [self viewConfig];
}

#pragma mark - Config Methods
- (void)initConfig {
    [self displayUserLocation];
    _timer = [NSTimer scheduledTimerWithTimeInterval:30.0f target:self selector:@selector(displayUserLocation) userInfo:nil repeats:YES];
}

- (void)viewConfig {
    [self configMap];
}

- (void)configMap {
    // 配置百度地图
    _mapView.buildingsEnabled  = YES;                       // 允许双指上下滑动展示3D建筑
    _mapView.showsUserLocation = YES;                       // 显示定位图层
    _mapView.userTrackingMode  = BMKUserTrackingModeFollow; // 定位跟随模式
    _mapView.zoomLevel         = 18.0f;                     // 50米比例尺
}

#pragma mark - Event Response
- (IBAction)menuButtonPressed {
    [self.frostedViewController presentMenuViewController];
}

#pragma mark - Setter And Getter
- (NSString *)navigationControllerIdentifier {
    return @"HXMyAddressNavigationController";
}

- (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameMyAddress;
}

#pragma mark - Private Methods
- (void)displayUserLocation {
    __weak __typeof__(self)weakSelf = self;
    [[HXLocationManager share] getLocationSuccess:^(BMKUserLocation *userLocation, NSString *latitude, NSString *longitude) {
        __strong __typeof__(self)strongSelf = weakSelf;
        [strongSelf->_mapView updateLocationData:userLocation];     // 根据坐标在地图上显示位置
        [strongSelf getStartAddressWithLocation:userLocation.location];
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
    _addressLabel.text = result.address;
}

@end
