//
//  HXCaseCardCell.h
//  TipTop-Adviser
//
//  Created by ShiCang on 15/11/12.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HXProfileViewModel;

@interface HXCaseCardCell : UITableViewCell <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

- (void)displayWithViewModel:(HXProfileViewModel *)viewModel;

@end
