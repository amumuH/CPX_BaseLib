//
//  DownViewController.m
//  FunctionDemo
//
//  Created by CPX on 2019/3/7.
//  Copyright © 2019 CPX_22. All rights reserved.
//

#import "DownViewController.h"

@interface DownViewController (){
    NSString  *downLoadUrl;
    NSURL *fileUrl;
    NSURLSessionDownloadTask *task;
    BOOL downLoadIng;
}

/**
 断点下载demo
 */
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progress;

@end

@implementation DownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
}
-(void)initUI{
    self.progress.progress = 0;
    downLoadUrl = @"https://www.apple.com/105/media/cn/iphone-x/2017/01df5b43-28e4-4848-bf20-490c34a926a7/films/feature/iphone-x-feature-cn-20170912_1280x720h.mp4";
    
}
//开始下载
- (IBAction)beginBtn:(id)sender {
    if (downLoadIng) {
        return;
    }
    downLoadIng = YES;
    
    
    task = [CPXBaseNetworkManager AFDownLoadFileWithUrl:downLoadUrl progress:^(CGFloat progress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.progress.progress = progress;
            self.progressLabel.text = [NSString stringWithFormat:@"%.2f/100",progress*100];
        });
    } fileDir:@"downlod_12344.mp4" success:^(NSURL *fileUrlPath, NSURLResponse *response) {
        NSLog(@"下载成功 下载的文档路径是 %@, ",fileUrlPath);

    } failure:^(NSError *error, NSInteger statusCode) {
        NSLog(@"下载失败,下载的data被downLoad工具处理了 ");

    }];
            
            
}

//暂停下载
- (IBAction)pauseBtn:(id)sender {
    //可以在这里存储resumeData ,也可以去QDNetServerDownLoadTool 里面 根据那个通知去处理 都有回调的
    if (downLoadIng) {
        [task cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
            
        }];
    }
    downLoadIng = NO;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
