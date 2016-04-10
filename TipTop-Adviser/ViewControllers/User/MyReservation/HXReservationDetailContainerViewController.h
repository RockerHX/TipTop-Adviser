//
//  HXReservationDetailContainerViewController.h
//  TipTop-Adviser
//
//  Created by ShiCang on 15/10/25.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "UIViewController+HXClass.h"


@interface HXReservationDetailContainerViewController : UITableViewController

@property (nonatomic, copy) NSString *orderID;

- (IBAction)phoneButonPressed;
- (IBAction)sendButonPressed;

- (void)loadData;

@end
