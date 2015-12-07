//
//  HXOrderAlertView.h
//  TipTop-Adviser
//
//  Created by ShiCang on 15/10/25.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXGrabOrder.h"

@interface HXOrderAlertView : UIView <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet      UIView *containerView;
@property (weak, nonatomic) IBOutlet     UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)hanleButtonPressed;

+ (instancetype)showWithNewOrder:(HXGrabOrder *)newOrder hanlde:(void(^)(HXGrabOrder *newOrder))handle;

- (void)showWithNewOrder:(HXGrabOrder *)newOrder hanlde:(void(^)(HXGrabOrder *newOrder))handle;
- (void)hidden;

@end
