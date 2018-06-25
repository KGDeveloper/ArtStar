//
//  LoginUserRongInfo.m
//  ArtStar
//
//  Created by abc on 6/7/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "LoginUserRongInfo.h"

@implementation LoginUserRongInfo

+ (LoginUserRongInfo *)shareInterace{
    static LoginUserRongInfo *obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[LoginUserRongInfo alloc]init];
    });
    return obj;
}

- (NSString *)userId{
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"RongId"];
    return userId;
}

- (NSString *)userTag{
    NSString *userTag = [[NSUserDefaults standardUserDefaults] objectForKey:@"RongTag"];
    return userTag;
}

- (NSString *)userUrl{
    NSString *userUrl = [[NSUserDefaults standardUserDefaults] objectForKey:@"RongUrl"];
    return userUrl;
}

@end
