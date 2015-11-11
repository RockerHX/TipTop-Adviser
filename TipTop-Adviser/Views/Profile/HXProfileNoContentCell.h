//
//  HXProfileNoContentCell.h
//  TipTop-Adviser
//
//  Created by ShiCang on 15/11/11.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXProfileViewModel.h"

@interface HXProfileNoContentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet  UILabel *topPromptLabel;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet  UILabel *bottomPromptLabel;

- (void)displayWithSelectType:(HXProfileSelectType)selectType;

@end
