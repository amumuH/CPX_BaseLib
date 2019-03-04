//
//  NSString+categories.m
//  CPX
//
//  Created by CPX on 2017/5/22.
//  Copyright © 2017年 zhongcaishenghuo. All rights reserved.
//

#import "NSString+Basic.h"

@implementation NSString (Basic)

+(NSString*)cpx_safetyStringByObject:(id)unsafeObj
{
   
    if([unsafeObj isKindOfClass:[NSNull class]]){
        return @"";
    }
    
    //oc语法
    if([unsafeObj isEqual:[NSNull null]])
    {
        return @"";
    }
    //异常NSString
    if([unsafeObj isKindOfClass:[NSString class]]){  //(null)
        NSString* tempStr = (NSString*)unsafeObj;
        if(!tempStr ||  tempStr.length == 0  || [tempStr isEqualToString:@"<null>"] || [tempStr isEqualToString:@"(null)"]|| [tempStr isEqualToString:@"(null)"] || [tempStr isEqualToString:@""] || [tempStr isEqual:[NSNull null]]){
            return @"";
        }
        return tempStr;
    }
    
    if([unsafeObj isKindOfClass:[NSArray class]]){
        return @"";
    }
    if([unsafeObj isKindOfClass:[NSDictionary class]]){
        return @"";
    }
    if ([unsafeObj isKindOfClass:[NSNumber class]]) {
        return [NSString stringWithFormat:@"%@",unsafeObj];
    }
    
    return @"";
}



//#pragma mark 计算字符串大小
- (CGSize)cpx_sizeWithFont:(UIFont *)font
                   maxSize:(CGSize)maxSize
{
    NSDictionary *dict = @{NSFontAttributeName: font};
    CGSize textSize = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return textSize;
}

- (CGSize)cpx_sizeWithFontSize:(CGFloat )fontSize
                       maxSize:(CGSize)maxSize 
{
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:fontSize], NSFontAttributeName,nil, NSForegroundColorAttributeName,nil];
    CGSize textSize = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return textSize;
}



//字典转字符串
+ (NSString*)cpx_stringWithJsonDictionary:(NSDictionary *)dic
{
    if(!dic){
        return @"";
    }
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}


//数组转字符串
+ (NSString *)cpx_StringWithArray:(NSArray *)array
{
    if (!array) {
        return nil;
    }
    NSString *jsonStr = @"[";
    
    for (NSInteger i = 0; i < array.count; ++i) {
        if (i != 0) {
            jsonStr = [jsonStr stringByAppendingString:@","];
        }
        jsonStr = [jsonStr stringByAppendingString:array[i]];
    }
    jsonStr = [jsonStr stringByAppendingString:@"]"];
    
    return jsonStr;
}


//字符串转字典
+ (NSDictionary *)cpx_dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

//字符串转数组
+ (NSArray*)cpx_arrayWithJsonString:(NSString*)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSArray *arr = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return arr;
}

//汉字、英语的拼音
- (NSString *)cpx_pinyin{
    NSMutableString *str = [self mutableCopy];
    CFStringTransform(( CFMutableStringRef)str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    return [[str stringByReplacingOccurrencesOfString:@" " withString:@""] lowercaseString];
}

-(NSAttributedString*)cpx_underLineStyleSingle{
    NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:self attributes:attribtDic];
    return attribtStr;
    
}
-(NSMutableAttributedString*)cpx_centerLineStyleSingle{
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:self attributes:attribtDic];
    return attribtStr;
}

+(NSString * )cpx_americaMoneyFormatter:(NSNumber * )number{
    NSNumberFormatter *moneyFormatter = [[NSNumberFormatter alloc] init];
    moneyFormatter.positiveFormat = @"###,##0";
    NSString *formatString = [moneyFormatter stringFromNumber:number];
    return formatString;
}


+(NSString *)cpx_urlEncode:(NSString * )url_origin{
    NSString *charactersToEscape = @" ";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    NSString * url_string = [url_origin stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    return url_string;
}

@end
