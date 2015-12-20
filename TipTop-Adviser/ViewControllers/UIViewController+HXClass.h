//
//  UIViewController+HXClass.h
//  TipTop-Adviser
//
//  Created by ShiCang on 15/10/18.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXStoryBoardManager.h"
#import "HXUserSession.h"

@interface UIViewController (HXClass)

@property (nonatomic, copy, readonly)           NSString *navigationControllerIdentifier;
@property (nonatomic, assign, readonly) HXStoryBoardName  storyBoardName;

+ (UINavigationController *)navigationControllerInstance;
+ (instancetype)instance;

- (void)showAlertWithMessage:(NSString *)message;
- (void)showAlertWithMessage:(NSString *)message handler:(void (^)(UIAlertView *alertView, NSInteger buttonIndex))block;
- (void)showAlertWithMessage:(NSString *)message otherTitle:(NSString *)title handler:(void (^)(UIAlertView *alertView, NSInteger buttonIndex))block;

@end
