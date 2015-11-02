//
//  HXUserSession.m
//  TipTop-Adviser
//
//  Created by ShiCang on 15/11/2.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXUserSession.h"


static NSString *FilePath = @"/adviser.data";

static HXUserSession *session = nil;

@implementation HXUserSession

#pragma mark - Class Methods
+ (nullable instancetype)share {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        session = [[HXUserSession alloc] init];
    });
    return session;
}

#pragma mark - Init Methods
- (instancetype)init {
    self = [super init];
    if (self) {
        [self unArchive];
    }
    return self;
}

#pragma mark - Setter And Getter
- (HXUserSessionState)state {
    if (_adviser.uid && _adviser.accessToken) {
        NSDate *expired = [NSDate dateWithTimeIntervalSince1970:_adviser.tokenExpired];
        NSDate *now = [NSDate date];
        NSTimeInterval interval = [now timeIntervalSinceDate:expired];
        if (interval > 0) {
            return HXUserSessionStateLogout;
        } else {
            return HXUserSessionStateLogin;
        }
    } else {
        return HXUserSessionStateLogout;
    }
}

#pragma mark - Public Methods
- (void)updateAdviser:(nullable HXAdviser *)adviser {
    _adviser = adviser;
    [self archive];
}

#pragma mark - Private Methods
- (void)archive {
    NSString *file = [NSHomeDirectory() stringByAppendingPathComponent:FilePath];
    [NSKeyedArchiver archiveRootObject:_adviser toFile:file];
}

- (void)unArchive {
    NSString *file = [NSHomeDirectory() stringByAppendingPathComponent:FilePath];
//    _adviser = [NSKeyedUnarchiver unarchiveObjectWithFile:file];
}

@end
