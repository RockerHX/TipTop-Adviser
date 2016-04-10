//
//  HXReservationAddRemarkViewController.h
//  TipTop-Adviser
//
//  Created by ShiCang on 15/10/26.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "UIViewController+HXClass.h"


@class HXReservationAddRemarkViewController;


@protocol HXReservationAddRemarkContainerViewControllerDelegate <NSObject>

@required
- (void)addRevervationViewAddSuccess:(HXReservationAddRemarkViewController *)viewContaoller;

@end


@interface HXReservationAddRemarkViewController : UIViewController

@property (weak, nonatomic) IBOutlet          id  <HXReservationAddRemarkContainerViewControllerDelegate>delegate;

@property (weak, nonatomic) IBOutlet     UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet  UITextView *textView;
@property (weak, nonatomic) IBOutlet      UIView *addImageContainerView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewBottomConstraint;

@property (nonatomic, copy) NSString *orderID;

- (IBAction)saveButtonPressed;
- (IBAction)addImageButtonPressed;

@end
