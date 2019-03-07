# ios端基础库
* CPX_BaseLib
  
# 组成部件
* BaseClass  
* Configration  
* Categories  
* Extensions  
* NetworkManager
* ThirdPart
* Utls

### BaseClass  
	 CPXBaseAlertView 用于自定义弹窗的所有父类
	 基本使用方法 创建一个View继承CPXBaseAlertView 使用时调用
	 	-(void)show:(BOOL)animate 即可
	 	常用属性 removeOnTouchOutside （点击空白区域是否关闭弹窗）
	 
	 CPXBaseTableView 用于自定义UITableView的所有父类
	 	初始化方式 [CPXBaseTableView new]
	 	CPXBaseTableView内部已经处理不同系统版本适配问题
	 
	 CPXBaseView 用于所有自定义视图的父类
	 	-(CPXBaseViewController*)getViewcontrollerView获取当前的		父控制器
	
### BaseVC 
	 CPXBaseNavigationController 				基类UINavigationController控制器
	 CPXBaseTabBarController 				基类UITabBarController控制器
	 CPXBaseViewController 					用于自定义控制器的所有父类
	 
 	 CPXDataViewController CPXBaseViewController的父类
 	 	内部常用属性
 	 		tableView /**<默认tableview（采用懒加载形式创建）*/
 	 		netConfigmodel /**<网络请求配置model*/
 	 		
 	 CPXCommonViewController CPXDataViewController的父类
 	 		内部已处理：
 	 		导航栏返回按钮 - (void)initLeftBackNaviButton
 	 		导航栏顶部透明色 - (void)initDefaultNavigation
 	 		
### BaseModel
	CPXBaseModel 所有自定义Model的父类
	
### Configration
	GlobalDefine.h  		常用的一些占位图与通用展示文字文件
	GlobalPCH.pch 			用于引入BaseLib库
	Import.h			用于导入创建爱的自定义类、CateGory、Exrension、第三方工具类
	IphoneXConfig.h			用于iPhone机型的UI适配
	SystemConfig.h			系统版本适配、启动宏、各类通知相关
	UIConfig.h			全局UI配置 颜色设置、app view通用背景颜色、navigationBar颜色、APP主题色等
	
### Categories
	UIBarButtonItem+Badge.h 			用于UIBarButtonItem的角标设置
	UIImage+Color.h					用于color转image、image转color、调整图片方向、图片无损压缩、压缩图片到指定文件大小(kb)、将图片裁剪到制定像素、传入需要的占位图尺寸 获取占位图
	NSDictionary+Basic.h				用于处理不安全字典（null，@“” 等的处理）
	UIScrollView+Basic.h				用于处理取消scrollview刷新、添加头部刷新(自动处理网络请求配置model，关闭菊花的开关以及打开是手动刷新)、添加尾部刷新(自动处理网络请求配置model，关闭菊花的开关以及打开是手动刷新)
	UIButton+Badge.h				用于UIButton的角标设置
	UIButton+ImageTitleSpacing.h			用于设置button的titleLabel和imageView的布局样式，及间距
	UIButton+touch.h				用于处理按钮的暴力点击事件
	UIView+AZGradient.h				用于绘制View渐变色
	UIView+Basic.h					用于绘制不同类型图片圆角
	UIView+GetController.h				用于获取view的所在的controller、获取view所在UITableViewCell、根据点击的视图 、获取当前indexPath
	UIView+Storyboard.h				用于给xib和SB增加额外的属性：边界颜色、边界宽度、圆角
	UINavigation-SXFixSpace文件夹  		      用于处理不同系统导航栏按钮的显示位置、热区范围
	UIBarButtonItem+SXCreate.h			用于处理自定义导航栏按钮带来的偏移以及点击范围等问题
	CPXBaseNavigationController+Smoonth.h 		用于处理平滑处理导航栏侧滑渐变效果
	UITextView+Placeholder.h			用于为UITextView增加 paceHoder属性
	UILabel+init.h					用于UILabel的快速创建方式
	UIImageView+Basic.h				用于异步加载图片
	NSString+AttributedString.h			用于富文本的处理
	NSString+Basic.h				用于不安全的字符串转换为安全字符串、获取字符串的size、字典转字json符串、数组转json字符串、json字符串转数组等
	NSString+STRegex.h				用于正则表达式相关处理
	NSString+timer.h 				用于时间与字符串之间的相互转换之间的处理
	NSArray+Basic.h					处理不安全数组
	NSObject+Basic.h				数据持久化（单列存储）
	
	
### Extensions
	UIViewExt.h					用于调取UIView的坐标
	ColorEx.h					用于扩展颜色的功能
	HJCornerRadius.h				用于高效设置imageView的圆角，避免maskTobounds
	
### NetworkManager
	CPXNetCofig.h					网络层宏文件
	CPXNetworkCache.h				网络层数据缓存类
	CPXBaseNetworkManager.h				Base网络请求Manger（主要处理一些试图交互逻辑的处理）,继承于CPXNetworkManager
	CPXNetworkManager.h 				网络请求，主要处理缓存以及过期问题。对各种请求方法的整合,继承于CPXNetworkHelper
	CPXNetworkHelper.h				用于封装AFN
	
### ThirdPart
	DYModelMaker					字典自动生成模型类：支持多层模型嵌套、自动生成两种框架（MJExtension和YYModel）的系统关键字替换和数组中字典转模型代码
	
### Utls
	CPXAlertUtils.h					MBProgressHUD的封装类
	CommonUtls.h					公用的一些工具：获取当前控制器、快速创建model属性（快速创建网络请求返回的字典的属性）、调起相册或相机进行图片选择等
