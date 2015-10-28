//
//  HXForgotPWViewController.h
//  TipTop-Adviser
//
//  Created by ShiCang on 15/10/7.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HXSecurityCodeButton;

@interface HXForgotPWViewController : UITableViewController

@property (weak, nonatomic) IBOutlet HXSecurityCodeButton *codeButton;

- (IBAction)backButtonPressed;

@end
