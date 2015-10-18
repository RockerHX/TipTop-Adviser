//
//  HXSettingViewController.m
//  TipTop-Adviser
//
//  Created by ShiCang on 15/10/13.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXSettingViewController.h"

@interface HXSettingViewController ()

@end

@implementation HXSettingViewController

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Setter And Getter
- (NSString *)navigationControllerIdentifier {
    return @"HXSettingNavigationController";
}

- (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameSetting;
}

#pragma mark - Table View Data Source Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
