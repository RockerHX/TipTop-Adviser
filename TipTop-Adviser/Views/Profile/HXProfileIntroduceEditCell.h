//
//  HXProfileIntroduceEditCell.h
//  TipTop-Adviser
//
//  Created by ShiCang on 15/11/11.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HXProfileViewModel;

@interface HXProfileIntroduceEditCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *whiteBGView;

- (void)displayWithViewModel:(HXProfileViewModel *)viewModel;

@end
