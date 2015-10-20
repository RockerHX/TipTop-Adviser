//
//  HXWorkCircuitOrderCell.m
//  TipTop-Adviser
//
//  Created by ShiCang on 15/10/21.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXWorkCircuitOrderCell.h"
#import "UIImageView+WebCache.h"

@implementation HXWorkCircuitOrderCell {
    HXWorkCircuitOrder *_order;
}

#pragma mark - Event Response
- (void)phoneButonPressed {
    
}

#pragma mark - Public Methods
- (void)displayWithOrder:(HXWorkCircuitOrder *)order {
    _order = order;
    
    _dateLabel.text = [NSDate dateWithTimeIntervalSince1970:order.createTime].description;
    _orderNumberLabel.text = order.displayID;
    _orderNameLabel.text = order.cate;
    _nameLabel.text = order.clientName;
    _finishedIcon.hidden = !order.isComplete;
    [_header sd_setImageWithURL:[NSURL URLWithString:order.clientAvatar]];
}

@end
