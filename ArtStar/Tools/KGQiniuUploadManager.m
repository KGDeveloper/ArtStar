//
//  KGQiniuUploadManager.m
//  ArtStar
//
//  Created by abc on 2018/7/3.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGQiniuUploadManager.h"

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

@end
