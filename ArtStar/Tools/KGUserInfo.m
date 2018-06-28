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
- (NSString *)userAge{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"userAge"];
}
- (NSString *)userSex{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"userAge"] integerValue] == 1) {
        return @"男";
    }else if([[[NSUserDefaults standardUserDefaults] objectForKey:@"userAge"] integerValue] == 0){
        return @"女";
    }else{
        return @"保密";
    }
}
- (NSString *)userState{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"state"] integerValue] == 0) {
        return @"在线";
    }else{
        return @"隐身";
    }
}
- (NSString *)userToken{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"userToken"];
}
- (NSString *)userTokenCode{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"userTokenCode"];
}
- (NSString *)userName{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
}
- (NSString *)portraitUri{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"portraitUri"];
}
- (NSString *)userIntroduce{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"userIntroduce"];
}

@end
