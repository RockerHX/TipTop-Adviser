//
//  HXStoryBoardManager.m
//  MaintenanceCar
//
//  Created by ShiCang on 15/7/13.
//  Copyright (c) 2015年 MaintenanceCar. All rights reserved.
//

#import "HXStoryBoardManager.h"

@implementation HXStoryBoardManager

+ (id)navigaitonControllerWithIdentifier:(NSString *)identifier storyBoardName:(HXStoryBoardName)name {
    id controller = [self viewControllerWithIdentifier:identifier storyBoardName:name];
    return [controller isKindOfClass:[UINavigationController class]] ? controller : nil;
}

+ (id)viewControllerWithClass:(Class)class storyBoardName:(HXStoryBoardName)name {
    NSString *identifier = NSStringFromClass([class class]);
    id controller = [self viewControllerWithIdentifier:identifier storyBoardName:name];
    return [controller isKindOfClass:[UIViewController class]] ? controller : nil;
}

#pragma mark - Private Methods
+ (NSString *)storyBoardName:(HXStoryBoardName)name {
    NSString *storyBoardName = nil;
    switch (name) {
        case HXStoryBoardNameLogin: {
            storyBoardName = @"Login";
            break;
        }
        case HXStoryBoardNameHome: {
            storyBoardName = @"Home";
            break;
        }
        case HXStoryBoardNameUser: {
            storyBoardName = @"User";
            break;
        }
        case HXStoryBoardNameSetting: {
            storyBoardName = @"Setting";
            break;
        }
        case HXStoryBoardNameMyReservation:{
            storyBoardName = @"MyReservation";
            break;
        }
        case HXStoryBoardNameOnlinePay: {
            storyBoardName = @"OnlinePay";
            break;
        }
        case HXStoryBoardNameWorkCircuit: {
            storyBoardName = @"WorkCircuit";
            break;
        }
        case HXStoryBoardNameMyBidding: {
            storyBoardName = @"MyBidding";
            break;
        }
        case HXStoryBoardNameMyService: {
            storyBoardName = @"MyService";
            break;
        }
        case HXStoryBoardNameMessageCenter: {
            storyBoardName = @"MessageCenter";
            break;
        }
        case HXStoryBoardNameMyComment: {
            storyBoardName = @"MyComment";
            break;
        }
        case HXStoryBoardNameMyAddress: {
            storyBoardName = @"MyAddress";
            break;
        }
    }
    return storyBoardName;
}

+ (UIViewController *)viewControllerWithIdentifier:(NSString *)identifier storyBoardName:(HXStoryBoardName)name {
    UIViewController *viewController = nil;
    @try {
        NSString *storyBoardName = [self storyBoardName:name];
        viewController = [[UIStoryboard storyboardWithName:storyBoardName bundle:nil] instantiateViewControllerWithIdentifier:identifier];
    }
    @catch (NSException *exception) {
        NSLog(@"Load View Controller From StoryBoard Error:%@", exception.reason);
    }
    @finally {
        return viewController;
    }
}

@end
