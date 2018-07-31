//
//  CommunityExhibitionModel.h
//  ArtStar
//
//  Created by 文艺星球 on 2018/7/31.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommunityExhibitionModel : NSObject

@property (nonatomic,copy) NSNumber *typeID;//
/**
 还有多少天开始
 */
@property (nonatomic,copy) NSString *startday;
@property (nonatomic,copy) NSNumber *pjtype;
@property (nonatomic,copy) NSString *showtime;
@property (nonatomic,copy) NSNumber *ID;//
@property (nonatomic,copy) NSString *commentmax;
@property (nonatomic,copy) NSString *mm;
@property (nonatomic,copy) NSString *day;
@property (nonatomic,copy) NSString *hostunit;
@property (nonatomic,copy) NSString *endtime;
@property (nonatomic,copy) NSString *avgpingfen;
@property (nonatomic,copy) NSString *sid;
@property (nonatomic,copy) NSString *pjList;
@property (nonatomic,copy) NSString *articleList;
@property (nonatomic,copy) NSString *typeName;//
@property (nonatomic,copy) NSString *hh;
@property (nonatomic,copy) NSString *pjsum;
@property (nonatomic,copy) NSString *showname;
@property (nonatomic,copy) NSString *worksList;
@property (nonatomic,copy) NSString *showplace;
@property (nonatomic,copy) NSString *pingfen;
@property (nonatomic,copy) NSString *relatedList;
@property (nonatomic,copy) NSArray *imgList;
@property (nonatomic,copy) NSString *portraitUri;
@property (nonatomic,copy) NSString *longitude;
/**
 即将结束
 */
@property (nonatomic,copy) NSString *endday;
@property (nonatomic,copy) NSString *username;
@property (nonatomic,copy) NSString *pingjia;
@property (nonatomic,copy) NSString *showaddress;
@property (nonatomic,copy) NSString *recommend;
@property (nonatomic,copy) NSString *starttime;
@property (nonatomic,copy) NSString *artistList;
@property (nonatomic,copy) NSString *pjComment;
@property (nonatomic,copy) NSString *pltime;
/**
 已经开始多少天
 */
@property (nonatomic,copy) NSString *daingday;
@property (nonatomic,copy) NSString *latitude;
@property (nonatomic,copy) NSString *showprice;

@end
