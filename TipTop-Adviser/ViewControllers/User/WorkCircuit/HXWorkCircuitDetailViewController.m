//
//  HXWorkCircuitDetailViewController.m
//  TipTop-Adviser
//
//  Created by ShiCang on 15/10/21.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXWorkCircuitDetailViewController.h"
#import "WebViewJavascriptBridge.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "UIAlertView+BlocksKit.h"

@interface HXWorkCircuitDetailViewController () <UIWebViewDelegate>
@end

@implementation HXWorkCircuitDetailViewController {
    WebViewJavascriptBridge *_bridge;
}

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadWebView];
}

#pragma mark - Private Methods
- (void)initConfig {
}

- (void)loadWebView {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_loadURL]]];
    
    __weak __typeof__(self)weakSelf = self;
    _bridge = [WebViewJavascriptBridge bridgeForWebView:_webView];
    [_bridge registerHandler:NSStringFromClass([self class]) handler:^(id data, WVJBResponseCallback responseCallback) {
        __strong __typeof__(self)strongSelf = weakSelf;
        [strongSelf handleJSData:data];
    }];
}

- (void)hideHUD {
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

#pragma mark - Setter And Getter
- (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameWorkCircuit;
}

#pragma mark - Web View Delegate Methods
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self hideHUD];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self hideHUD];
}

#pragma mark - Private Methods
- (void)handleJSData:(id)data {
    NSLog(@"%@", data);
    NSData *jsonData = [data dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *events = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
    [self handleEvents:events];
}

- (void)handleEvents:(NSDictionary *)events {
    NSString *event = events[@"event"];
    NSString *message = events[@"params"][@"msg"];
    if ([event isEqualToString:@"confirm"]) {
        [UIAlertView bk_showAlertViewWithTitle:message
                                       message:nil
                             cancelButtonTitle:@"完结"
                             otherButtonTitles:@[@"取消"]
                                       handler:
         ^(UIAlertView *alertView, NSInteger buttonIndex) {
             if (buttonIndex == alertView.cancelButtonIndex) {
                 [_bridge callHandler:@"confirmEnter"];
             } else {
                 [_bridge callHandler:@"confirmCancel"];
             }
         }];
    } else if ([event isEqualToString:@"alert"]) {
        [self showAlertWithMessage:message];
    }
}

@end
