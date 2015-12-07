//
//  HXOrderAlertCell.h
//  TipTop-Adviser
//
//  Created by ShiCang on 15/10/25.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "UITableView+FDTemplateLayoutCell.h"

@class HXGrabOrder;

@interface HXOrderAlertCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

- (void)displayWithNewOrder:(HXGrabOrder *)newOrder row:(NSInteger)row;

@end
