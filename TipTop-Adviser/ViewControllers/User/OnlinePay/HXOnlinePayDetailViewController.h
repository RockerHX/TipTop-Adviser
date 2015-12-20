//
//  HXOnlinePayDetailViewController.h
//  TipTop-Adviser
//
//  Created by ShiCang on 15/10/28.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "UIViewController+HXClass.h"

@interface HXOnlinePayDetailViewController : UITableViewController

@property (weak, nonatomic) IBOutlet  UIView *payInfoView;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@property (nonatomic, copy) NSString *orderID;

- (IBAction)phoneButonPressed;

@end
