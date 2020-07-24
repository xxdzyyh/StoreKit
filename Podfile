# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'


# 使用清华大学开源软件镜像
source 'https://mirrors.tuna.tsinghua.edu.cn/git/CocoaPods/Specs.git'

platform :ios, '10.0'

inhibit_all_warnings!



#MARK: - 基础设施集合
def Foundation
  # YYKit 是一组功能丰富的 iOS 组件（尽量不要全部安装）。
  #pod 'YYKit'
  # 以下独立组件按需安装
  pod 'YYModel' # 高性能的 iOS JSON 模型框架。
  pod 'YYWebImage' # 高性能的 iOS 异步图像加载框架。
  pod 'YYText' # 功能强大的 iOS 富文本框架。
  pod 'YYKeyboardManager' # iOS 键盘监听管理工具。
 
  pod 'YYCategories' # 功能丰富的 Category 类型工具库。
  
  pod 'YBAttributeTextTapAction'
  
  #资源引用
  pod 'R.swift'

  #JSON数据处理
  pod 'SwiftyJSON'
  #Swift模型解析
  #pod 'ObjectMapper', '~> 3.4'
  pod 'HandyJSON' #, '~> 5.0.1'

  pod 'RxSwift'
  pod 'RxCocoa'
  
  #网络请求
  pod 'Alamofire'#, '~> 5.0.0-rc.3'
  pod 'Moya/RxSwift' #, '~> 13.0'

  #网络请求活动指示器
  pod 'AlamofireNetworkActivityIndicator'
  
  #路由
  pod 'URLNavigator'
  
  pod 'MZTimerLabel'
  
  #生物识别，指纹解锁、面部识别
  pod 'BiometricAuthentication'
  
  # Keychain
  pod 'KeychainSwift'

  # WebSocket
  pod 'Starscream', '~> 3.1.1'
  
  # 轮播图
  pod 'FSPagerView'
  
end

#MARK: - QMUIKit
def QMUIKit
  
  # 全部安装
  pod 'QMUIKit'
end


#MARK: - UI 组件集合
def Components
  QMUIKit()
  
  #自动布局
  pod 'Masonry'
  #swift版Masonry
  pod 'SnapKit'

  #键盘处理
  #pod 'IQKeyboardManager'
  pod 'IQKeyboardManagerSwift'

  #加载框, Toast, TODO: 封装一层Toast调用
  pod 'Toast-Swift', '~> 5.0.1'
#  pod 'Toast'
  #pod 'SVProgressHUD'
  pod 'MBProgressHUD'

  pod 'TYCyclePagerView' # 支持缩放效果

  # App Store 五星评分的控件
  pod 'HCSStarRatingView'
  
  #自动识别人脸，并使头像居中
  #pod 'FaceAware'

  #横向分类菜单以及页面控制器
  pod 'HMSegmentedControl'#, '~> 1.5.5'
  pod 'JXCategoryView' # 推荐使用
  pod 'JXSegmentedView' # JXCategoryView Swift 版
  #分类菜单控制器添加头部视图，有联动效果
  pod 'JXPagingView/Paging', "2.0.6" # swift 版
  pod 'JXPagingView/Pager', "2.0.6" # OC 版
  #横向分类页面控制器
  #pod 'TYPagerController'
  #pod 'YNPageViewController'
  
  #可以实现不规则TabBar，支持TabItem动画等等
  pod 'CYLTabBarController'

  #图片下载、缓存、渲染
  #说明：SDWebImage从5.0版本开始提供了SDAnimatedImageView来显示动态图片(GIF/WebP/APNG)
  pod 'SDWebImage'

  #UIScrollView下拉刷新上拉加载插件
  pod 'MJRefresh'#, '3.4.0'
  
  #上下滚动显示（常用于公告）
  pod 'RollingNotice-Swift'
  #pod 'RollingNotice'
  
  #相片读取
  #pod 'FSMediaPicker'
  #pod 'ZLPhotoBrowser'
  pod 'TZImagePickerController'
  #pod 'HXPhotoPicker'
  
  # cell侧滑删除等
  pod 'SwipeCellKit'
  
  # A data-driven UICollectionView framework for building fast and flexible lists.
  # https://instagram.github.io/IGListKit/
  pod 'IGListKit'
  
   pod 'swiftScan',:git => 'https://github.com/MxABC/swiftScan.git', :branch => 'master'
end

target 'StoreKit' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for StoreKit
  Foundation()
  Components()

end
