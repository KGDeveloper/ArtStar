//
//  KGUserInfo.m
//  ArtStar
//
//  Created by abc on 2018/6/27.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGUserInfo.h"

@implementation KGUserInfo

+ (KGUserInfo *)shareInterace{
    static KGUserInfo *obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[KGUserInfo alloc]init];
    });
    return obj;
}

- (NSString *)userPhone{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"userPhone"];
}

@end
