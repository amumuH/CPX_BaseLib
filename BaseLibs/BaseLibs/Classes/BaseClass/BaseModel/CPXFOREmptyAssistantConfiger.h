//
//  CPXFOREmptyAssistantConfiger.h
//  demo
//
//  Created by CPX on 2018/11/16.
//  Copyright © 2018 CPX. All rights reserved.
//

#import "FOREmptyAssistantConfiger.h"

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSUInteger, FOREmptyAssistantType) {
    
    FOREmptyAssistantTypeNormal = 0,//常规的
    FOREmptyAssistantTypeNetError //网络异常
};


/**
 给占位图新增一些属性，让自定义更方便(不用使用代理)
 */
@interface CPXFOREmptyAssistantConfiger : FOREmptyAssistantConfiger


/**
快速创建一个配置model
  */
+(CPXFOREmptyAssistantConfiger*)creatCofigWithType:(FOREmptyAssistantType)type;


/**
 标题富文本
 */
@property(nonatomic,strong)NSAttributedString *titleAttributedStr;



/**
 描述信息富文本
 */
@property(nonatomic,strong)NSAttributedString *descriptionTitleAttributedStr;

/**
 按钮标题富文本
 */
@property(nonatomic,strong)NSAttributedString *buttonTitleAttributedStr;




@end

NS_ASSUME_NONNULL_END
