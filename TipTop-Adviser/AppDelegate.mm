//
//  AppDelegate.m
//  TipTop-Adviser
//
//  Created by ShiCang on 15/10/7.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "AppDelegate.h"
#import "HXThemeManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [HXThemeManager share].theme = HXThemeOrange;
    
    return YES;
}

@end
