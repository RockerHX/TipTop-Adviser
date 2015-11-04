//
//  HXMyAddressViewController.m
//  TipTop-Adviser
//
//  Created by ShiCang on 15/10/19.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXMyAddressViewController.h"
#import <REFrostedViewController/REFrostedViewController.h>
#import <BaiduMapAPI_Map/BMKMapView.h>

@interface HXMyAddressViewController () <BMKMapViewDelegate>
@end

@implementation HXMyAddressViewController {
    BMKMapView *_mapView;
}

#pragma mark - View Controller Life Cycle
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Event Response
- (IBAction)menuButtonPressed {
    [self.frostedViewController presentMenuViewController];
}

#pragma mark - Setter And Getter
- (NSString *)navigationControllerIdentifier {
    return @"HXMyAddressNavigationController";
}

- (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameMyAddress;
}

@end
