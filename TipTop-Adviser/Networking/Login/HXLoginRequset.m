//
//  HXLoginRequset.m
//  TipTop-Consultant
//
//  Created by ShiCang on 15/10/7.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXLoginRequset.h"

static NSString *LoginAPI = @"/session/login";

@implementation HXAdviser (HXLoginRequset)

+ (AFHTTPRequestOperation *)loginWithParameters:(NSDictionary *)parameters
                                        success:(void(^)(HXApiResponse *response, HXAdviser *adviser))success
                                        failure:(void(^)(HXApiResponse *response))failure
{
    return [HXAppApiRequest requestPOSTMethodsWithAPI:[HXApi apiURLWithApi:LoginAPI] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger statusCode = operation.response.statusCode;
        NSInteger errorCode = [responseObject[@"code"] integerValue];
        HXApiResponse *response = [HXApiResponse responseWithStatusCode:statusCode errorCode:errorCode];
        HXAdviser *adviser = [HXAdviser objectWithKeyValues:responseObject];
        if (success) {
            success(response, adviser);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSInteger statusCode = operation.response.statusCode;
        NSInteger errorCode = [operation.responseObject[@"code"] integerValue];
        HXApiResponse *response = [HXApiResponse responseWithStatusCode:statusCode errorCode:errorCode];
        if (success) {
            success(response, nil);
        }
    }];
}

@end
