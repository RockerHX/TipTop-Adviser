//
//  HXProfileViewModel.m
//  TipTop-Adviser
//
//  Created by ShiCang on 15/10/25.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXProfileViewModel.h"
#import "HXAppApiRequest.h"
#import "DateTools.h"
#import "HXUserSession.h"

typedef void(^BLOCK)(void);

static NSString *ProfileApi = @"/profile";

@implementation HXProfileViewModel {
    NSString *_token;
    BLOCK _completedBlock;
    
    NSArray *_rowTypes;
}

#pragma mark - Class Methods
+ (instancetype)instanceWithToken:(NSString *)token {
    return [[HXProfileViewModel alloc] initWithToken:token];
}

#pragma mark - Init Methods
- (instancetype)initWithToken:(NSString *)token {
    self = [super init];
    if (self) {
        _token = [token copy];
        [self setupRowTypes];
    }
    return self;
}

#pragma mark - Setter And Getter
- (CGFloat)headerHeight {
    return _detail ? 110.0 : 0.0f;
}

- (CGFloat)selectedHeight {
    return _detail ? 44.0f : 0.0f;
}

- (CGFloat)editHeight {
    return _detail ? 60.0f : 0.0f;
}

- (CGFloat)nullContentHeight {
    return _detail ? 240.0f : 0.0f;
}

static NSInteger RegularRow = 2;
- (NSInteger)rows {
    return (_detail ? RegularRow : 0);
}

- (NSArray *)rowTypes {
//    if (remarks.count) {
//        NSMutableArray *array = [NSMutableArray arrayWithArray:_rowTypes];
//        [array addObject:@(HXDetailCellRowPrompt)];
//        for (NSInteger index = 0; index < remarks.count; index ++) {
//            [array addObject:@(HXDetailCellRowRemark)];
//        }
//        _rowTypes = [array copy];
//    }
    return _rowTypes;
}

#pragma mark - Public Methods
- (void)requestWithType:(HXProfileSelectType)type completed:(void(^)(void))completed {
    _completedBlock = completed;
    [self startProfileReuqestWithParameters:@{@"access_token": _token}];
}

#pragma mark - Private Methods
- (void)setupRowTypes {
    _rowTypes = @[@(HXProfileCellRowHeader),
                  @(HXProfileCellRowSelected)];
}

- (void)startProfileReuqestWithParameters:(NSDictionary *)parameters {
    [self setupRowTypes];
    __weak __typeof__(self)weakSelf = self;
    [HXAppApiRequest requestGETMethodsWithAPI:[HXApi apiURLWithApi:ProfileApi] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        __strong __typeof__(self)strongSelf = weakSelf;
        NSInteger errorCode = [responseObject[@"error_code"] integerValue];
        if (HXAppApiRequestErrorCodeNoError == errorCode) {
            [strongSelf handleProfileData:responseObject[@"data"]];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}

- (void)handleProfileData:(NSDictionary *)data {
    if (data) {
        _detail = [HXReservationDetail objectWithKeyValues:data];
    }
    if (_completedBlock) {
        _completedBlock();
    }
}

@end
