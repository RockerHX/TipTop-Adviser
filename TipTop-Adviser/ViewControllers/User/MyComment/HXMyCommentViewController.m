//
//  HXMyCommentViewController.m
//  TipTop-Adviser
//
//  Created by ShiCang on 15/10/19.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXMyCommentViewController.h"

@implementation HXMyCommentViewController

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Setter And Getter
- (NSString *)navigationControllerIdentifier {
    return @"HXMyCommentNavigationController";
}

- (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameMyComment;
}

#pragma mark - Table View Data Source Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
