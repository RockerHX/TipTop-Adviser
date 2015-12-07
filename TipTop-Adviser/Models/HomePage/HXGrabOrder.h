//
//  HXGrabOrder.h
//  TipTop-Adviser
//
//  Created by ShiCang on 15/12/7.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "MJExtension.h"

@interface HXGrabOrder : NSObject

@property (nonatomic, assign) NSInteger  displayID;
@property (nonatomic, assign) NSInteger  createDate;
@property (nonatomic, copy)    NSString *clientName;
@property (nonatomic, copy)    NSString *clientMobile;
@property (nonatomic, copy)    NSString *cate;
@property (nonatomic, copy)    NSString *address;

@end
