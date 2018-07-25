//
//  KGQiniuUploadManager.h
//  ArtStar
//
//  Created by abc on 2018/7/3.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KGQiniuUploadManager : NSObject

+ (KGQiniuUploadManager *)shareInstance;

- (void)uploadImageToQiniuWithFile:(NSString *)filePath fileName:(NSString *)fileName result:(void(^)(NSString *strPath))uploadData;
- (void)uploadDataToQiniuWithData:(NSURL *)url result:(void(^)(NSString *strPath))uploadData;
- (NSString *)getImagePath:(UIImage *)Image;

@end
