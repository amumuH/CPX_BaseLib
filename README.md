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
	 可通过
	 -(CPXBaseViewController*)getViewcontrollerView获取当前的父控制器
	 
	 