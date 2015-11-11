//
//  HXCaseCardCollectionViewCell.m
//  TipTop-Adviser
//
//  Created by ShiCang on 15/11/12.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXCaseCardCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@implementation HXCaseCardCollectionViewCell

#pragma mark - Public Methods
- (void)displayWithCase:(HXCase *)caseIntance {
    [_cardImageView sd_setImageWithURL:[NSURL URLWithString:caseIntance.image]];
}

@end
