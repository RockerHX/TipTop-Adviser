//
//  HXReservationDetailClientCell.m
//  TipTop-Adviser
//
//  Created by ShiCang on 15/10/25.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXReservationDetailClientCell.h"
#import "HXReservationDetailViewModel.h"
#import "UIImageView+WebCache.h"
#import "UIConstants.h"

@implementation HXReservationDetailClientCell

#pragma mark - Init Methods
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initConfig];
    [self viewConfig];
}

#pragma mark - Config Methods
- (void)initConfig {
    _addressLabel.preferredMaxLayoutWidth = SCREEN_WIDTH - 125.0f;
}

- (void)viewConfig {
    _clientHeader.layer.cornerRadius = _clientHeader.frame.size.height/2;
}

#pragma mark - Public Methods
- (void)displayWithDetailViewModel:(HXReservationDetailViewModel *)viewModel {
    HXReservationDetial *detail = viewModel.detail;
    _clientNameLabel.text = detail.clientName;
    _addressLabel.text = detail.address;
    _addressLabel.text = @"水电费大沙发撒打发士大夫撒旦发送到发送到发送到发的发生的法师打发士大夫是打发撒旦法师的法撒旦法撒打发士大夫撒旦";
    [_clientHeader sd_setImageWithURL:[NSURL URLWithString:detail.clientAvatar]];
}

@end
