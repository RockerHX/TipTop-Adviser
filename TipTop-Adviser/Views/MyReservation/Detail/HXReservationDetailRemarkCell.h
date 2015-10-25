//
//  HXReservationDetailRemarkCell.h
//  TipTop-Adviser
//
//  Created by ShiCang on 15/10/25.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "UITableView+FDTemplateLayoutCell.h"

@class HXReservationDetailViewModel;

@interface HXReservationDetailRemarkCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *eventLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

- (void)displayWithDetailViewModel:(HXReservationDetailViewModel *)viewModel;

@end
