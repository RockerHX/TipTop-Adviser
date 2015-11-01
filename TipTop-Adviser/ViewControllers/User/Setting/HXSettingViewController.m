//
//  HXSettingViewController.m
//  TipTop-Adviser
//
//  Created by ShiCang on 15/10/13.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXSettingViewController.h"
#import "HXWebViewController.h"
#import "HXApi.h"
#import "HXUseExplanationViewController.h"
#import "HXAboutViewController.h"

@interface HXSettingViewController ()
@end

@implementation HXSettingViewController

#pragma mark - View Controller Life Cycle
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.canPan = YES;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.navigationController.canPan = NO;
}

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
    if ((1 == indexPath.section) && (1 == indexPath.row)) {
        HXUseExplanationViewController *useExplanationViewController = [HXUseExplanationViewController instance];
        useExplanationViewController.loadURL = [DoMain stringByAppendingString:@"/h5/page?key=agent_help"];
        [self.navigationController pushViewController:useExplanationViewController animated:YES];
    } else if ((2 == indexPath.section) && (1 == indexPath.row)) {
        HXAboutViewController *useExplanationViewController = [HXAboutViewController instance];
        useExplanationViewController.loadURL = [DoMain stringByAppendingString:@"/h5/page?key=agent_about"];
        [self.navigationController pushViewController:useExplanationViewController animated:YES];
    }
}

@end
