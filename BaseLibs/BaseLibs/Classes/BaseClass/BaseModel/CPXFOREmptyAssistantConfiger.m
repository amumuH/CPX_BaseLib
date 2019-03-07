//
//  CPXFOREmptyAssistantConfiger.m
//  demo
//
//  Created by CPX on 2018/11/16.
//  Copyright © 2018 CPX. All rights reserved.
//

#import "CPXFOREmptyAssistantConfiger.h"

@implementation CPXFOREmptyAssistantConfiger


#pragma mark - DZNEmptyDataSetSource

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSDictionary *attributes = @{NSFontAttributeName: self.emptyTitleFont,
                                 NSForegroundColorAttributeName: self.emptyTitleColor};    
    
    return  _titleAttributedStr?_titleAttributedStr:  [[NSAttributedString alloc] initWithString:self.emptyTitle ?: @"" attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: self.emptySubtitleFont,
                                 NSForegroundColorAttributeName: self.emptySubtitleColor,
                                 NSParagraphStyleAttributeName: paragraph};
    
    return _descriptionTitleAttributedStr?_descriptionTitleAttributedStr: [[NSAttributedString alloc] initWithString:self.emptySubtitle ?: @"" attributes:attributes];
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
    NSDictionary *attributes = @{NSFontAttributeName: self.emptyTitleFont,
                                 NSForegroundColorAttributeName: self.emptyBtnTitleColor};
    
    return  _buttonTitleAttributedStr?_buttonTitleAttributedStr:  [[NSAttributedString alloc] initWithString:self.emptyBtnTitle ?: @"" attributes:attributes];
    
}

+(CPXFOREmptyAssistantConfiger*)creatCofigWithType:(FOREmptyAssistantType)type{
    
    CPXFOREmptyAssistantConfiger *configer = [CPXFOREmptyAssistantConfiger new];
    switch (type) {
        case FOREmptyAssistantTypeNormal:
            {
                NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:16.0],NSForegroundColorAttributeName: [UIColor lightGrayColor]};
                            //常规的
                configer.titleAttributedStr =  [[NSAttributedString alloc] initWithString:Empty_Title attributes:attributes];
                configer.emptyImage = [UIImage imageNamed:Empty_Image];//空图片
                configer.emptyVerticalOffset = -AUTO_HEIGTH_BASE_IPHONE_6(0);
            }
            break;
        case FOREmptyAssistantTypeNetError:
        {
            //网络异常
            configer.emptyTitle = NetError_Title;
            configer.emptyImage = [UIImage imageNamed:NetErro_Image];
            configer.emptyBtnTitle = @"Try Again";
            configer.emptyBtnTitleColor = [UIColor redColor];
            configer.emptyBtntitleFont = [UIFont systemFontOfSize:20];
        }
            break;
        default:
            break;
    }
    return configer;
}

@end
