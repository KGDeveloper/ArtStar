//
//  KGUserInfo.h
//  ArtStar
//
//  Created by abc on 2018/6/27.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KGUserInfo : NSObject

+ (KGUserInfo *)shareInterace;

- (NSString *)userPhone;
- (NSString *)userAge;
- (NSString *)userSex;
- (NSString *)userState;
- (NSString *)userToken;
- (NSString *)userTokenCode;
- (NSString *)userName;
- (NSString *)portraitUri;
- (NSString *)userIntroduce;
- (NSString *)userID;

@end
