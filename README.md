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

### BaseVC 
一   CPXBaseNavigationController                 基类UINavigationController控制器(此类中处理了app因为导航栏的侧滑出现假死的情况以及实现了各种代理方法，所以所有的导航栏必须继承此类)
二   CPXBaseTabBarController                 基类UITabBarController控制器（此类是留的一个入口，以便自定义tabBar的时候做一些相应的处理）
三   CPXBaseViewController                     用于自定义控制器的所有父类
1.规范了UI以及data的初始化方法，以及处理了导航栏的统一设置，并留了处理状态栏颜色的api。
2.初始化了一个继承于CPXBaseTableView的tableiview，用于快速创建tableview并为以后的
3.初始化了数据源的一些变量：
@property (nonatomic,strong)NSMutableArray * dataArray;/**<所有带有列表的页面全部使用该数据项*/
@property (nonatomic,assign)BOOL isDownRefresh;/**< 是否是下拉刷新 默认NO*/
@property (nonatomic,assign)int page;/**<分页 默认为0*/
@property (nonatomic,assign)int pageSize;/**<每个分页的数据量长度*/
@property(nonatomic,strong)CPXNetworkManagerModel *netConfigmodel;/**<网络请求配置model*/
4.导航栏的处理：
导航栏返回按钮 - (void)initLeftBackNaviButton
导航栏顶部透明色 - (void)initDefaultNavigation

### BaseModel
CPXBaseModel 所有自定义Model的父类


### Configration
GlobalDefine.h          常用的一些占位图与通用展示文字宏文件
GlobalPCH.pch             用于引入BaseLib库
Import.h            用于导入创建的自定义类、CateGory、Exrension、第三方工具类
IphoneXConfig.h            用于iPhone机型的UI适配
SystemConfig.h            系统版本适配、启动宏、各类通知相关
UIConfig.h            全局UI配置 颜色设置、app view通用背景颜色、navigationBar颜色、APP主题色等

### Categories
UIBarButtonItem+Badge.h 
=     
用于UIBarButtonItem的角标设置（常用属性如下：）
@property (nonatomic) UIColor *badgeBGColor;/**< 背景色*/
@property (nonatomic) UIColor *badgeTextColor;/**< 字体颜色*/
@property (nonatomic) UIFont *badgeFont;/**< 字体*/
@property (nonatomic) CGFloat badgePadding;/**< 间隔*/
@property (nonatomic) CGFloat badgeMinSize;/**< 最小size*/
@property (nonatomic) CGFloat badgeOriginX;/**< x偏移*/
@property (nonatomic) CGFloat badgeOriginY;/**<y偏移 */

UIImage+Color.h    
=

用于color转image、image转color、调整图片方向、图片无损压缩、压缩图片到指定文件大小(kb)、将图片裁剪到制定像素、传入需要的占位图尺寸 获取占位图
+ (UIImage *)cpx_imageWithColor:(UIColor *)color;/**<  color转image*/
+ (UIColor *)cpx_imageTocolor:(UIImage *)image withrect:(CGRect)rect; /**< image转color*/
+ (UIImage*)cpx_fixOrientation:(UIImage*)aImage; /**< UIImagePickerController返回的照片带有方向信息，如果直接上传到服务器的话，可能造成旋转了90°（当手机竖直拍照）的情况。而且如果直接取其jpeg数据，或者将UIImage保存到本地的话，就会丢失这个方向信息，导致下一次读取出来图片就是颠倒的*/
+ cpx_reSizeImageData:(UIImage *)sourceImage
maxImageSize:(CGFloat)maxImageSize
maxSizeWithKB:(CGFloat) maxSize;/**< 图片无损压缩 */
+(NSData *)cpx_compressOriginalImage:(UIImage *)image
toMaxDataSizeKBytes:(CGFloat)size; /**<压缩图片到指定文件大小(kb)*/
+ (UIImage*)cpx_imageByScalingAndCroppingForImage:(UIImage *)sourceImage  Size:(CGSize)targetSize;   /**< 将图片裁剪到制定像素 */
+ (UIImage *)cpx_placeholderImageWithSize:(CGSize)size ImageSize:(CGSize )imageSize; /**< 获取不同尺寸的占位图*/


NSDictionary+Basic.h    用于处理不安全字典（null，@“” 等的处理）    
=

