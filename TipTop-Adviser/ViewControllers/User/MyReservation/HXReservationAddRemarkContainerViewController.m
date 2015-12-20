//
//  HXReservationAddRemarkContainerViewController.m
//  TipTop-Adviser
//
//  Created by ShiCang on 15/10/26.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXReservationAddRemarkContainerViewController.h"
#import "BRPlaceholderTextView.h"
#import "DateTools.h"
#import "HXDatePickerView.h"

static NSString *TextViewPrompt = @"请输入备注事件";

@interface HXReservationAddRemarkContainerViewController () <HXDatePickerViewDelegate>
@end

@implementation HXReservationAddRemarkContainerViewController

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initConfig];
    [self viewConfig];
}

#pragma mark - Config Methods
- (void)initConfig {
    ;
}

- (void)viewConfig {
    _dateLabel.text = [[NSDate date] formattedDateWithFormat:@"yyyy-MM-dd hh:mm"];
    _textView.placeholder = TextViewPrompt;
}

#pragma mark - Table View Delegete Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (0 == indexPath.row) {
        [self.view endEditing:YES];
        HXDatePickerView *datePicker = [[HXDatePickerView alloc] initWithDelegate:self mode:UIDatePickerModeDateAndTime];
        [datePicker show];
    }
}

#pragma mark - HXDatePickerViewDelegate Methods
- (void)datePickerSelectedFinish:(NSDate *)date mode:(UIDatePickerMode)mode {
    _dateLabel.text = [date formattedDateWithFormat:@"yyyy-MM-dd hh:mm"];
}

@end
