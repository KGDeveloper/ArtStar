//
//  KGRequestNetWorking.m
//  ArtStar
//
//  Created by abc on 2018/6/21.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGRequestNetWorking.h"

@implementation KGRequestNetWorking

+ (KGRequestNetWorking *)shareIntance{
    static KGRequestNetWorking *obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!obj) {
            obj = [[KGRequestNetWorking alloc]init];
        }
    });
    return obj;
}

+ (void)postWothUrl:(NSString *)url
         parameters:(NSDictionary *)dic
               succ:(void (^)(id))succ
               fail:(void (^)(NSString *))fail{
    
    AFHTTPSessionManager *manager = [KGRequestNetWorking managerWithBaseUrl:nil sessionConfiguration:NO];
    [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id respond = [KGRequestNetWorking responseConfiguration:responseObject];
        succ(respond);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(@"请求出错");
    }];
}

+ (void)uploadWithUrl:(NSString *)url
           parameters:(NSDictionary *)dic
             fileData:(NSData *)filedata
                 name:(NSString *)name
             fileName:(NSString *)filename
             mimeType:(NSString *)mimetype
             progress:(NSProgress *)progress
                 succ:(void (^)(id))succ
                 fail:(void (^)(NSString *))fail{
    
    AFHTTPSessionManager *manager = [KGRequestNetWorking managerWithBaseUrl:nil sessionConfiguration:NO];
    [manager POST:url parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:filedata name:name fileName:filename mimeType:mimetype];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id respond = [KGRequestNetWorking responseConfiguration:responseObject];
        succ(respond);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(@"请求失败");
    }];
}




//MARK:----------------------------------------------------------------------------------------
+ (AFHTTPSessionManager *)managerWithBaseUrl:(NSString *)baseUrl sessionConfiguration:(BOOL)isconfiguration{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager = nil;
    NSURL *url = [NSURL URLWithString:baseUrl];
    if (isconfiguration) {
        manager = [[AFHTTPSessionManager alloc]initWithBaseURL:url sessionConfiguration:configuration];
    }else{
        manager = [[AFHTTPSessionManager alloc]initWithBaseURL:url];
    }
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    return manager;
}

+ (id)responseConfiguration:(id)responseObject{
    NSString *string = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    return dic;
}






@end
