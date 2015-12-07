//
//  HXOrderAlertCell.m
//  TipTop-Adviser
//
//  Created by ShiCang on 15/10/25.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXOrderAlertCell.h"
#import "HXThemeManager.h"
#import "HXGrabOrder.h"
#import "DateTools.h"
#import "UIConstants.h"

typedef NS_ENUM(NSUInteger, HXGrabOrderRow) {
    HXGrabOrderRowSeriveName,
    HXGrabOrderRowOrderNumber,
    HXGrabOrderRowOrderDate,
    HXGrabOrderRowClientName,
    HXGrabOrderRowClientPhone,
    HXGrabOrderRowServiceAddress
};

@implementation HXOrderAlertCell

#pragma mark - Load Methods
- (void)awakeFromNib {
    _contentLabel.preferredMaxLayoutWidth = SCREEN_WIDTH - 80.0f - 137.0f;
}

#pragma mark - Public Methods
- (void)displayWithNewOrder:(HXGrabOrder *)newOrder row:(NSInteger)row {
    NSString *title = nil;
    NSString *content = nil;
    UIColor *textColor = [UIColor blackColor];
    
    switch (row) {
        case HXGrabOrderRowSeriveName: {
            title = @"服务项目";
            content = newOrder.cate;
            textColor = [HXThemeManager share].themeColor;
            break;
        }
        case HXGrabOrderRowOrderNumber: {
            title = @"订 单 号";
            content = @(newOrder.displayID).stringValue;
            break;
        }
        case HXGrabOrderRowOrderDate: {
            title = @"订单时间";
            content = [[NSDate dateWithTimeIntervalSince1970:newOrder.createDate] formattedDateWithFormat:@"yyyy-MM-dd hh:mm"];
            break;
        }
        case HXGrabOrderRowClientName: {
            title = @"客户姓名";
            content = newOrder.clientName;
            break;
        }
        case HXGrabOrderRowClientPhone: {
            title = @"联系电话";
            content = newOrder.clientMobile;
            break;
        }
        case HXGrabOrderRowServiceAddress: {
            title = @"服务地址";
            content = newOrder.address;
            break;
        }
    }
    
    _titleLabel.text = title;
    _contentLabel.text = content;
    _contentLabel.textColor = textColor;
}

@end
