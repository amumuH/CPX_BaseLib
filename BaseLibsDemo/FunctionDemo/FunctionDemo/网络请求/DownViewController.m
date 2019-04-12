//
//  DownViewController.m
//  FunctionDemo
//
//  Created by CPX on 2019/3/7.
//  Copyright © 2019 CPX_22. All rights reserved.
//

#import "DownViewController.h"
#import "ZipArchive.h"

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
//    [self archieve];
    
}
-(void)archieve{
  MBProgressHUD *hub  = [CPXAlertUtils loading:@"解压中" toView:self.view];
    NSString *fileDir = @"downlodM213P311.zip";
    NSString *localPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 要检查的文件目录
    NSString *zipPath = [localPath  stringByAppendingPathComponent:fileDir ? fileDir : @"Download"];//下载的zip包存放路径
    //解压文件存放路径
    NSString *finishPath =[localPath  stringByAppendingPathComponent:[fileDir stringByReplacingOccurrencesOfString:@".zip" withString:@""]];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [SSZipArchive unzipFileAtPath:zipPath toDestination:finishPath progressHandler:^(NSString * _Nonnull entry, unz_file_info zipInfo, long entryNumber, long total) {
            
        } completionHandler:^(NSString * _Nonnull path, BOOL succeeded, NSError * _Nullable error) {
            
        }] ;
        //解压完成 删除压缩包
//        NSFileManager *fileManager = [NSFileManager defaultManager];
        //        [fileManager removeItemAtPath:zipPath error:nil];
        //回到主线程
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [CPXAlertUtils stopLoading:hub message:@"解压完成"];

        });
    });
    //解压zip文件

    
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
    } fileDir:@"downlodM213P33.mp4" success:^(NSURL *fileUrlPath, NSURLResponse *response) {
        NSLog(@"下载成功 下载的文档路径是 %@, ",fileUrlPath);
//        [self archieve];


    } failure:^(NSError *error, NSInteger statusCode) {
        NSLog(@"下载失败,下载的data被downLoad工具处理了 ");
        //Code=28 "No space left on device

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
