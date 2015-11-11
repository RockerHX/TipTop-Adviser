//
//  HXAddCaseViewController.m
//  TipTop-Adviser
//
//  Created by ShiCang on 15/11/11.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXAddCaseViewController.h"
#import "HXTextView.h"
#import "HXUserSession.h"
#import "MBProgressHUD.h"
#import "HXAppApiRequest.h"
#import "UIAlertView+BlocksKit.h"


static NSString *UploadImageApi = @"/upload";
static NSString *CreateCaseApi = @"/case/create";

@interface HXAddCaseViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@end

@implementation HXAddCaseViewController {
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

#pragma mark - Setter And Getter
- (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameUser;
}

#pragma mark - Event Response
- (IBAction)saveButtonPressed {
    if (_contentIntroduceTextView.text.length &&
        _caseNameTextField.text.length &&
        _imageFile.length &&
        _caseIntroduceTextView.text.length) {
        [self startCreateCaseReuqestWithParameters:@{@"access_token": [HXUserSession share].adviser.accessToken,
                                                      @"description": _contentIntroduceTextView.text,
                                                            @"title": _caseNameTextField.text,
                                                            @"image": _imageFile,
                                                          @"content": _caseIntroduceTextView.text}];
    }
}

- (IBAction)caseImageButtonPressed {
    UIImagePickerController *imagePickerViewController = [[UIImagePickerController alloc] init];
    imagePickerViewController.delegate = self;
    imagePickerViewController.allowsEditing = YES;
    [self presentViewController:imagePickerViewController animated:YES completion:nil];
}

#pragma mark - Private Methods
- (void)startUploadImageReuqest {
    [self startUploadImageReuqestWithParameters:@{@"access_token": [HXUserSession share].adviser.accessToken}
                                          image:[_caseImageButton imageForState:UIControlStateNormal]];
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

- (void)startCreateCaseReuqestWithParameters:(NSDictionary *)parameters {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak __typeof__(self)weakSelf = self;
    [HXAppApiRequest requestPOSTMethodsWithAPI:[HXApi apiURLWithApi:CreateCaseApi] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        __strong __typeof__(self)strongSelf = weakSelf;
        NSInteger errorCode = [responseObject[@"error_code"] integerValue];
        if (HXAppApiRequestErrorCodeNoError == errorCode) {
            [UIAlertView bk_showAlertViewWithTitle:@"创建成功"
                                           message:nil
                                 cancelButtonTitle:@"确定"
                                 otherButtonTitles:nil handler:
             ^(UIAlertView *alertView, NSInteger buttonIndex) {
                 [strongSelf.view endEditing:NO];
                 [strongSelf.navigationController popViewControllerAnimated:YES];
             }];
        }
        [MBProgressHUD hideHUDForView:strongSelf.view animated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        __strong __typeof__(self)strongSelf = weakSelf;
        [MBProgressHUD hideHUDForView:strongSelf.view animated:YES];
    }];
}

#pragma mark - UIImagePickerControllerDelegate Methods
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = info[UIImagePickerControllerEditedImage];
    [_caseImageButton setImage:image forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self startUploadImageReuqest];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
