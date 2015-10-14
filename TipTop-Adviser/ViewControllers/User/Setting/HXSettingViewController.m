//
//  HXSettingViewController.m
//  TipTop-Adviser
//
//  Created by ShiCang on 15/10/13.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXSettingViewController.h"
#import "HXStoryBoardManager.h"

@interface HXSettingViewController ()

@end

@implementation HXSettingViewController

#pragma mark - Instance Methods
+ (UINavigationController *)navigationControllerInstance {
    return [HXStoryBoardManager navigaitonControllerWithIdentifier:@"HXSettingNavigationController" storyBoardName:HXStoryBoardNameSetting];
}

+ (instancetype)instance {
    return [HXStoryBoardManager viewControllerWithClass:[HXSettingViewController class] storyBoardName:HXStoryBoardNameSetting];
}

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Table View Data Source Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
