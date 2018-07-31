//
//  MineHttpsDefine.h
//  ArtStar
//
//  Created by 文艺星球 on 2018/7/31.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#ifndef MineHttpsDefine_h
#define MineHttpsDefine_h

//MARK:----------------------------------------个人中心------------------------------------------------
/**
 我的中，查看个人名片
 
 @return 我的中，查看个人名片
 */
#define seachUserInforMore [serverIP stringByAppendingString:@"personalBusinessCard/seachUserInforMore"]
/**
 填写个人资料时,查看我的标签
 
 @return 填写个人资料时,查看我的标签
 */
#define showMyLabels [serverIP stringByAppendingString:@"myLabel/showMyLabels"]
/**
 填写个人资料时，从数据库中查询世界
 
 @return 填写个人资料时，从数据库中查询世界
 */
#define getMyWordByPid [serverIP stringByAppendingString:@"myWord/getMyWordByPid"]
/**
 填写个人资料时，从数据库中查询身体部位
 
 @return 填写个人资料时，从数据库中查询身体部位
 */
#define mineGetAll [serverIP stringByAppendingString:@"BodyPart/getAll"]
/**
 搜索喜欢的书籍
 
 @return 搜索喜欢的书籍
 */
#define likeBookName [serverIP stringByAppendingString:@"userbook/likeBookName"]
/**
 搜索喜欢的音乐
 
 @return 搜索喜欢的音乐
 */
#define likeMusicName [serverIP stringByAppendingString:@"userMusic/likeMusicName"]
/**
 搜索喜欢的电影
 
 @return 搜索喜欢的电影
 */
#define likeMoviceName [serverIP stringByAppendingString:@"userMovice/likeMoviceName"]
/**
 删除图片
 
 @return 删除图片
 */
#define deleteImage [serverIP stringByAppendingString:@"image/deleteImage"]
/**
 删除我的标签
 
 @return 删除我的标签
 */
#define deleteMyLabel [serverIP stringByAppendingString:@"myLabel/deleteMyLabel"]
/**
 删除喜欢的行业
 
 @return 删除喜欢的行业
 */
#define industrydeleteByid [serverIP stringByAppendingString:@"industry/deleteByid"]
/**
 获取七牛云token
 
 @return 获取七牛云token
 */
#define qiniuToken [serverIP stringByAppendingString:@"ReleaseFriendTimeline/searchreturnToken"]
/**
 获取融云用户信息
 
 @return 获取融云用户信息
 */
#define rongUserID [serverIP stringByAppendingString:@"user/getInforById"]
/**
 删除我的世界
 
 @return 删除我的世界
 */
#define deleteMyWord [serverIP stringByAppendingString:@"myWord/deleteMyWord"]
/**
 删除喜欢的电影
 
 @return 删除喜欢的电影
 */
#define deleteMovice [serverIP stringByAppendingString:@"userMovice/deleteMovice"]
/**
 删除喜欢的音乐
 
 @return 删除喜欢的音乐
 */
#define deleteMusic [serverIP stringByAppendingString:@"userMusic/deleteMusic"]
/**
 删除喜欢的书籍
 
 @return 删除喜欢的书籍
 */
#define deleteBook [serverIP stringByAppendingString:@"userbook/deleteBook"]
/**
 编辑/完善个人资料
 
 @return 编辑/完善个人资料
 */
#define editPerBnsCard [serverIP stringByAppendingString:@"personalBusinessCard/editPerBnsCard"]



#endif /* MineHttpsDefine_h */