+(NSDictionary*)cpx_safeDictionaryByObject:(id)unsaveObj;
NSDictionary+log.h        
=
用于控制台打印中文（因为网络请求的数据在控制台显示出来是UTF-8格式，只需导入该头文件即可打印中文信息）


UIScrollView+Basic.h    用于处理取消scrollview刷新、添加头部刷新(自动处理网络请求配置model，关闭菊花的开关以及打开是手动刷新)、添加尾部刷新(自动处理网络请求配置model，关闭菊花的开关以及打开是手动刷新)    
=   

-(void)cpx_endRefresh; /**< 取消一切刷新（包括上拉下拉）*/、
-(void)cpx_addHeaderRefresh:(MJRefreshComponentRefreshingBlock)refreshingBlock withModel:(CPXNetworkManagerModel*)netModel; /**< 添加头部刷新(自动处理网络请求配置model，关闭菊花的开关以及打开是手动刷新)*/
-(void)cpx_addFooterRefresh:(MJRefreshComponentRefreshingBlock)refreshingBlock withModel:(CPXNetworkManagerModel*)netModel; /**< 添加尾部刷新(自动处理网络请求配置model，关闭菊花的开关以及打开是手动刷新)*/

UIButton+Badge.h                用于UIButton的角标设置
=     
用于UIBarButtonItem的角标设置（常用属性如下：）
@property (nonatomic) UIColor *badgeBGColor;/**< 背景色*/
@property (nonatomic) UIColor *badgeTextColor;/**< 字体颜色*/
@property (nonatomic) UIFont *badgeFont;/**< 字体*/
@property (nonatomic) CGFloat badgePadding;/**< 间隔*/
@property (nonatomic) CGFloat badgeMinSize;/**< 最小size*/
@property (nonatomic) CGFloat badgeOriginX;/**< x偏移*/
@property (nonatomic) CGFloat badgeOriginY;/**<y偏移 */


UIButton+ImageTitleSpacing.h    用于设置button的titleLabel和imageView的布局样式，及间距
=

其中包括了四种样式
MKButtonEdgeInsetsStyleTop, // image在上，label在下
MKButtonEdgeInsetsStyleLeft, // image在左，label在右
MKButtonEdgeInsetsStyleBottom, // image在下，label在上
MKButtonEdgeInsetsStyleRight // image在右，label在左
- (void)cpx_layoutButtonWithEdgeInsetsStyle:(MKButtonEdgeInsetsStyle)style imageTitleSpace:(CGFloat)space;

UIButton+touch.h    用于处理按钮的暴力点击事件（防止过快重复点击多次触发点击事件，默认0.5秒间隔时间）
=
@property (nonatomic, assign) NSTimeInterval timeInterval;/**设置点击时间间隔*/
@property (nonatomic, assign) BOOL isIgnore;/** 用于设置单个按钮不需要被hook*/

UIButton+TimerFire.h 用于展示倒计时按钮（获取验证码按钮）
=   

-(void)fireForTimerWithTimeCount:(NSInteger)count; /**开始倒计时 */
-(void)setBorderColorAndTitleColor;/**设置按钮边框颜色和圆角、title */
UIView+AZGradient.h     一句代码实现View渐变色

- (void)az_setGradientBackgroundWithColors:(NSArray<UIColor *> *_Nullable)colors locations:(NSArray<NSNumber *> *_Nullable)locations startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint

UIView+Basic.h     主要是高效处理view的圆角以及渐变色问题(响应的layer也添加了对应的api)
=

/** 渐变色方向
- GradientDirectionHorizontal: 水品方向
- GradientDirectionVertical: 垂直方向
*/
typedef NS_ENUM(NSInteger,GradientDirection) {
GradientDirectionHorizontal = 0,
GradientDirectionVertical  
};
-(UIImage *)cpx_screenShotViewWith:(CGRect)rect;/**对屏幕进行截屏 */
- (BOOL)cpx_isDisplayedInScreen;/** 判断view是否在屏幕上 */
-(void)cpx_addPathCorner:(UIRectCorner)corner cornerRadis:(CGFloat)cornerRadis;/**添加贝塞尔圆角--自动布局必须完成布局才能调用 */
-(void)cpx_setCorner:(CGFloat)cornerRadis;/**普通方式切圆角 */
- (void)cpx_roundedCornerWithRadius:(CGFloat)radius cornerColor:(UIColor *)color;/**绘制一个带背景色的圆角 */
- (void)cpx_roundedCornerWithRadius:(CGFloat)radius cornerColor:(UIColor *)color corners:(UIRectCorner)corners;/**绘制一个带背景色的圆角 ,并可以自己选择圆角的位置*/
- (void)cpx_roundedCornerWithCornerRadii:(CGSize)cornerRadii cornerColor:(UIColor *)color corners:(UIRectCorner)corners borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;/** 设置一个带边框的圆角,并可设置边框颜色和宽度，以及圆角背景和位置*/
-(void)cpx_addGradientColorWithColor_begin:(UIColor * )color_begin colorEnd:(UIColor * )color_end   gradientDirection:(GradientDirection)direction;/** 添加渐变色 --- 添加backgourdcolor的形式*/

