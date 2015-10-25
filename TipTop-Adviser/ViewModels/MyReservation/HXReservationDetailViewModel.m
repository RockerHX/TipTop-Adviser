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
- (void)startOrderDetailReuqestWithParameters:(NSDictionary *)parameters {
    __weak __typeof__(self)weakSelf = self;
    [HXAppApiRequest requestGETMethodsWithAPI:[HXApi apiURLWithApi:OrderDetailApi] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        __strong __typeof__(self)strongSelf = weakSelf;
        NSInteger errorCode = [responseObject[@"error_code"] integerValue];
        if (HXAppApiRequestErrorCodeNoError == errorCode) {
            [strongSelf handleDetailData:responseObject[@"data"][@"order"]];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}

- (void)handleDetailData:(NSDictionary *)data {
    if (data) {
        _detail = [HXReservationDetial objectWithKeyValues:data];
        _orderDate = [[NSDate dateWithTimeIntervalSince1970:_detail.createTime] formattedDateWithFormat:@"yyyy-MM-dd hh:mm:ss"];
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

static NSInteger Row = 2;
- (NSInteger)rows {
    return (_detail ? (Row + (_detail.remarks.count ? (_detail.remarks.count + 1) : 0)) : 0);
}

- (NSArray *)types {
    NSArray *types = @[@(HXDetailCellTypeInfo),
                       @(HXDetailCellTypeClient),
                       @(HXDetailCellTypePrompt)];
    NSArray *remarks = _detail.remarks;
    if (remarks) {
        NSMutableArray *array = [NSMutableArray arrayWithArray:types];
        for (NSInteger index = 0; index < remarks.count; index ++) {
            [array addObject:@(HXDetailCellTypeRemark)];
        }
        types = [array copy];
    }
    return types;
}

@end
