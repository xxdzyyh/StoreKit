//
//  QDThemeManager.h
//  qmuidemo
//
//  Created by QMUI Team on 2017/5/9.
//  Copyright © 2017年 QMUI Team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QDThemeProtocol.h"

NS_ASSUME_NONNULL_BEGIN

/// 简单对 QMUIThemeManager 做一层业务的封装，省去类型转换的工作量
@interface QDThemeManager : NSObject

@property(class, nonatomic, readonly, nullable) NSObject<QDThemeProtocol> *currentTheme;
@end

@interface UIColor (QDTheme)

/// 背景色
/// @discussion Dark模式:RGB(11, 11, 11) 深黑色
/// @discussion 其他模式:
@property(class, nonatomic, strong, readonly) UIColor *qd_backgroundColor;

/// 背景色
/// @discussion Dark模式:RGB(33, 33, 33) 中等黑色
/// @discussion 其他模式:
@property(class, nonatomic, strong, readonly) UIColor *qd_backgroundColorLighten;

/// 背景色
/// @discussion Dark模式:RGB(45, 45, 45) 浅黑色
/// @discussion 其他模式:
@property(class, nonatomic, strong, readonly) UIColor *qd_backgroundColorHighlighted;

/// tintColor
/// @discussion Dark模式:RGB(255, 227, 0)  黄色
/// @discussion 其他模式:
@property(class, nonatomic, strong, readonly) UIColor *qd_tintColor;

/// 文字颜色
/// @discussion Dark模式:RGB(218, 220, 224)  白色
/// @discussion 其他模式:
@property(class, nonatomic, strong, readonly) UIColor *qd_titleTextColor;

/// 文字颜色
/// @discussion Dark模式:RGB(178, 180, 184)  浅灰色
/// @discussion 其他模式:
@property(class, nonatomic, strong, readonly) UIColor *qd_mainTextColor;

/// 文字颜色
/// @discussion Dark模式:RGB(118, 120, 124)  灰色
/// @discussion 其他模式:
@property(class, nonatomic, strong, readonly) UIColor *qd_descriptionTextColor;

/// 文字颜色
/// @discussion Dark模式:RGB(78, 80, 84)  深灰色
/// @discussion 其他模式:
@property(class, nonatomic, strong, readonly) UIColor *qd_placeholderColor;

/// 主题色
/// @discussion Dark模式:RGB(255, 227, 0)  黄色
/// @discussion 其他模式:
@property(class, nonatomic, strong, readonly) UIColor *qd_codeColor;

/// 分割线色
/// @discussion Dark模式:RGB(46, 50, 54)  浅黑色
/// @discussion 其他模式:
@property(class, nonatomic, strong, readonly) UIColor *qd_separatorColor;

/// 主题色
/// @discussion Dark模式: 未设置 默认 RGB(49, 189, 243)
/// @discussion 其他模式:
@property(class, nonatomic, strong, readonly) UIColor *qd_gridItemTintColor;

/// 主题色
/// @discussion Dark模式:未设置 默认RGB(19, 20, 41)
/// @discussion 其他模式:
@property(class, nonatomic, strong, readonly) UIColor *qd_shopMainColor;

/// 起始渐变色
@property(class, nonatomic, strong, readonly) UIColor *qd_startColor;

/// 终止渐变色
@property(class, nonatomic, strong, readonly) UIColor *qd_endColor;



@end

@interface UIImage (QDTheme)

@property(class, nonatomic, strong, readonly) UIImage *qd_searchBarTextFieldBackgroundImage;
@property(class, nonatomic, strong, readonly) UIImage *qd_searchBarBackgroundImage;
@end

@interface UIVisualEffect (QDTheme)

@property(class, nonatomic, strong, readonly) UIVisualEffect *qd_standardBlurEffect;
@end

NS_ASSUME_NONNULL_END
