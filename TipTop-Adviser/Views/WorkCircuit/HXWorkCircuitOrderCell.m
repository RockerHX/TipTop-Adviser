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

#pragma mark - Init Methods
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initConfig];
    [self viewConfig];
}

#pragma mark - Config Methods
- (void)initConfig {
    
}

- (void)viewConfig {
    _header.layer.cornerRadius = _header.frame.size.height/2;
}

#pragma mark - Event Response
- (void)phoneButonPressed {
    if (_delegate && [_delegate respondsToSelector:@selector(orderCell:shouldCallPhone:)]) {
        [_delegate orderCell:self shouldCallPhone:_order.clientMobile];
    }
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
