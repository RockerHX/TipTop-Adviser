//
//  HXProfileViewModel.h
//  TipTop-Adviser
//
//  Created by ShiCang on 15/10/25.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXReservationDetail.h"

typedef NS_ENUM(NSUInteger, HXProfileCellRow) {
    HXProfileCellRowHeader,
    HXProfileCellRowSelected,
    HXProfileCellRowIntroducEdit,
    HXProfileCellRowIntroduceNull,
    HXProfileCellRowIntroduce
};

typedef NS_ENUM(NSUInteger, HXProfileSelectType) {
    HXProfileSelectTypeIntroduce,
    HXProfileSelectTypeCase
};


@interface HXProfileViewModel : NSObject

@property (nonatomic, assign, readonly)   CGFloat  headerHeight;
@property (nonatomic, assign, readonly)   CGFloat  selectedHeight;
@property (nonatomic, assign, readonly)   CGFloat  editHeight;
@property (nonatomic, assign, readonly)   CGFloat  nullContentHeight;
@property (nonatomic, assign, readonly) NSInteger  rows;

@property (nonatomic, strong, readonly)   NSArray *rowTypes;

@property (nonatomic, strong, readonly) HXReservationDetail *detail;

+ (instancetype)instanceWithToken:(NSString *)token;
- (instancetype)initWithToken:(NSString *)token;

- (void)requestWithType:(HXProfileSelectType)type completed:(void(^)(void))completed;

@end
