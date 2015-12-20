//
//  HXReservationAddRemarkContainerViewController.h
//  TipTop-Adviser
//
//  Created by ShiCang on 15/10/26.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "UIViewController+HXClass.h"

@class BRPlaceholderTextView;

@interface HXReservationAddRemarkContainerViewController : UITableViewController

@property (weak, nonatomic) IBOutlet               UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet BRPlaceholderTextView *textView;

@property (nonatomic, copy) NSString *orderID;

@end
