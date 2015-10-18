//
//  HXLoginViewController.h
//  TipTop-Adviser
//
//  Created by ShiCang on 15/10/5.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXLoginViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *staffIDTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)loginButtonPressed;
- (IBAction)forgotPasswordButtonPressed;

@end
