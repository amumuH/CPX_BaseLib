# ios端基础库
* CPX_BaseLib 

ios端组件化开发基本库，所有项目需依赖。（本库只是针对项目作出常用的功能封装以及基本适配处理，有些类可以根据不同项目不同需求再次封装）

#基本规范
为了项目的规范，所以我们在开发的时候需要统一一些方法的命名及方法的使用
1. 初始化方法
* - (void)initUI;/**UI初始话*/
* -(void)initDataSource; /**数据源初始话*/
* - (void)loadData;/**加载数据*/
2.  初始化方法第二级，默认放在initUI下
* - (void)initViews;/**初始化View*/
* - (void)initNavigation;/**初始化导航栏*/
* - (void)initOtherViews;/**初始化其他view*/
3.命名以驼峰原则，以功能名字命名，见名思意，并配上注释。


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
初始化方式 [CPXBaseTableView new] 内部已经处理不同系统版本适配问题

CPXBaseView 用于所有自定义视图的父类
-(CPXBaseViewController*)getViewcontrollerView获取当前的父控制器

### NetworkManager
CPXNetCofig.h                    网络层宏文件
CPXNetworkCache.h                网络层数据缓存类
CPXBaseNetworkManager.h                Base网络请求Manger（主要处理一些试图交互逻辑的处理）,继承于CPXNetworkManager
CPXNetworkManager.h                 网络请求，主要处理缓存以及过期问题。对各种请求方法的整合,继承于CPXNetworkHelper
CPXNetworkHelper.h                用于封装AFN

### ThirdPart
DYModelMaker                    字典自动生成模型类：支持多层模型嵌套、自动生成两种框架（MJExtension和YYModel）的系统关键字替换和数组中字典转模型代码

### Utls
CPXAlertUtils.h                    MBProgressHUD的封装类
CommonUtls.h                    公用的一些工具：获取当前控制器、快速创建model属性（快速创建网络请求返回的字典的属性）、调起相册或相机进行图片选择等
