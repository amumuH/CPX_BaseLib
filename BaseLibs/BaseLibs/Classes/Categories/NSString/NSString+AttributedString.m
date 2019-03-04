//
//  NSString+AttributedString.m
//  QIANSIYUAN
//
//  Created by lianyou wang on 2016/12/23.
//  Copyright © 2016年 lianyou wang. All rights reserved.
//

#import "NSString+AttributedString.h"

@implementation NSString (AttributedString)

-(NSAttributedString*)underLineStyleSingle{
      NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:self attributes:attribtDic];
    return attribtStr;

}
-(NSMutableAttributedString*)centerLineStyleSingle{
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:self attributes:attribtDic];
    return attribtStr;
}

@end
