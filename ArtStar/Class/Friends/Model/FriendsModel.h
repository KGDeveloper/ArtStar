//
//  FriendsModel.h
//  ArtStar
//
//  Created by abc on 2018/6/29.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendsModel : NSObject

@property (nonatomic,copy) NSNumber *composing;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *createTime;
@property (nonatomic,copy) NSString *createTimeStr;
@property (nonatomic,copy) NSNumber *ID;
@property (nonatomic,copy) NSArray *images;
@property (nonatomic,copy) NSNumber *islikeCount;
@property (nonatomic,copy) NSString *issId;
@property (nonatomic,copy) NSNumber *likeCount;
@property (nonatomic,copy) NSString *location;
@property (nonatomic,copy) NSArray *praPrtraitUri;
@property (nonatomic,copy) NSArray *rccomment;
@property (nonatomic,copy) NSNumber *rccommentNum;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSNumber *type;
@property (nonatomic,copy) NSString *uid;
@property (nonatomic,copy) NSDictionary *user;
@property (nonatomic,copy) NSString *views;
@property (nonatomic,copy) NSNumber *visitPermission;

@end
