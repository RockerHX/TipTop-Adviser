//
//  HXCaseCardCell.m
//  TipTop-Adviser
//
//  Created by ShiCang on 15/11/12.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXCaseCardCell.h"
#import "HXProfileViewModel.h"
#import "HXCaseCardCollectionViewCell.h"

@implementation HXCaseCardCell {
    NSArray *_cases;
}

#pragma mark - Public Methods
- (void)displayWithViewModel:(HXProfileViewModel *)viewModel {
    _cases = viewModel.cases;
    [_collectionView reloadData];
}

#pragma mark - Collection View Data Source Methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _cases.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HXCaseCardCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HXCaseCardCollectionViewCell class]) forIndexPath:indexPath];
    [cell displayWithCase:_cases[indexPath.row]];
    return cell;
}

@end
