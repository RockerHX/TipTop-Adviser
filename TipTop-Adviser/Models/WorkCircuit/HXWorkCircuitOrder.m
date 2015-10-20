//
//  HXWorkCircuitOrder.m
//  TipTop-Adviser
//
//  Created by ShiCang on 15/10/21.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXWorkCircuitOrder.h"

@implementation HXWorkCircuitOrder

+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"ID": @"id",
      @"displayID": @"display_id",
        @"subCate": @"sub_cate",
     @"clientName": @"client_name",
   @"clientAvatar": @"client_avatar",
     @"isComplete": @"is_complete",
   @"completeTime": @"complete_time",
     @"createTime": @"create_time"};
}

@end