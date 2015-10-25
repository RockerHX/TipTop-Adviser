//
//  HXReservationDetailViewModel.h
//  TipTop-Adviser
//
//  Created by ShiCang on 15/10/25.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXReservationDetial.h"

typedef NS_ENUM(NSUInteger, HXDetailCellType) {
    HXDetailCellTypeInfo,
    HXDetailCellTypeClient,
    HXDetailCellTypePrompt,
    HXDetailCellTypeRemark
};


@interface HXReservationDetailViewModel : NSObject

@property (nonatomic, assign, readonly)   CGFloat  infoHeight;
@property (nonatomic, assign, readonly)   CGFloat  promptHeight;
@property (nonatomic, assign, readonly) NSInteger  rows;
@property (nonatomic, copy, readonly)    NSString *orderID;

@property (nonatomic, strong, readonly)   NSArray *types;

@property (nonatomic, strong, readonly) HXReservationDetial *detail;
@property (nonatomic, copy, readonly)              NSString *orderDate;

+ (instancetype)instanceWithOrderID:(NSString *)orderID;
- (instancetype)initWithOrderID:(NSString *)orderID;

- (void)request:(void(^)(void))completed;

@end
