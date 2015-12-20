//
//  HXReservationAddRemarkViewController.m
//  TipTop-Adviser
//
//  Created by ShiCang on 15/10/26.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXReservationAddRemarkViewController.h"
#import "HXAppApiRequest.h"
#import "MBProgressHUD.h"
#import "HXReservationAddRemarkContainerViewController.h"
#import "UIAlertView+BlocksKit.h"


static NSString *OrderRemarkCreateApi = @"/order/remarkCreate";
static NSString *UploadImageApi = @"/upload";

@interface HXReservationAddRemarkViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@end

@implementation HXReservationAddRemarkViewController {
    HXReservationAddRemarkContainerViewController *_containerViewController;
    NSString *_imageFile;
}

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initConfig];
    [self viewConfig];
}

#pragma mark - Config Methods
- (void)initConfig {
    
}

- (void)viewConfig {
}

#pragma mark - 
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    _containerViewController = segue.destinationViewController;
    _containerViewController.orderID = _orderID;
}

#pragma mark - Event Response
- (IBAction)saveButtonPressed {
    [self createRemark];
}

- (IBAction)addImageButtonPressed {
    UIImagePickerController *imagePickerViewController = [[UIImagePickerController alloc] init];
    imagePickerViewController.delegate = self;
    imagePickerViewController.allowsEditing = YES;
    [self presentViewController:imagePickerViewController animated:YES completion:nil];
}

#pragma mark - Setter And Getter
- (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameMyReservation;
}

#pragma mark - Private Methods
- (void)createRemark {
    _dateLabel = _containerViewController.dateLabel;
    _textView = (UITextView *)_containerViewController.textView;
    if (_textView.text.length) {
        [_textView resignFirstResponder];
        [self startCreateRemarkReuqestWithParameters:@{@"access_token": [HXUserSession share].adviser.accessToken,
                                                                 @"id": _orderID,
                                                        @"remark_time": _dateLabel.text,
                                                            @"content": (_textView.text ?: @""),
                                                             @"images": _imageFile}];
    } else {
        [self showAlertWithMessage:@"请输入备注内容"];
    }
}

- (void)startCreateRemarkReuqestWithParameters:(NSDictionary *)parameters {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak __typeof__(self)weakSelf = self;
    [HXAppApiRequest requestPOSTMethodsWithAPI:[HXApi apiURLWithApi:OrderRemarkCreateApi] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        __strong __typeof__(self)strongSelf = weakSelf;
        [MBProgressHUD hideHUDForView:strongSelf.view animated:YES];
        NSInteger errorCode = [responseObject[@"error_code"] integerValue];
        if (HXAppApiRequestErrorCodeNoError == errorCode) {
            [UIAlertView bk_showAlertViewWithTitle:@"备注成功！"
                                           message:nil
                                 cancelButtonTitle:@"确定"
                                 otherButtonTitles:nil
                                           handler:
             ^(UIAlertView *alertView, NSInteger buttonIndex) {
                 [strongSelf.navigationController popViewControllerAnimated:YES];
             }];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        __strong __typeof__(self)strongSelf = weakSelf;
        [MBProgressHUD hideHUDForView:strongSelf.view animated:YES];
    }];
}

- (void)startUploadImageReuqest {
    [self startUploadImageReuqestWithParameters:@{@"access_token":[HXUserSession share].adviser.accessToken}
                                          image:_imageView.image];
}

- (void)startUploadImageReuqestWithParameters:(NSDictionary *)parameters image:(UIImage *)image {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak __typeof__(self)weakSelf = self;
    
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0f);
    [[HXApiRequest manager] POST:[HXApi apiURLWithApi:UploadImageApi] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imageData name:@"file" fileName:@"temp.jpg" mimeType:@"image/jpg"];
    } success:^(AFHTTPRequestOperation *operation,id responseObject) {
        __strong __typeof__(self)strongSelf = weakSelf;
        NSInteger errorCode = [responseObject[@"error_code"] integerValue];
        if (HXAppApiRequestErrorCodeNoError == errorCode) {
            strongSelf->_imageFile = responseObject[@"data"][@"img"];
        }
        [MBProgressHUD hideHUDForView:strongSelf.view animated:YES];
    } failure:^(AFHTTPRequestOperation *operation,NSError *error) {
        __strong __typeof__(self)strongSelf = weakSelf;
        [MBProgressHUD hideHUDForView:strongSelf.view animated:YES];
    }];
}

#pragma mark - UIImagePickerControllerDelegate Methods
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = info[UIImagePickerControllerEditedImage];
    _imageView.image = image;
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self startUploadImageReuqest];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
