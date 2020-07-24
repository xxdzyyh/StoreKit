//
//  QDCommonUI.m
//  qmuidemo
//
//  Created by QMUI Team on 16/8/8.
//  Copyright © 2016年 QMUI Team. All rights reserved.
//

#import "QDCommonUI.h"
#import "QDUIHelper.h"

NSString *const QDSelectedThemeIdentifier = @"selectedThemeIdentifier";
NSString *const QDThemeIdentifierDefault = @"Default";
NSString *const QDThemeIdentifierGrapefruit = @"Grapefruit";
NSString *const QDThemeIdentifierGrass = @"Grass";
NSString *const QDThemeIdentifierPinkRose = @"Pink Rose";
NSString *const QDThemeIdentifierDark = @"Dark";

const CGFloat QDButtonSpacingHeight = 72;

@implementation QDCommonUI

+ (void)renderGlobalAppearances {
    [QDUIHelper customMoreOperationAppearance];
    [QDUIHelper customAlertControllerAppearance];
    [QDUIHelper customDialogViewControllerAppearance];
    [QDUIHelper customImagePickerAppearance];
    [QDUIHelper customEmotionViewAppearance];
    
    UISearchBar *searchBar = [UISearchBar appearance];
    searchBar.searchTextPositionAdjustment = UIOffsetMake(4, 0);
    
//    QMUILabel *label = [QMUILabel appearance];
//    label.highlightedBackgroundColor = TableViewCellSelectedBackgroundColor;
    
    
    UITextField *textFieldInSearchBar = [UITextField appearanceWhenContainedInInstancesOfClasses:@[UISearchBar.self]];
    textFieldInSearchBar.defaultTextAttributes = @{
        NSFontAttributeName : [UIFont systemFontOfSize:14]
    };
    
    UIBarButtonItem *navbarBtn = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[UINavigationBar.self]];
    [navbarBtn setTitleTextAttributes:@{
        NSFontAttributeName: [UIFont systemFontOfSize:14]
    } forState:UIControlStateNormal];
    [navbarBtn setTitleTextAttributes:@{
        NSFontAttributeName: [UIFont systemFontOfSize:14]
    } forState:UIControlStateHighlighted];
    
    
//    UINavigationBar *navbar = [UINavigationBar appearance];
//    navbar.backIndicatorImage = [UIImage imageNamed:@"spxq_fanhui"];
//    navbar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"spxq_fanhui"];
    
    UITabBar *tabbar = UITabBar.appearance;
    tabbar.unselectedItemTintColor = UIColor.whiteColor;
}

@end

@implementation QDCommonUI (ThemeColor)

static NSArray<UIColor *> *themeColors = nil;
+ (UIColor *)randomThemeColor {
    if (!themeColors) {
        themeColors = @[UIColorTheme1,
                        UIColorTheme2,
                        UIColorTheme3,
                        UIColorTheme4,
                        UIColorTheme5,
                        UIColorTheme6,
                        UIColorTheme7,
                        UIColorTheme8,
                        UIColorTheme9,
                        UIColorTheme10];
    }
    return themeColors[arc4random() % themeColors.count];
}

@end

@implementation QDCommonUI (Layer)

+ (CALayer *)generateSeparatorLayer {
    CALayer *layer = [CALayer layer];
    [layer qmui_removeDefaultAnimations];
    layer.backgroundColor = UIColorSeparator.CGColor;
    return layer;
}

@end
