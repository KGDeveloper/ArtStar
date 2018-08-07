//
//  MineTalentInfoModel.h
//  ArtStar
//
//  Created by 文艺星球 on 2018/8/6.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MineTalentInfoModel : NSObject

@property (nonatomic,copy) NSString *siteTelephone;
@property (nonatomic,copy) NSString *allTreeByLoop;
@property (nonatomic,copy) NSNumber *audit;
@property (nonatomic,copy) NSNumber *commentCount;
@property (nonatomic,copy) NSString *geoHash;
/**
 标题
 */
@property (nonatomic,copy) NSString *headline;
@property (nonatomic,copy) NSNumber *iId;
@property (nonatomic,copy) NSArray *images;
@property (nonatomic,copy) NSString *issueDate;
@property (nonatomic,assign) double latitude;
@property (nonatomic,assign) double longitude;
@property (nonatomic,copy) NSNumber *likeCount;
/**
 发表时所在位置
 */
@property (nonatomic,copy) NSString *location;
/**
 地址
 */
@property (nonatomic,copy) NSString *siteAddress;
/**
 介绍
 */
@property (nonatomic,copy) NSString *siteIntroduce;
/**
 机构名称
 */
@property (nonatomic,copy) NSString *siteName;
@property (nonatomic,copy) NSString *siteVideo;
@property (nonatomic,copy) NSNumber *uid;
@property (nonatomic,copy) NSDictionary *user;

@end
