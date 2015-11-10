//
//  HXProfileSelectedCell.h
//  TipTop-Adviser
//
//  Created by ShiCang on 15/11/11.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXProfileViewModel.h"


@protocol HXProfileSelectedCellDelegate <NSObject>

@required
- (void)selectedCellStateChange:(HXProfileSelectType)type;

@end

@interface HXProfileSelectedCell : UITableViewCell

@property (weak, nonatomic) IBOutlet     id  <HXProfileSelectedCellDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIView *bottomLine;

- (IBAction)buttonPressed:(UIButton *)sender;

@end
