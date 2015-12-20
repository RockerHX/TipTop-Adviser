//
//  HXDatePickerView.m
//  MaintenanceCar
//
//  Created by ShiCang on 15/1/9.
//  Copyright (c) 2015年 MaintenanceCar. All rights reserved.
//

#import "HXDatePickerView.h"
#import "UIConstants.h"

@implementation HXDatePickerView

- (instancetype)initWithDelegate:(id<HXDatePickerViewDelegate>)delegate mode:(UIDatePickerMode)mode {
    // 从Xib加载View
    self = [[[NSBundle mainBundle] loadNibNamed:@"HXDatePickerView" owner:self options:nil] firstObject];
    self.frame = [UIApplication sharedApplication].keyWindow.bounds;
    
    // 设置代理，初始化数据
    _delegate = delegate;
    _datePicker.datePickerMode = mode;
    _datePicker.minimumDate = [NSDate date];
    
    [_datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    
    [self viewConfig];
    
    return self;
}

#pragma mark - Private Methods
- (void)viewConfig {
    // 添加单机手势，初始化数据
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addGestureRecognizer)]];
    self.alpha = ZERO_POINT;
}

- (void)dateChanged:(UIDatePicker *)datePicker {
    // 数据一旦有改变就进行回调，以便筛选栏进行显示
    if (_delegate && [_delegate respondsToSelector:@selector(datePickerSelectedFinish:mode:)]) {
        [_delegate datePickerSelectedFinish:datePicker.date mode:_datePicker.datePickerMode];
    }
}

- (void)addGestureRecognizer {
    // 空白区域被点击之后触发回调，关闭时间筛选器
    if (_delegate && [_delegate respondsToSelector:@selector(datePickerSelectedFinish:mode:)]) {
        [_delegate datePickerSelectedFinish:_datePicker.date mode:_datePicker.datePickerMode];
    }
    [self removeDatePickerView];
}

- (void)removeDatePickerView {
    // 关闭动画
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2f animations:^{
        weakSelf.alpha = ZERO_POINT;
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}

#pragma mark - Public Methods
- (void)show {
    // 显示动画
    __weak typeof(self) weakSelf = self;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    _bottomConstraint.constant = _bottomConstraint.constant / 8;
    [_containerView needsUpdateConstraints];
    [UIView animateWithDuration:0.15f delay:ZERO_POINT options:UIViewAnimationOptionCurveEaseIn animations:^{
        weakSelf.alpha = 0.2f;
        [weakSelf.containerView layoutIfNeeded];
    } completion:^(BOOL finished) {
        _bottomConstraint.constant = ZERO_POINT;
        [_containerView needsUpdateConstraints];
        [UIView animateWithDuration:0.15f delay:ZERO_POINT options:UIViewAnimationOptionCurveEaseOut animations:^{
            weakSelf.alpha = 1.0f;
            [weakSelf.containerView layoutIfNeeded];
        } completion:nil];
    }];
}

@end
