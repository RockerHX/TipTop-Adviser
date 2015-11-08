//
//  HXMessage.m
//  TipTop-Adviser
//
//  Created by ShiCang on 15/11/9.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXMessageList.h"

@implementation HXMessageList

+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"ID": @"id",
        @"content": @"description",
     @"createDate": @"create_time"};
}

@end
