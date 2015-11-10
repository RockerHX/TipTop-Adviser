//
//  HXProfileIntroduceEditCell.h
//  TipTop-Adviser
//
//  Created by ShiCang on 15/11/11.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HXProfileViewModel;

@protocol HXProfileIntroduceEditCellDelegate <NSObject>

@required
- (void)introduceCellShouldEdit;

@end

@interface HXProfileIntroduceEditCell : UITableViewCell

@property (weak, nonatomic) IBOutlet     id  <HXProfileIntroduceEditCellDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIView *whiteBGView;

- (IBAction)editButtonPressed;

- (void)displayWithViewModel:(HXProfileViewModel *)viewModel;

@end
