//
//  HXAdviser.m
//  TipTop-Consultant
//
//  Created by ShiCang on 15/10/7.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXAdviser.h"

@implementation HXAdviser

+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"uid": @"id",
        @"realName": @"real_name",
     @"accessToken": @"access_token",
    @"tokenExpired": @"token_expired"};
}

@end
