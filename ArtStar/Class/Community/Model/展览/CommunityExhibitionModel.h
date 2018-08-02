//
//  CommunityExhibitionModel.h
//  ArtStar
//
//  Created by 文艺星球 on 2018/7/31.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommunityExhibitionModel : NSObject

/**
 类别ID
 */
@property (nonatomic,copy) NSNumber *typeID;//
/**
 还有多少天开始
 */
@property (nonatomic,copy) NSString *startday;
/**
 当前用户的评价状态
 */
@property (nonatomic,copy) NSNumber *pjtype;
/**
 展览时间
 */
@property (nonatomic,copy) NSString *showtime;
@property (nonatomic,copy) NSNumber *ID;//
/**
 评分最高
 */
@property (nonatomic,copy) NSString *commentmax;
@property (nonatomic,copy) NSString *mm;
@property (nonatomic,copy) NSString *day;
/**
 主办单位
 */
@property (nonatomic,copy) NSString *hostunit;
/**
 展览结束时间
 */
@property (nonatomic,copy) NSString *endtime;
/**
 评分
 */
@property (nonatomic,copy) NSNumber *avgpingfen;
@property (nonatomic,copy) NSString *sid;
@property (nonatomic,copy) NSArray *pjList;
/**
 文章集合
 */
@property (nonatomic,copy) NSArray *articleList;
/**
 类别名称
 */
@property (nonatomic,copy) NSString *typeName;//
@property (nonatomic,copy) NSString *hh;
/**
 对展馆的评价总数
 */
@property (nonatomic,copy) NSNumber *pjsum;
/**
 展览标题
 */
@property (nonatomic,copy) NSString *showname;
/**
 作品集合
 */
@property (nonatomic,copy) NSArray *worksList;
/**
 展览场所
 */
@property (nonatomic,copy) NSString *showplace;
@property (nonatomic,copy) NSString *pingfen;
/**
 相关集合
 */
@property (nonatomic,copy) NSArray *relatedList;
/**
 展览介绍图集
 */
@property (nonatomic,copy) NSArray *imgList;
@property (nonatomic,copy) NSString *portraitUri;
/**
 展馆经度
 */
@property (nonatomic,copy) NSString *longitude;
/**
 即将结束
 */
@property (nonatomic,copy) NSString *endday;
@property (nonatomic,copy) NSString *username;
@property (nonatomic,copy) NSString *pingjia;
/**
 展览地址
 */
@property (nonatomic,copy) NSString *showaddress;
/**
 展览介绍
 */
@property (nonatomic,copy) NSString *recommend;
/**
 展览开始时间
 */
@property (nonatomic,copy) NSString *starttime;
/**
 艺术家集合
 */
@property (nonatomic,copy) NSArray *artistList;
/**
 评价对象
 */
@property (nonatomic,copy) NSString *pjComment;
/**
 评论时间
 */
@property (nonatomic,copy) NSString *pltime;
/**
 已经开始多少天
 */
@property (nonatomic,copy) NSString *daingday;
/**
 展馆维度
 */
@property (nonatomic,copy) NSString *latitude;
/**
 展览价格
 */
@property (nonatomic,copy) NSString *showprice;

@end
