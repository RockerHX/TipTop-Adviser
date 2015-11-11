//
//  HXAddCaseViewController.h
//  TipTop-Adviser
//
//  Created by ShiCang on 15/11/11.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HXTextView;

@interface HXAddCaseViewController : UITableViewController

@property (weak, nonatomic) IBOutlet  HXTextView *contentIntroduceTextView;
@property (weak, nonatomic) IBOutlet UITextField *caseNameTextField;
@property (weak, nonatomic) IBOutlet    UIButton *caseImageButton;
@property (weak, nonatomic) IBOutlet  HXTextView *caseIntroduceTextView;

- (IBAction)saveButtonPressed;
- (IBAction)caseImageButtonPressed;

@end
