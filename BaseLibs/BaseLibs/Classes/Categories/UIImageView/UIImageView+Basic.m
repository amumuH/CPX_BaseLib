//
//  UIImageView+ZCImageView.m
//  CPX
//
//  Created by Apple on 2017/7/12.
//  Copyright © 2017年 zhongcaishenghuo. All rights reserved.
//

#import "UIImageView+Basic.h"

@implementation UIImageView (Basic)

-(void)cpx_downloadImage:(NSString *)urlStr{
    [self cpx_downloadImage:urlStr placeholder:loading_ImageName];
}
- (void)cpx_downloadImage:(NSString *)urlStr placeholder:(NSString *)imageName{
        [self sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:imageName] options:SDWebImageRetryFailed|SDWebImageLowPriority];
}
- (void)cpx_downloadImage:(NSString *)urlStr placeholderImage:(UIImage *)image{
    [self sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:image options:SDWebImageRetryFailed|SDWebImageLowPriority];
}

-(void)cpx_downloadImage:(NSString *)urlStr placeholderSize:(CGSize)imageSize{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self cpx_downloadImage:urlStr placeholderImage:[UIImage cpx_placeholderImageWithSize:self.size ImageSize:imageSize]];

    });
}


@end
