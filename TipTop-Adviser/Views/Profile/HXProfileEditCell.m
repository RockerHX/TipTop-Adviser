//
//  HXProfileEditCell.m
//  TipTop-Adviser
//
//  Created by ShiCang on 15/11/11.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXProfileEditCell.h"
#import "HXProfileViewModel.h"

@implementation HXProfileEditCell

#pragma mark - Event Response
- (IBAction)addButtonPressed {
    if (_delegate && [_delegate respondsToSelector:@selector(cellShouldEdit:)]) {
        [_delegate cellShouldEdit:HXProfileEditStyleAdd];
    }
}

- (IBAction)editButtonPressed {
    if (_delegate && [_delegate respondsToSelector:@selector(cellShouldEdit:)]) {
        [_delegate cellShouldEdit:HXProfileEditStyleEdit];
    }
}

- (IBAction)deleteButtonPressed {
    if (_delegate && [_delegate respondsToSelector:@selector(cellShouldEdit:)]) {
        [_delegate cellShouldEdit:HXProfileEditStyleDelete];
    }
}

#pragma mark - Public Methods
- (void)displayWithViewModel:(HXProfileViewModel *)viewModel {
    _whiteBGView.hidden = !viewModel.hasIntroduce;
    
    BOOL isIntroduce = !viewModel.selectType;
    _addButton.hidden = isIntroduce;
    _addButtonBottomLine.hidden = isIntroduce;
    _deleteButton.hidden = isIntroduce;
    _deleteButtonBottomLine.hidden = isIntroduce;
    
//    [_editButton setImage:[UIImage imageNamed:(isIntroduce ? @"")] forState:UIControlStateNormal];
}

@end
