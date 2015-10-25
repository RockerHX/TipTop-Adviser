//
//  HXReservationDetailViewController.m
//  TipTop-Adviser
//
//  Created by ShiCang on 15/10/25.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXReservationDetailViewController.h"
#import "HXReservationDetailViewModel.h"
#import "HXReservationDetailInfoCell.h"
#import "HXReservationDetailClientCell.h"
#import "HXReservationDetailPromptCell.h"
#import "HXReservationDetailRemarkCell.h"
#import "MJRefresh.h"


@interface HXReservationDetailViewController ()
@end

@implementation HXReservationDetailViewController {
    HXReservationDetailViewModel *_viewModel;
}

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initConfig];
    [self viewConfig];
}

#pragma mark - Config Methods
- (void)initConfig {
    _viewModel = [HXReservationDetailViewModel instanceWithOrderID:_orderID];
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    [self.tableView.header beginRefreshing];
}

- (void)viewConfig {
    
}

#pragma mark - Event Response
- (IBAction)remarkButtonPressed {
    ;
}

- (IBAction)phoneButonPressed {
    ;
}

- (IBAction)sendButonPressed {
    ;
}

#pragma mark - Setter And Getter
- (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameMyReservation;
}

#pragma mark - Private Methods
- (void)loadData {
    __weak __typeof__(self)weakSelf = self;
    [_viewModel request:^{
        __strong __typeof__(self)strongSelf = weakSelf;
        [strongSelf endLoad];
    }];
}

- (void)endLoad {
    [self.tableView reloadData];
    [self.tableView.header endRefreshing];
    [self updateRemarkTapedVew];
}

- (void)updateRemarkTapedVew {
    _remarkTapedView.hidden = !_viewModel.detail.remarks.count;
}

#pragma mark - Table View Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _viewModel.rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    HXDetailCellType type = [_viewModel.types[indexPath.row] integerValue];
    switch (type) {
        case HXDetailCellTypeInfo: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXReservationDetailInfoCell class]) forIndexPath:indexPath];
            [(HXReservationDetailInfoCell *)cell displayWithDetailViewModel:_viewModel];
            break;
        }
        case HXDetailCellTypeClient: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXReservationDetailClientCell class]) forIndexPath:indexPath];
            [(HXReservationDetailClientCell *)cell displayWithDetailViewModel:_viewModel];
            break;
        }
        case HXDetailCellTypePrompt: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXReservationDetailPromptCell class]) forIndexPath:indexPath];
            break;
        }
        case HXDetailCellTypeRemark: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXReservationDetailRemarkCell class]) forIndexPath:indexPath];
            [(HXReservationDetailRemarkCell *)cell displayWithDetailViewModel:_viewModel];
            break;
        }
    }
    return cell;
}

#pragma mark - Table View Delegete Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0.0f;
    HXDetailCellType type = [_viewModel.types[indexPath.row] integerValue];
    switch (type) {
        case HXDetailCellTypeInfo: {
            height = _viewModel.infoHeight;
            break;
        }
        case HXDetailCellTypeClient: {
            height = [tableView fd_heightForCellWithIdentifier:NSStringFromClass([HXReservationDetailClientCell class])
                                              cacheByIndexPath:indexPath
                                                 configuration:
                      ^(HXReservationDetailClientCell *cell) {
                          [(HXReservationDetailClientCell *)cell displayWithDetailViewModel:_viewModel];
                      }];
            break;
        }
        case HXDetailCellTypePrompt: {
            height = _viewModel.promptHeight;
            break;
        }
        case HXDetailCellTypeRemark: {
            height = 100;
            break;
        }
    }
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

@end
