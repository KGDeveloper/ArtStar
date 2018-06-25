//
//  KGRequestNetWorking.h
//  ArtStar
//
//  Created by abc on 2018/6/21.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KGRequestNetWorking : NSObject

+ (KGRequestNetWorking *)shareIntance;
/**
 普通网络请求

 @param url 请求地址
 @param dic 请求参数
 @param succ 成功返回
 @param fail 失败返回
 */
+ (void)postWothUrl:(NSString *)url
         parameters:(NSDictionary *)dic
               succ:(void(^)(id result))succ
               fail:(void(^)(NSString *error))fail;
/**
 普通上传文件

 @param url 请求地址
 @param dic 请求参数
 @param filedata 文件
 @param name 指定参数名
 @param filename 文件名
 @param mimetype 文件类型
 @param progress 上传进度
 @param succ 成功返回
 @param fail 失败返回
 */
+ (void)uploadWithUrl:(NSString *)url
           parameters:(NSDictionary *)dic
             fileData:(NSData *)filedata
                 name:(NSString *)name
             fileName:(NSString *)filename
             mimeType:(NSString *)mimetype
             progress:(NSProgress *)progress
                 succ:(void(^)(id result))succ
                 fail:(void(^)(NSString *error))fail;




@end
