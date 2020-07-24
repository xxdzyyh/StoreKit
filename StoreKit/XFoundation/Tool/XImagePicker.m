//
//  XImagePicker.m
//  NMWeiShi
//
//  Created by XXXXon 2020/7/9.
//

#import "XImagePicker.h"
#import <QMUIKit/QMUIKit.h>

@interface XImagePicker()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (copy, nonatomic) void(^completion)(UIImage *);

@property (strong, nonatomic) XImagePicker *retainSelf;

@end

@implementation XImagePicker

- (instancetype)init {
    self = [super init];
    if (self) {
        _takePhotoTitle = @"拍照";
        _pickerPhotoTitle = @"从相册上传";
    }
    return self;
}

- (void)dealloc {
    NSLog(@"XImagePicker dealloc");
}

+ (void)showWithCompletion:(void (^)(UIImage * _Nonnull))completion {
    if ([[NSThread currentThread] isMainThread] == false) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[XImagePicker new] showWithCompletion:completion];
        });
    } else {
        [[XImagePicker new] showWithCompletion:completion];
    }
}

- (void)showWithCompletion:(void (^)(UIImage * _Nonnull))completion {
    if (completion == nil) {
        NSLog(@"选择的结果没有处理");
        return;
    }
    
    // 构建一个循环引用，等待代理方法
    self.retainSelf = self;
    self.completion = completion;
    
    QMUIAlertController *controller = [QMUIAlertController alertControllerWithTitle:nil message:nil preferredStyle:QMUIAlertControllerStyleActionSheet];
    
    QMUIAlertAction *takePhotoAction = [QMUIAlertAction actionWithTitle:self.takePhotoTitle style:QMUIAlertActionStyleDefault handler:^(__kindof QMUIAlertController * _Nonnull aAlertController, QMUIAlertAction * _Nonnull action) {
        [self showImagePickerView:YES];
    }];
    
    QMUIAlertAction *pickPhotoAction = [QMUIAlertAction actionWithTitle:self.pickerPhotoTitle style:QMUIAlertActionStyleDefault handler:^(__kindof QMUIAlertController * _Nonnull aAlertController, QMUIAlertAction * _Nonnull action) {
        [self showImagePickerView:NO];
    }];

    [controller addAction:takePhotoAction];
    [controller addAction:pickPhotoAction];
    [controller addCancelAction];
    [controller showWithAnimated:true];
}

- (void)showImagePickerView:(BOOL)isTakePhoto {
    if (self.retainSelf == nil) {
        self.retainSelf = self;
    }
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    
    if (isTakePhoto) {
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [[QMUIHelper visibleViewController] presentViewController:imagePickerController animated:YES completion:nil];
}

+ (void)showImagePickerView:(BOOL)isTakePhoto completion:(void(^)(UIImage*))completion {
    XImagePicker *picker = [XImagePicker new];
    picker.completion = completion;
    [picker showImagePickerView:isTakePhoto];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
    self.retainSelf = nil;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    //通过key值获取到图片
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (image == nil) {
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    self.completion(image);
    self.retainSelf = nil;
}

@end
