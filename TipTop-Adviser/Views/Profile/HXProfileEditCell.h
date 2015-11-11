//
//  HXProfileEditCell.h
//  TipTop-Adviser
//
//  Created by ShiCang on 15/11/11.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HXProfileEditStyle) {
    HXProfileEditStyleAdd,
    HXProfileEditStyleEdit,
    HXProfileEditStyleDelete
};

@class HXProfileViewModel;

@protocol HXProfileEditCellDelegate <NSObject>

@required
- (void)cellShouldEdit:(HXProfileEditStyle)editStyle;

@end

@interface HXProfileEditCell : UITableViewCell

@property (weak, nonatomic) IBOutlet       id  <HXProfileEditCellDelegate>delegate;
@property (weak, nonatomic) IBOutlet   UIView *whiteBGView;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet   UIView *deleteButtonBottomLine;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet   UIView *addButtonBottomLine;
@property (weak, nonatomic) IBOutlet UIButton *editButton;

- (IBAction)addButtonPressed;
- (IBAction)editButtonPressed;
- (IBAction)deleteButtonPressed;

- (void)displayWithViewModel:(HXProfileViewModel *)viewModel;

@end