UIView+GetController.h    用于获取view的所在的controller、获取view所在UITableViewCell、根据点击的视图 、获取当前indexPath    
=

-(UIViewController * )cpx_getSuperControllerOfTheView;/** 获取view的所在的controller*/
-(UITableViewCell * )cpx_getSuperContainerCell;/**获取view所在UITableViewCell */
- (NSIndexPath *)cpx_indexPathInTable:(UITableView *)tableView; /**  根据点击的视图 、获取当前indexPath*/

UIView+Storyboard.h         用于给xib和SB增加额外的属性：边界颜色、边界宽度、圆角
=

@property (nonatomic) IBInspectable UIColor *borderColor;//边界颜色
@property (nonatomic) IBInspectable CGFloat borderWidth;//边界宽度
@property (nonatomic) IBInspectable CGFloat cornerRadius;//圆角

UIBarButtonItem+SXCreate.h      处理自定义导航栏按钮带来的偏移以及点击范围等问题*         
=

+(UIBarButtonItem *)cpx_itemWithTarget:(id)target
action:(SEL)action
image:(UIImage *)image;/**   根据图片生成UIBarButtonItem*/
+(UIBarButtonItem *)cpx_itemWithTarget:(id)target
action:(SEL)action
nomalImage:(UIImage *)nomalImage
higeLightedImage:(UIImage *)higeLightedImage
imageEdgeInsets:(UIEdgeInsets)imageEdgeInsets; /** 根据图片与文字生成UIBarButtonItem*/
+(UIBarButtonItem *)cpx_itemWithTarget:(id)target
action:(SEL)action
title:(NSString *)title
titleEdgeInsets:(UIEdgeInsets)titleEdgeInsets ;/** 根据文字生成UIBarButtonItem*/
+(UIBarButtonItem *)cpx_fixedSpaceWithWidth:(CGFloat)width;   /**用作修正位置的UIBarButtonItem */




CPXBaseNavigationController+Smoonth.h   用于处理平滑处理导航栏侧滑渐变效果（其中给UIViewController添加了两个属性，便于快速设置导航栏透明度以及颜色）
=


@property (nonatomic, assign) CGFloat navBarBgAlpha;//设置导航栏透明度
@property (nonatomic, strong) UIColor *navBarTintColor;//导航栏背景色


UITextView+Placeholder.h        用于为UITextView增加 paceHoder属性（同样适用于xib以及storyboard）
=

@property (nonatomic, readonly) UILabel *placeholderLabel; /**  只读属性*/              
@property (nonatomic, strong) IBInspectable NSString*placeholder;/** 适用于xib以及storyboard */
@property (nonatomic, strong) NSAttributedString *attributedPlaceholder; /** 富文本格式的占位 */
@property (nonatomic, strong) IBInspectable UIColor *placeholderColor;/** 适用于xib以及storyboard */

UILabel+init.h        用于UILabel的快速创建方式
=
+(UILabel *)cpx_LabelWithTextNoFrameText:(NSString *)text backgroundColor:(UIColor *)backgroundColor font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment;/** 快速创建UILabel */
+(UILabel *)cpx_LabelWithTextNoFrameText:(NSString *)text textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment;/** 快速创建UILabel */
+(UILabel *)cpx_LabelWithText:(NSString *)text textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor frame:(CGRect)frame font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment;/** 快速创建UILabel */

