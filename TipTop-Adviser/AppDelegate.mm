//
//  AppDelegate.m
//  TipTop-Adviser
//
//  Created by ShiCang on 15/10/7.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "AppDelegate.h"
#import "HXThemeManager.h"
#import <BaiduMapAPI_Base/BMKMapManager.h>
#import <BaiduMapAPI_Map/BMKMapView.h>
#import "HXAppConstants.h"

@interface AppDelegate ()
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [HXThemeManager share].theme = HXThemeOrange;
    
    
#pragma mark - Baidu Map SDK
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc] init];
    // 如果要关注网络及授权验证事件，请设定generalDelegate参数
    BOOL ret = [_mapManager start:BaiDuMapKEY generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    return YES;
}

@end
