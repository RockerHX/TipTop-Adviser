//
//  HXUserSession.h
//  TipTop-Adviser
//
//  Created by ShiCang on 15/11/2.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXAdviser.h"

@interface HXUserSession : NSObject

@property (nonnull, nonatomic, strong) HXAdviser *adviser;

+ (nullable instancetype)share;

@end
