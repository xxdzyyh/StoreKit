//
//  ThemeManager.swift
//  iOSAppNext
//
//  Created by XXXX on 2019/12/25.
//  Copyright © 2019 -. All rights reserved.
//

import QMUIKit

final class ThemeManager {
    
    static var isDark: Bool {
        let themeId = QMUIThemeManagerCenter.defaultThemeManager.currentThemeIdentifier
        return themeId as? String == QDThemeIdentifierDark
    }
    
    static func setup() {
        // 加载所有主题，QMUI只会加载部分主题
        loadAllThemeConfiguration()
        // 注册默认主题
        let defaultThemeId = QDThemeIdentifierDark
        UserDefaults.standard.register(defaults: [QDSelectedThemeIdentifier: defaultThemeId])
        
        // 1. 先注册主题监听，在回调里将主题持久化存储，避免启动过程中主题发生变化时读取到错误的值
        NotificationCenter.default.addObserver(self, selector: #selector(handleThemeDidChange(notification:)), name: .QMUIThemeDidChange, object: nil)
        
        // 2. 然后设置主题的生成器
        setupThemeGenerator()
        // 设置 UIUserInterfaceStyleLight 模式下的主题
        let themeMgr = QMUIThemeManagerCenter.defaultThemeManager
        themeMgr.currentThemeIdentifier = defaultThemeId as NSCopying & NSObjectProtocol
        themeMgr.qmui_perform(NSSelectorFromString("notifyThemeChanged"), withPrimitiveReturnValue: nil)
        
        // 3. 再针对 iOS 13 开启自动响应系统的 Dark Mode 切换
        // 如果不需要这个功能，则不需要这一段代码
        setupSystemStyleAutomaticallyResponder()
        
        // QD自定义的全局样式渲染
        QDCommonUI.renderGlobalAppearances()
        
        // 预加载 QQ 表情，避免第一次使用时卡顿
        DispatchQueue.global(qos: .utility).async {
            QDUIHelper.qmuiEmotions()
        }
    }
    
    @objc static func handleThemeDidChange(notification: Notification) {
        guard let mgr = notification.object as? QMUIThemeManager else {
            return
        }
        
        if #available(iOS 13.0, *) {
            // 深色模式自动切换时不存储
            if UITraitCollection.current.userInterfaceStyle == .dark, mgr.respondsSystemStyleAutomatically {
                
            } else {
                UserDefaults.standard.set(mgr.currentThemeIdentifier, forKey: QDSelectedThemeIdentifier)
            }
        } else {
            UserDefaults.standard.set(mgr.currentThemeIdentifier, forKey: QDSelectedThemeIdentifier)
        }
        
        
        QDThemeManager.currentTheme?.applyConfigurationTemplate()
        
        // 主题发生变化，在这里更新全局 UI 控件的 appearance
        QDCommonUI.renderGlobalAppearances()
        
        // 更新表情 icon 的颜色
        QDUIHelper.updateEmotionImages()
    }
    
    // 2. 然后设置主题的生成器
    static func setupThemeGenerator() {
        let themeMgr = QMUIThemeManagerCenter.defaultThemeManager
        themeMgr.themeGenerator = { identifier -> NSObject? in
            guard let idstr = identifier as? String else { return nil }
            
            return themeMgr.themes?.filter({ (obj) -> Bool in
                return obj is QDThemeProtocol && (obj as! QDThemeProtocol).themeName() == idstr
            }).first
        }
    }
    
    // 3. 再针对 iOS 13 开启自动响应系统的 Dark Mode 切换
    // 如果不需要这个功能，则不需要这一段代码
    static func setupSystemStyleAutomaticallyResponder() {
        if #available(iOS 13.0, *) {
            // 做这个 if(currentThemeIdentifier) 的保护只是为了避免 QD 里的配置表没启动时，没人为 currentTheme/currentThemeIdentifier 赋值，导致后续的逻辑会 crash，业务项目里理论上不会有这种情况出现，所以可以省略这个 if 块
            let themeMgr = QMUIThemeManagerCenter.defaultThemeManager
            if let _ = themeMgr.currentThemeIdentifier {
                themeMgr.identifierForTrait = { trait -> NSCopying & NSObjectProtocol in
                    //return QDThemeIdentifierGrass as NSCopying & NSObjectProtocol
                    if trait.userInterfaceStyle == .dark {
                        return QDThemeIdentifierDark as NSCopying & NSObjectProtocol
                    }
                    if QDThemeIdentifierDark == themeMgr.currentThemeIdentifier as? String {
                        return (UserDefaults.standard.string(forKey: QDSelectedThemeIdentifier) ?? QDThemeIdentifierDefault) as NSCopying & NSObjectProtocol
                        //return QDThemeIdentifierDefault as NSCopying & NSObjectProtocol
                    }
                    return themeMgr.currentThemeIdentifier ?? QDThemeIdentifierDefault as NSCopying & NSObjectProtocol
                }
            }
            
            themeMgr.respondsSystemStyleAutomatically = true
        }
    }
    
    //MARK: - Private
    
    private static func loadAllThemeConfiguration() {
        let configTypes = [
            QMUIConfigurationTemplate.self,
            QMUIConfigurationTemplateDark.self
        ]
        configTypes.forEach { (type) in
            let themelist = QMUIThemeManagerCenter.defaultThemeManager.themes ?? []
            if themelist.filter({ $0.isMember(of: type) }).count == 0 {
                let theme = type.init()
                QMUIThemeManagerCenter.defaultThemeManager.addThemeIdentifier(theme.themeName() as NSObject & NSCopying, theme: theme)
            }
        }
    }
}
