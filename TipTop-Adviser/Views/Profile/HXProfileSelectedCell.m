//
//  HXProfileSelectedCell.m
//  TipTop-Adviser
//
//  Created by ShiCang on 15/11/11.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXProfileSelectedCell.h"

@implementation HXProfileSelectedCell

#pragma mark - Event Response
- (IBAction)buttonPressed:(UIButton *)sender {
    __weak __typeof__(self)weakSelf = self;
    [UIView animateWithDuration:0.3f animations:^{
        __strong __typeof__(self)strongSelf = weakSelf;
        strongSelf.bottomLine.center = CGPointMake(sender.center.x, strongSelf.bottomLine.center.y);
    } completion:^(BOOL finished) {
        __strong __typeof__(self)strongSelf = weakSelf;
        if (strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(selectedCellStateChange:)]) {
            [strongSelf.delegate selectedCellStateChange:sender.tag];
        }
    }];
}

@end
