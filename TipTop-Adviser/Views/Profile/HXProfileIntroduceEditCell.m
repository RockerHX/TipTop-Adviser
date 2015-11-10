//
//  HXProfileIntroduceEditCell.m
//  TipTop-Adviser
//
//  Created by ShiCang on 15/11/11.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXProfileIntroduceEditCell.h"
#import "HXProfileViewModel.h"

@implementation HXProfileIntroduceEditCell

#pragma mark - Public Methods
- (void)displayWithViewModel:(HXProfileViewModel *)viewModel {
    _whiteBGView.hidden = !viewModel.hasIntroduce;
}

@end
