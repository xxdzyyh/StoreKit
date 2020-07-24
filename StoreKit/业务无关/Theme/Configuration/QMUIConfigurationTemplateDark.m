//
//  QMUIConfigurationTemplate.m
//  qmui
//
//  Created by QMUI Team on 15/3/29.
//  Copyright (c) 2015年 QMUI Team. All rights reserved.
//

#import "QMUIConfigurationTemplateDark.h"

#import "QDCommonUI.h"
#import "StoreKit-Swift.h"
#import <YYCategories/YYCategories.h>


@implementation QMUIConfigurationTemplateDark

#pragma mark - <QMUIConfigurationTemplateProtocol>

- (void)applyConfigurationTemplate {
    [super applyConfigurationTemplate];
    
    QMUICMI.keyboardAppearance = UIKeyboardAppearanceDark;
    
    QMUICMI.navBarBackgroundImage = nil;
    QMUICMI.navBarStyle = UIBarStyleBlack;
    QMUICMI.navBarBarTintColor = UIColor.qd_backgroundColor;
    QMUICMI.navBarBackgroundImage = [UIImage imageWithColor:QMUICMI.navBarBarTintColor];

    QMUICMI.tabBarBackgroundImage = nil;
    QMUICMI.tabBarStyle = UIBarStyleBlack;
    
    QMUICMI.toolBarStyle = UIBarStyleBlack;
    
    QMUICMI.tableViewCellTitleLabelColor = [UIColor colorWithHexString:@"DDDDDD"];
    QMUICMI.tableViewSectionHeaderBackgroundColor = UIColor.clearColor;
    QMUICMI.tableViewSectionFooterBackgroundColor = UIColor.clearColor;
}

// QMUI 2.3.0 版本里，配置表新增这个方法，返回 YES 表示在 App 启动时要自动应用这份配置表。仅当你的 App 里存在多份配置表时，才需要把除默认配置表之外的其他配置表的返回值改为 NO。
- (BOOL)shouldApplyTemplateAutomatically {
    return YES;
}

#pragma mark - <QDThemeProtocol>

- (UIColor *)themeBackgroundColor {
    return UIColorMakeWithHex(@"#0A0D19");
}

- (UIColor *)themeBackgroundColorLighten {
    return UIColorMakeWithHex(@"#101428");
}

- (UIColor *)themeBackgroundColorHighlighted {
    return UIColorMake(45, 45, 45);
}

- (UIColor *)themeStartColor {
    return UIColorMake(255, 88, 88);
}

- (UIColor *)themeEndColor {
    return UIColorMake(239, 55, 92);
}

- (UIColor *)themeTintColor {
    return UIColorMakeWithHex(@"#FFE300");
}

- (UIColor *)themeTitleTextColor {
    return UIColorWhite;
}

- (UIColor *)themeMainTextColor {
    return UIColorDarkGray3;
}

- (UIColor *)themeDescriptionTextColor {
    return UIColorDarkGray6;
}

- (UIColor *)themePlaceholderColor {
    return UIColorMakeWithRGBA(255, 255, 255, 0.6);
}

- (UIColor *)themeCodeColor {
    return self.themeTintColor;
}

- (UIColor *)themeSeparatorColor {
    return UIColorMakeWithRGBA(255, 255, 255, 0.06);
}

- (NSString *)themeName {
    return QDThemeIdentifierDark;
}

@end
