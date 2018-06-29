//
//  FriendsModel.h
//  ArtStar
//
//  Created by abc on 2018/6/29.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendsModel : NSObject

@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSDictionary *user;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *location;
@property (nonatomic,copy) NSString *createTime;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *likeCount;
@property (nonatomic,copy) NSString *rccommentNum;
@property (nonatomic,copy) NSString *type;
@property (nonatomic,copy) NSString *visitPermission;
@property (nonatomic,copy) NSString *composing;
@property (nonatomic,copy) NSArray *images;
@property (nonatomic,copy) NSString *praPrtraitUri;
@property (nonatomic,copy) NSString *rccomment;



@end
