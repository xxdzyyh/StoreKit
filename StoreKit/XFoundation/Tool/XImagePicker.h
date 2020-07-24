//
//  XImagePicker.h
//  NMWeiShi
//
//  Created by XXXXon 2020/7/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XImagePicker : NSObject

@property (copy, nonatomic) NSString *takePhotoTitle;
@property (copy, nonatomic) NSString *pickerPhotoTitle;

/// 弹出ActionSheet,让用户选择是拍照还是从相册选择一张图片
/// @param completion 回调，如果用户取消了选择，不会触发回调，只有选择了图片才会触发回调
+ (void)showWithCompletion:(void(^)(UIImage*))completion;

/// 弹出ActionSheet,让用户选择是拍照还是从相册选择一张图片
/// @param completion 回调，如果用户取消了选择，不会触发回调，只有选择了图片才会触发回调
- (void)showWithCompletion:(void(^)(UIImage*))completion;

+ (void)showImagePickerView:(BOOL)isTakePhoto completion:(void(^)(UIImage*))completion;

@end

NS_ASSUME_NONNULL_END
