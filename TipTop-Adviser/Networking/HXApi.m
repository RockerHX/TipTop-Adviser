//
//  HXApi.m
//  MaintenanceCar
//
//  Created by Andy Shaw on 15/8/11.
//  Copyright (c) 2015年 MaintenanceCar. All rights reserved.
//

#import "HXApi.h"


#pragma mark - Api Domain
//NSString *const DoMain      = @"http://";
NSString *const DoMain      = @"http://115.29.45.120:8080";
NSString *const ImageDoMain = @"http://";

#pragma mark - Api Path
NSString *const V1ApiPath   = @"/yl_dgg/agentApi";
NSString *const V2ApiPath   = @"";
NSString *const ImagePath   = @"";


@implementation HXApi

+ (NSString *)apiURLWithApi:(NSString *)api {
    return [self V1ApiURLWithApi:api];
}

+ (NSString *)V1ApiURLWithApi:(NSString *)Api {
    return [[DoMain stringByAppendingString:V1ApiPath] stringByAppendingString:Api];
}

+ (NSString *)V2ApiURLWithApi:(NSString *)Api {
    return [[DoMain stringByAppendingString:V2ApiPath] stringByAppendingString:Api];
}

+ (NSString *)imageURLWithImageName:(NSString *)imageName {
    return [[ImageDoMain stringByAppendingString:ImagePath] stringByAppendingString:imageName];
}

@end


@implementation HXApiResponse

+ (instancetype)responseWithStatusCode:(NSInteger)statusCode errorCode:(NSInteger)errorCode {
    HXApiResponse *response = [[HXApiResponse alloc] init];
    response.statusCode = statusCode;
    response.errorCode = errorCode;
    return response;
}

@end
