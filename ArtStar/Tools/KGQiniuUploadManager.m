//
//  KGQiniuUploadManager.m
//  ArtStar
//
//  Created by abc on 2018/7/3.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGQiniuUploadManager.h"
#include <CommonCrypto/CommonHMAC.h>
#include <CommonCrypto/CommonDigest.h>
#import <AVFoundation/AVFoundation.h>

@interface KGQiniuUploadManager ()

@end

@implementation KGQiniuUploadManager

+ (KGQiniuUploadManager *)shareInstance{
    static KGQiniuUploadManager *obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!obj) {
            obj = [[KGQiniuUploadManager alloc]init];
        }
    });
    return obj;
}


- (void)uploadImageToQiniuWithFile:(NSString *)filePath fileName:(NSString *)fileName result:(void(^)(NSString *strPath))uploadData{
    
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    QNUploadOption *uploadOption = [[QNUploadOption alloc] initWithMime:nil progressHandler:^(NSString *key, float percent) {
        NSLog(@"上传进度：%f",percent);
    }
                                                                 params:nil
                                                               checkCrc:NO
                                                     cancellationSignal:nil];
    
    [KGRequestNetWorking postWothUrl:qiniuToken parameters:@{} succ:^(id result) {
        if ([result[@"code"] integerValue] == 200) {
            NSArray *arr = result[@"data"];
            NSDictionary *dic = [arr firstObject];
            [upManager putFile:filePath key:[[NSString alloc] initWithFormat:@"%@.png",[self getNowTimestamp]] token:dic[@"tokencode"] complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                if (info.statusCode == 200) {
                    NSString *path = @"http://pdyasqvph.bkt.clouddn.com/";
                    path = [path stringByAppendingString:resp[@"key"]];
                    uploadData(path);
                }
            } option:uploadOption];
        }
    } fail:^(NSError *error) {
        
    }];
}

- (void)uploadDataToQiniuWithData:(NSURL *)url result:(void(^)(NSString *strPath))uploadData{
    NSString *failName = [NSString stringWithFormat:@"%@.mp4",[self getNowTimestamp]];
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    QNUploadOption *uploadOption = [[QNUploadOption alloc] initWithMime:nil progressHandler:^(NSString *key, float percent) {
        //MARK:------------------------------------------在这里获取上传进度----------------------------------------------
    }
                                                                 params:nil
                                                               checkCrc:NO
                                                     cancellationSignal:nil];
    
    [KGRequestNetWorking postWothUrl:qiniuToken parameters:@{} succ:^(id result) {
        if ([result[@"code"] integerValue] == 200) {
            NSArray *arr = result[@"data"];
            NSDictionary *dic = [arr firstObject];
            NSData *videoData = [NSData dataWithContentsOfURL:url];
            [upManager putData:videoData key:failName token:dic[@"tokencode"] complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                if (info.statusCode == 200) {
                    NSString *path = @"http://pdyasqvph.bkt.clouddn.com/";
                    path = [path stringByAppendingString:resp[@"key"]];
                    uploadData(path);
                }
            } option:uploadOption];
        }
    } fail:^(NSError *error) {
        
    }];
}

//照片获取本地路径转换
- (NSString *)getImagePath:(UIImage *)Image{
    NSString *filePath = nil;
    NSData *data = nil;
    if (UIImagePNGRepresentation(Image) == nil) {
        data = UIImageJPEGRepresentation(Image, 1.0);
    } else {
        data = UIImagePNGRepresentation(Image);
    }
    
    //图片保存的路径
    //这里将图片放在沙盒的documents文件夹中
    NSString *DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    //文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //把刚刚图片转换的data对象拷贝至沙盒中
    [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
    NSString *ImagePath = [[NSString alloc] initWithFormat:@"/%@.png",[self getNowTimestamp]];
    [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:ImagePath] contents:data attributes:nil];
    
    //得到选择后沙盒中图片的完整路径
    filePath = [[NSString alloc] initWithFormat:@"%@%@",DocumentsPath, ImagePath];
    return filePath;
}

- (NSString *)getNowTimestamp{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss SSS"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSString *timeSp = [NSString stringWithFormat:@"%u%ld",arc4random_uniform(100),(long)[datenow timeIntervalSince1970]*1000];
    
    return timeSp;
    
}

@end