UIImageView+Basic.h    用于异步加载图片（对sdwebImage的二次封装）
= 
- (void)cpx_downloadImage:(NSString *)urlStr; /**异步加载图片(默认占位图)  */
- (void)cpx_downloadImage:(NSString *)urlStr placeholder:(NSString *)imageName;/** 异步加载图片（手动设置占位图) */
- (void)cpx_downloadImage:(NSString *)urlStr placeholderImage:(UIImage *)image;/** 异步加载图片（手动设置占位图) */
-(void)cpx_downloadImage:(NSString *)urlStr placeholderSize:(CGSize)imageSize;/** 异步加载图片（手动设置占位图，并可设置占位图大小) */

NSString+AttributedString.h            用于富文本的处理（快速添加富文本属性）
= 
-(NSAttributedString*)underLineStyleSingle;/**  添加下划线*/
-(NSMutableAttributedString*)centerLineStyleSingle; /**添加中划线 */


NSString+Basic.h                用于不安全的字符串转换为安全字符串、获取字符串的size、字典转字json符串、数组转json字符串、json字符串转数组等
=
+(NSString*)cpx_safetyStringByObject:(id)unsafeObj; /** 不安全的字符串转换为安全字符串 */
- (CGSize)cpx_sizeWithFont:(UIFont *)font
maxSize:(CGSize)maxSize;/**获取字符串的宽高  */
- (CGSize)cpx_sizeWithFontSize:(CGFloat )fontSize
maxSize:(CGSize)maxSize; /**获取字符串的宽高  */
+ (NSString*)cpx_stringWithJsonDictionary:(NSDictionary *)dic; /**  字典转字json符串 */
+ (NSString *)cpx_StringWithArray:(NSArray *)array;  /** 数组转json字符串  */
+ (NSDictionary *)cpx_dictionaryWithJsonString:(NSString *)jsonString;/** json字符串转数组 */
+ (NSArray*)cpx_arrayWithJsonString:(NSString*)jsonString;/**  json字符串转数组*/
- (NSString *)cpx_pinyin;/** 汉字的拼音 */
-(NSAttributedString*)cpx_underLineStyleSingle;/** 生成带有下划线的富文本*/
-(NSMutableAttributedString*)cpx_centerLineStyleSingle;/**生成带有中划线的富文本 */
+(NSString * )cpx_americaMoneyFormatter:(NSNumber * )number; /**  美国千分位数字*/
+(NSString *)cpx_urlEncode:(NSString * )url_origin; /** 图片urlEncode  */


NSString+STRegex.h                用于正则表达式相关处理
=
- (BOOL)cpx_isValidEmail; /** 邮箱验证 */
- (BOOL)cpx_isValidPhoneNum;/** 手机号码验证 */
- (BOOL)cpx_isValidCarNo;/** 车牌号验证 */
- (BOOL)cpx_isValidUrl;/** 网址验证 */
- (BOOL)cpx_isValidPostalcode;/** 邮政编码 */
- (BOOL)cpx_isValidChinese;/** 纯汉字 */
- (BOOL)cpx_isValidIP; /** 是否符合IP格式，xxx.xxx.xxx.xxx */
- (BOOL)cpx_isValidIdCardNum; /** 身份证验证 refer to http://blog.csdn.net/afyzgh/article/details/16965107*/ */
- (BOOL)cpx_isValidWithMinLenth:(NSInteger)minLenth
maxLenth:(NSInteger)maxLenth
containChinese:(BOOL)containChinese
firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;/** 是否符合最小长度、最长长度，是否包含中文,首字母是否可以为数字 */
- (BOOL)cpx_isValidWithMinLenth:(NSInteger)minLenth
maxLenth:(NSInteger)maxLenth
containChinese:(BOOL)containChinese
containDigtal:(BOOL)containDigtal
containLetter:(BOOL)containLetter
containOtherCharacter:(NSString *)containOtherCharacter
firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;/** 是否符合最小长度、最长长度，是否包含中文,数字，字母，其他字符，首字母是否可以为数字 */
- (NSString *)cpx_stringByTrimmingBlank;/** 去掉两端空格和换行符 */
- (NSString *)cpx_removeHtmlFormat;/** 去掉html格式 */
- (BOOL)cpx_isValidTaxNo;/** 工商税号 */
- (BOOL)cpx_isIncludingEmoji;/** 判断是否包含emoji */

NSString+timer.h                 用于时间与字符串之间的相互转换之间的处理
=

