//
//  UIViewController+HXClass.m
//  TipTop-Adviser
//
//  Created by ShiCang on 15/10/18.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "UIViewController+HXClass.h"
#import "UIAlertView+BlocksKit.h"

@implementation UIViewController (HXClass)

@dynamic navigationControllerIdentifier;
@dynamic storyBoardName;

#pragma  mark - Class Methods
+ (UINavigationController *)navigationControllerInstance {
    @try {
        UIViewController *viewController = [self new];
        return [HXStoryBoardManager navigaitonControllerWithIdentifier:viewController.navigationControllerIdentifier storyBoardName:viewController.storyBoardName];
    }
    @catch (NSException *exception) {
        NSLog(@"Load View Controller Instance From Storybard Error:%@", exception.reason);
    }
    @finally {
    }
}

+ (instancetype)instance {
    @try {
        UIViewController *viewController = [self new];
        return [HXStoryBoardManager viewControllerWithClass:[self class] storyBoardName:viewController.storyBoardName];
    }
    @catch (NSException *exception) {
        NSLog(@"Load View Controller Instance From Storybard Error:%@", exception.reason);
    }
    @finally {
    }
}

#pragma mark - Public Methods
- (void)showAlertWithMessage:(NSString *)message {
    if (message.length) {
        [self showAlertWithMessage:message handler:nil];
    }
}

- (void)showAlertWithMessage:(NSString *)message handler:(void (^)(UIAlertView *alertView, NSInteger buttonIndex))block {
    [self showAlertWithMessage:message otherTitle:nil handler:block];
}

- (void)showAlertWithMessage:(NSString *)message otherTitle:(NSString *)title handler:(void (^)(UIAlertView *alertView, NSInteger buttonIndex))block {
    [UIAlertView bk_showAlertViewWithTitle:@"温馨提示"
                                   message:message
                         cancelButtonTitle:@"确定"
                         otherButtonTitles:(title ? @[title] : nil)
                                   handler:block];
}

@end
