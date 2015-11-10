//
//  HXProfileViewController.m
//  TipTop-Adviser
//
//  Created by ShiCang on 15/10/20.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXProfileViewController.h"
#import "HXProfileViewModel.h"
#import "HXUserSession.h"
#import "MJRefresh.h"
#import "HXProfileHeaderCell.h"
#import "HXProfileSelectedCell.h"
#import "HXProfileIntroduceEditCell.h"
#import "HXProfileIntroduceNullCell.h"
#import "HXProfileIntroduceCell.h"
#import "UITableView+FDTemplateLayoutCell.h"

@interface HXProfileViewController ()
@end

@implementation HXProfileViewController {
    HXProfileViewModel *_viewModel;
    HXProfileSelectType _selectType;
}

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
    
    [self initConfig];
    [self viewConfig];
}

#pragma mark - Config Methods
- (void)initConfig {
    _viewModel = [HXProfileViewModel instanceWithToken:[HXUserSession share].adviser.accessToken];
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    [self.tableView.header beginRefreshing];
}

- (void)viewConfig {
}

#pragma mark - Setter And Getter
- (NSString *)navigationControllerIdentifier {
    return @"HXProfileNavigationController";
}

- (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameUser;
}

#pragma mark - Private Methods
- (void)loadData {
    __weak __typeof__(self)weakSelf = self;
    [_viewModel requestWithType:_selectType completed:^{
        __strong __typeof__(self)strongSelf = weakSelf;
        [strongSelf endLoad];
    }];
}

- (void)endLoad {
    [self.tableView reloadData];
    [self.tableView.header endRefreshing];
}

#pragma mark - Table View Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _viewModel.rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    HXProfileCellRow rowType = [_viewModel.rowTypes[indexPath.row] integerValue];
    switch (rowType) {
        case HXProfileCellRowHeader: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXProfileHeaderCell class]) forIndexPath:indexPath];
            [(HXProfileHeaderCell *)cell displayWithViewModel:_viewModel];
            break;
        }
        case HXProfileCellRowSelected: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXProfileSelectedCell class]) forIndexPath:indexPath];
            break;
        }
        case HXProfileCellRowIntroducEdit: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXProfileIntroduceEditCell class]) forIndexPath:indexPath];
            [(HXProfileIntroduceEditCell *)cell displayWithViewModel:_viewModel];
            break;
        }
        case HXProfileCellRowIntroduceNull: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXProfileIntroduceNullCell class]) forIndexPath:indexPath];
            break;
        }
        case HXProfileCellRowIntroduce: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXProfileIntroduceCell class]) forIndexPath:indexPath];
            [(HXProfileIntroduceCell *)cell displayWithViewModel:_viewModel];
            break;
        }
        case HXProfileCellRowCaseEdit: {
            break;
        }
        case HXProfileCellRowCase: {
            break;
        }
    }
    return cell;
}

#pragma mark - Table View Delegete Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0.0f;
    __weak __typeof__(self)weakSelf = self;
    HXProfileCellRow rowType = [_viewModel.rowTypes[indexPath.row] integerValue];
    switch (rowType) {
        case HXProfileCellRowHeader: {
            height = [tableView fd_heightForCellWithIdentifier:NSStringFromClass([HXProfileHeaderCell class]) cacheByIndexPath:indexPath configuration:^(HXProfileHeaderCell *cell) {
                __strong __typeof__(self)strongSelf = weakSelf;
                [cell displayWithViewModel:strongSelf->_viewModel];
            }];
            break;
        }
        case HXProfileCellRowSelected: {
            height = _viewModel.selectedHeight;
            break;
        }
        case HXProfileCellRowIntroducEdit: {
            height = _viewModel.editHeight;
            break;
        }
        case HXProfileCellRowIntroduceNull: {
            height = _viewModel.nullContentHeight;
            break;
        }
        case HXProfileCellRowIntroduce: {
            height = [tableView fd_heightForCellWithIdentifier:NSStringFromClass([HXProfileIntroduceCell class]) cacheByIndexPath:indexPath configuration:^(HXProfileIntroduceCell *cell) {
                __strong __typeof__(self)strongSelf = weakSelf;
                [cell displayWithViewModel:strongSelf->_viewModel];
            }];
            break;
        }
        case HXProfileCellRowCaseEdit: {
            break;
        }
        case HXProfileCellRowCase: {
            break;
        }
    }
    return height;
}

@end
