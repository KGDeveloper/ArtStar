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
#import "GTMBase64.h"
#import "GTMDefines.h"
#import "Common.h"
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
        //MARK:------------------------------------------在这里获取上传进度----------------------------------------------
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
                    NSString *path = @"http://pbl758zx4.bkt.clouddn.com/";
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
                    NSString *path = @"http://pbl758zx4.bkt.clouddn.com/";
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

//- (NSString *)makeToken:(NSString *)accessKey secretKey:(NSString *)secretKey
//{
//    const char *secretKeyStr = [secretKey UTF8String];
//
//    NSString *policy = [self marshal];
//
//    NSData *policyData = [policy dataUsingEncoding:NSUTF8StringEncoding];
//
//    NSString *encodedPolicy = [GTMBase64 stringByWebSafeEncodingData:policyData padded:TRUE];
//    const char *encodedPolicyStr = [encodedPolicy cStringUsingEncoding:NSUTF8StringEncoding];
//
//    char digestStr[CC_SHA1_DIGEST_LENGTH];
//    bzero(digestStr, 0);
//
//    CCHmac(kCCHmacAlgSHA1, secretKeyStr, strlen(secretKeyStr), encodedPolicyStr, strlen(encodedPolicyStr), digestStr);
//
//    NSString *encodedDigest = [GTMBase64 stringByWebSafeEncodingBytes:digestStr length:CC_SHA1_DIGEST_LENGTH padded:TRUE];
//
//    NSString *token = [NSString stringWithFormat:@"%@:%@:%@",  accessKey, encodedDigest, encodedPolicy];
//
//    return token;//得到了token
//}
//- (NSString *)marshal
//{
//    time_t deadline;
//    time(&deadline);//返回当前系统时间
//    deadline += (self.expires > 0) ? self.expires : 3600; // +3600秒,即默认token保存1小时.
//
//    NSNumber *deadlineNumber = [NSNumber numberWithLongLong:deadline];
//
//    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    //users是我开辟的公共空间名（即bucket），aaa是文件的key，
//    //按七牛“上传策略”的描述：    <bucket>:<key>，表示只允许用户上传指定key的文件。在这种格式下文件默认允许“修改”，若已存在同名资源则会被覆盖。如果只希望上传指定key的文件，并且不允许修改，那么可以将下面的 insertOnly 属性值设为 1。
//    //所以如果参数只传users的话，下次上传key还是aaa的文件会提示存在同名文件，不能上传。
//    //传users:aaa的话，可以覆盖更新，但实测延迟较长，我上传同名新文件上去，下载下来的还是老文件。
//    [dic setObject:@"literarystar" forKey:@"scope"];//根据
//
//    [dic setObject:deadlineNumber forKey:@"deadline"];
//
//    NSString *json = [dic mj_JSONString];
//
//    return json;
//}

@end
