//
//  HXGrabOrder.m
//  TipTop-Adviser
//
//  Created by ShiCang on 15/12/7.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXGrabOrder.h"

@implementation HXGrabOrder

#pragma mark - Class Methods
+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"displayID": @"display_id",
            @"clientName": @"client_name",
          @"clientMobile": @"client_mobile",
            @"createDate": @"create_time"};
}

@end
