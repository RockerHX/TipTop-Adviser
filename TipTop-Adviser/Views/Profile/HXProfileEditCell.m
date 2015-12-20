//
//  HXProfileEditCell.m
//  TipTop-Adviser
//
//  Created by ShiCang on 15/11/11.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXProfileEditCell.h"
#import "HXProfileViewModel.h"

@implementation HXProfileEditCell {
    NSString *_addIconImageName;
}

#pragma mark - Event Response
- (IBAction)deleteButtonPressed {
    if (_delegate && [_delegate respondsToSelector:@selector(cellShouldEdit:)]) {
        [_delegate cellShouldEdit:HXProfileEditActionDelete];
    }
}

- (IBAction)editButtonPressed {
    if (_delegate && [_delegate respondsToSelector:@selector(cellShouldEdit:)]) {
        [_delegate cellShouldEdit:HXProfileEditActionEdit];
    }
}

- (IBAction)addButtonPressed {
    BOOL isEdit = [_addIconImageName isEqualToString:@"UCP-EditIcon-S"];
    if (isEdit) {
        if (_delegate && [_delegate respondsToSelector:@selector(cellShouldEdit:)]) {
            [_delegate cellShouldEdit:HXProfileEditActionEdit];
        }
    } else {
        if (_delegate && [_delegate respondsToSelector:@selector(cellShouldEdit:)]) {
            [_delegate cellShouldEdit:HXProfileEditActionAdd];
        }
    }
}

#pragma mark - Public Methods
- (void)displayWithViewModel:(HXProfileViewModel *)viewModel {
    switch (viewModel.selectType) {
        case HXProfileSelectTypeIntroduce: {
            _whiteBGView.hidden = !viewModel.hasIntroduce;
            break;
        }
        case HXProfileSelectTypeCase: {
            _whiteBGView.hidden = !viewModel.cases.count;
            break;
        }
    }
    
    BOOL isIntroduce = !viewModel.selectType;
    _addIconImageName = (isIntroduce ? @"UCP-EditIcon-S" : @"UCP-AddIcon-S");
    [_addButton setImage:[UIImage imageNamed:_addIconImageName] forState:UIControlStateNormal];
    
    if (!viewModel.cases.count) {
        isIntroduce = YES;
    }
    _editButton.hidden = isIntroduce;
    _editButtonBottomLine.hidden = isIntroduce;
    _deleteButton.hidden = isIntroduce;
    _deleteButtonBottomLine.hidden = isIntroduce;
}

@end
