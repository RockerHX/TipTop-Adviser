//
//  HXStoryBoardManager.m
//  MaintenanceCar
//
//  Created by ShiCang on 15/7/13.
//  Copyright (c) 2015年 MaintenanceCar. All rights reserved.
//

#import "HXStoryBoardManager.h"

@implementation HXStoryBoardManager

+ (id)navigaitonControllerWithIdentifier:(NSString *)identifier storyBoardName:(SCStoryBoardName)name
{
    id controller = [self viewControllerWithIdentifier:identifier storyBoardName:name];
    return [controller isKindOfClass:[UINavigationController class]] ? controller : nil;
}

+ (id)viewControllerWithClass:(Class)class storyBoardName:(SCStoryBoardName)name
{
    NSString *identifier = NSStringFromClass([class class]);
    id controller = [self viewControllerWithIdentifier:identifier storyBoardName:name];
    return [controller isKindOfClass:[UIViewController class]] ? controller : nil;
}

#pragma mark - Private Methods
+ (NSString *)storyBoardName:(SCStoryBoardName)name
{
    NSString *storyBoardName = nil;
    switch (name)
    {
        case SCStoryBoardNameLogin:
            storyBoardName = @"Login";
            break;
        case SCStoryBoardNameHome:
            storyBoardName = @"Login";
            break;
        case SCStoryBoardNameUser:
            storyBoardName = @"Login";
            break;
    }
    return storyBoardName;
}

+ (id)viewControllerWithIdentifier:(NSString *)identifier storyBoardName:(SCStoryBoardName)name
{
    @try {
        NSString *storyBoardName = [self storyBoardName:name];
        return [[UIStoryboard storyboardWithName:storyBoardName bundle:nil] instantiateViewControllerWithIdentifier:identifier];
    }
    @catch (NSException *exception) {
        NSLog(@"Load View Controller From StoryBoard Error:%@", exception.reason);
    }
    @finally {
    }
}

@end
