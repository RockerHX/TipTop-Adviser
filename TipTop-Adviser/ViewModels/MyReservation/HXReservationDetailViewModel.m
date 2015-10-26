//
//  HXReservationDetailViewModel.m
//  TipTop-Adviser
//
//  Created by ShiCang on 15/10/25.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXReservationDetailViewModel.h"
#import "HXAppApiRequest.h"
#import "DateTools.h"

typedef void(^BLOCK)(void);

static NSString *OrderDetailApi = @"/order/view";

@implementation HXReservationDetailViewModel {
    NSArray *_rowTypes;
    BLOCK _completedBlock;
}

#pragma mark - Class Methods
+ (instancetype)instanceWithOrderID:(NSString *)orderID {
    return [[HXReservationDetailViewModel alloc] initWithOrderID:orderID];
}

#pragma mark - Init Methods
- (instancetype)initWithOrderID:(NSString *)orderID {
    self = [super init];
    if (self) {
        _orderID = [orderID copy];
        [self setupRowTypes];
    }
    return self;
}

#pragma mark - Public Methods
- (void)request:(void (^)(void))completed {
    _completedBlock = completed;
    [self startOrderDetailReuqestWithParameters:@{@"access_token": @"b487a6db8f621069fc6785b7b303f7de",
                                                            @"id": _orderID}];
}

#pragma mark - Private Methods

- (void)setupRowTypes {
    _rowTypes = @[@(HXDetailCellRowInfo),
                  @(HXDetailCellRowClient)];
}

- (void)startOrderDetailReuqestWithParameters:(NSDictionary *)parameters {
    [self setupRowTypes];
    __weak __typeof__(self)weakSelf = self;
    [HXAppApiRequest requestGETMethodsWithAPI:[HXApi apiURLWithApi:OrderDetailApi] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        __strong __typeof__(self)strongSelf = weakSelf;
        NSInteger errorCode = [responseObject[@"error_code"] integerValue];
        if (HXAppApiRequestErrorCodeNoError == errorCode) {
            [strongSelf handleDetailData:responseObject[@"data"]];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}

- (void)handleDetailData:(NSDictionary *)data {
    if (data) {
        _detail = [HXReservationDetail objectWithKeyValues:data];
        _orderDate = [[NSDate dateWithTimeIntervalSince1970:_detail.order.createTime] formattedDateWithFormat:@"yyyy-MM-dd hh:mm:ss"];
    }
    if (_completedBlock) {
        _completedBlock();
    }
}

#pragma mark - Setter And Getter
- (CGFloat)infoHeight {
    return _detail ? 80.0f : 0.0f;
}

- (CGFloat)promptHeight {
    return _detail ? 36.0f : 0.0f;
}

static NSInteger RegularRow = 2;
- (NSInteger)rows {
    return (_detail ? (RegularRow + (_detail.remarks.count ? (_detail.remarks.count + 1) : 0)) : 0);
}

- (NSInteger)regularRow {
    return RegularRow + 1;
}

- (NSArray *)rowTypes {
    NSArray *remarks = _detail.remarks;
    if (remarks.count) {
        NSMutableArray *array = [NSMutableArray arrayWithArray:_rowTypes];
        [array addObject:@(HXDetailCellRowPrompt)];
        for (NSInteger index = 0; index < remarks.count; index ++) {
            [array addObject:@(HXDetailCellRowRemark)];
        }
        _rowTypes = [array copy];
    }
    return _rowTypes;
}

@end
