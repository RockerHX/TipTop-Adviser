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
- (CGFloat)selectedHeight {
    return _profile ? 44.0f : 0.0f;
}

- (CGFloat)editHeight {
    return _profile ? 60.0f : 0.0f;
}

- (CGFloat)nullContentHeight {
    return _profile ? 240.0f : 0.0f;
}

static NSInteger RegularRow = 4;
- (NSInteger)rows {
    return (_profile ? RegularRow : 0);
}

- (NSArray *)rowTypes {
    if (_rowTypes.count < 4) {
        NSMutableArray *array = [NSMutableArray arrayWithArray:_rowTypes];
        [array addObject:_selectType ? @(HXProfileCellRowCaseEdit) : @(HXProfileCellRowIntroducEdit)];
        [array addObject:_profile.introduce ? @(HXProfileCellRowIntroduce) : @(HXProfileCellRowCase)];
        _rowTypes = [array copy];
    }
    return _rowTypes;
}

- (BOOL)hasIntroduce {
    return _profile.introduce;
}

#pragma mark - Public Methods
- (void)requestWithType:(HXProfileSelectType)type completed:(void(^)(void))completed {
    _selectType = type;
    _completedBlock = completed;
    switch (type) {
        case HXProfileSelectTypeIntroduce: {
            [self startProfileReuqestWithParameters:@{@"access_token": _token}];
            break;
        }
        case HXProfileSelectTypeCase: {
            
            break;
        }
    }
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
        _profile = [HXProfile objectWithKeyValues:data];
    }
    if (_completedBlock) {
        _completedBlock();
    }
}

@end
