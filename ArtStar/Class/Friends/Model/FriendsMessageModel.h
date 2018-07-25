//
//  FriendsMessageModel.h
//  ArtStar
//
//  Created by abc on 2018/7/24.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendsMessageModel : NSObject

@property (nonatomic,copy) NSNumber *ID;
@property (nonatomic,copy) NSNumber *commentId;
@property (nonatomic,copy) NSNumber *uid;
@property (nonatomic,copy) NSDictionary *userInfor;
@property (nonatomic,copy) NSNumber *rfmId;
@property (nonatomic,copy) NSString *createTimeStr;
@property (nonatomic,copy) NSString *createTime;
@property (nonatomic,copy) NSNumber *myselfUid;
@property (nonatomic,copy) NSArray *images;
@property (nonatomic,copy) NSNumber *islikeCount;
@property (nonatomic,copy) NSNumber *status;
@property (nonatomic,copy) NSString *content;

@end