typedef enum  {
timeStampTypeYMDHMS  = 0,   //年月日时分秒
timeStampTypeYMD,           //年月日
timeStampTypeHMS,            //时分秒
timeStampTypeHM    //时
} timeStampType;
+ (NSString *)cpx_timeWithTimeIntervalString:(NSString *)timeString;/**  时间戳转时间 */
+ (NSString *)cpx_getTimeWithTimeIntervalStr:(NSString *)timeStampStr  timeStampType:(timeStampType)timeStampType;/**   时间戳转时间(自定义样式) */
+ (NSString *)cpx_timeToTurnTheTimestamp;/** 当前日期转时间戳（日期NSDate 转 时间戳NSString） */
+(NSString *)cpx_getCureentTime; /**  获取当前时间字符串 */
+ (NSTimeInterval)cpx_getCurrentTimeValue;/**  获取当前时间字符串 */
+(NSString *)cpx_getCureentTimeWithFormatter:(timeStampType)timeStampType;  /**   获取当前时间字符串（需传入时间样式） */
+(NSString *)cpx_turnTheTimestampString:(NSString*) timeStr;/**   日期字符串转时间戳（NSString转时间戳NSString*/
+(NSMutableArray *)cpx_caculateDiffreceMonthFromDate:(NSString *)fromDate;/**  计算两个日期的相差月数，并返回中间间隔的月份 */
+(NSString *)cpx_getYestodayDate;/**  获取昨天的日期 */
+(NSString *)cpx_timeStrChangeWithTime:(NSInteger)timeNum;/** //将时间(s)转换成时间戳(MM:ss) */

NSArray+Basic.h                    处理不安全数组
=

NSArray+log.h 用于控制台打印中文（因为网络请求的数据在控制台显示出来是UTF-8格式，只需导入该头文件即可打印中文信息）
=

NSObject+Basic.h                数据持久化（单列存储）
=
-(void)cpx_saveValue:(NSString*)key Value:(id)value;/** 存储值 */
-(id)cpx_getValue:(NSString*)key;/** 取值 */
-(void)cpx_setBoolValue:(BOOL)value forKey:(NSString *)key;/**  存储布尔值*/


# Extensions

UIViewExt.h                    用于调取UIView的坐标
=
@property CGPoint origin;  /** 位置 */
@property CGSize size;  /** 大小 */
@property (readonly) CGPoint bottomLeft;  /**坐下  */
@property (readonly) CGPoint bottomRight;  /**  右下*/
@property (readonly) CGPoint topRight;  /** 右上*/
@property CGFloat height;  /** 高 */
@property CGFloat width;  /** 宽 */
@property CGFloat top;  /** 上 */
@property CGFloat left;  /** 左 */
@property CGFloat bottom;  /**下  */
@property CGFloat right;  /** 右 */
@property (nonatomic, assign) CGFloat centerX;/**中心X  */
@property (nonatomic, assign) CGFloat centerY;/** 中心Y */
- (void) moveBy: (CGPoint) delta;/**  移动*/
- (void) scaleBy: (CGFloat) scaleFactor;/** 缩放 */
- (void) fitInSize: (CGSize) aSize;/** 适应 */
- (UIView *)gridViewsCustom:(NSArray *)views inColumn:(NSInteger)column size:(CGSize)cellSize margin:(UIEdgeInsets)margin inRect:(CGRect)rect;/**  */

ColorEx.h        用于扩展颜色的功能
=  
///******************颜色与16进制RGB的转化*******************//

- (NSString *) stringFromColor;  /**将颜色转化为rgb的字符串  */
+ (UIColor *) colorWithString: (NSString *) stringToConvert; /**  将rgb的字符串转为颜色*/ 
- (NSString *) hexStringFromColor; /** 将16进制颜色转换为rgb字符串 */ 
+ (UIColor *) colorWithHexStringBeta: (NSString *) stringToConvert;/** 将16进制字符串转为颜色 */
+ (UInt32) RGBWithString: (NSString *) stringToRGB;/** 将rgb字符串转为UInt 32 rgb */
+ (UIColor *) colorWithHexString: (NSString *) stringToConvert;/** 将16进制字符串转为color */
HJCornerRadius.h                用于高效设置imageView的圆角，避免maskTobounds
=
@property (nonatomic, assign) CGFloat aliCornerRadius;/** 圆角数 */

/**  */
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
