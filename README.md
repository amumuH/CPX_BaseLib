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
	 CPXBaseNavigationController 基类UINavigationController控制器
	 CPXBaseTabBarController 基类UITabBarController控制器
	 CPXBaseViewController 用于自定义控制器的所有父类
	 
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
	GlobalDefine.h  	常用的一些占位图与通用展示文字文件
	GlobalPCH.pch 	用于引入BaseLib库
	Import.h			用于导入创建爱的自定义类、CateGory、Exrension、第三方工具类
	IphoneXConfig.h	用于iPhone机型的UI适配
	SystemConfig.h	系统版本适配、启动宏、各类通知相关
	UIConfig.h		全局UI配置 颜色设置、app view通用背景颜色、navigationBar颜色、APP主题色等
	 

	 
	 