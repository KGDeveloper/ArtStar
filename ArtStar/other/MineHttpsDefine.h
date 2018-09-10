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
/**
 用户查询自己的积分明细

 @return 用户查询自己的积分明细
 */
#define findAllUserIntegral [serverIP stringByAppendingString:@"Collect/findAllUserIntegral"]
/**
  做达人审核中的数据

 @return  做达人审核中的数据
 */
#define checkunderReviewIssue [serverIP stringByAppendingString:@"mytalent/checkunderReviewIssue"]
/**
 做达人审核通过的数据

 @return 做达人审核通过的数据
 */
#define checkPassIssue [serverIP stringByAppendingString:@"mytalent/checkPassIssue"]
/**
 做达人审核未通过的数据

 @return 做达人审核未通过的数据
 */
#define checkNoPassIssue [serverIP stringByAppendingString:@"mytalent/checkNoPassIssue"]
/**
 改变做达人发布的信息，在审核中的信息变为审核失败

 @return 改变做达人发布的信息，在审核中的信息变为审核失败
 */
#define UpdateunderReviewIssue [serverIP stringByAppendingString:@"mytalent/UpdateunderReviewIssue"]
/**
 批量删除从朋友圈的发布记录表中查出审核通过的达人发布

 @return 批量删除从朋友圈的发布记录表中查出审核通过的达人发布
 */
#define deletePassIssue [serverIP stringByAppendingString:@"mytalent/deletePassIssue"]
/**
 星球认证中的身份认证

 @return 星球认证中的身份认证
 */
#define celestialBodyAttestation [serverIP stringByAppendingString:@"mytalent/celestialBodyAttestation"]
/**
 对星球认证的数据进行保存

 @return 对星球认证的数据进行保存
 */
#define saveCelestialBodyAttestation [serverIP stringByAppendingString:@"mytalent/saveCelestialBodyAttestation"]
/**
 接收页面传过来的密码去数据库查询该密码是否正确

 @return 接收页面传过来的密码去数据库查询该密码是否正确
 */
#define checkPasswords [serverIP stringByAppendingString:@"Setting/checkPasswords"]
/**
 接收页面的验证码，判断验证码是否正确

 @return 接收页面的验证码，判断验证码是否正确
 */
#define SendVerificationNumbers [serverIP stringByAppendingString:@"Setting/SendVerificationNumbers"]
/**
 对用户密码进行修改

 @return 对用户密码进行修改
 */
#define SendPassWords [serverIP stringByAppendingString:@"Setting/SendPassWords"]
/**
 对反馈进行保存

 @return 对反馈进行保存
 */
#define AddRetroactions [serverIP stringByAppendingString:@"Setting/AddRetroactions"]
/**
 我的——通讯录

 @return 我的——通讯录
 */
#define findAllUserAssociated [serverIP stringByAppendingString:@"Collect/findAllUserAssociated"]
/**
 积分的首页

 @return 积分的首页
 */
#define findUserIntegral [serverIP stringByAppendingString:@"Collect/findUserIntegral"]
/**
 发布记录

 @return 发布记录
 */
#define seachIssueRecord [serverIP stringByAppendingString:@"issueRecord/seachIssueRecord"]
/**
 设置好友的备注

 @return 设置好友的备注
 */
#define friendRemarks [serverIP stringByAppendingString:@"Collect/friendRemarks"]
/**
 关注

 @return 关注
 */
#define attorcel [serverIP stringByAppendingString:@"attention/attorcel"]
/**
 删除发布记录（批量删除和单个删除）

 @return 删除发布记录（批量删除和单个删除）
 */
#define deleteIssueRecord [serverIP stringByAppendingString:@"issueRecord/deleteIssueRecord"]
/**
 查询收藏

 @return 查询收藏
 */
#define seachPersonCollect [serverIP stringByAppendingString:@"personCollect/seachPersonCollect"]
/**
 删除收藏

 @return 删除收藏
 */
#define deletePersonCollectByid [serverIP stringByAppendingString:@"personCollect/deletePersonCollectByid"]
/**
 改变用户在线状态

 @return 改变用户在线状态
 */
#define updateState [serverIP stringByAppendingString:@"user/updateState"]
/**
 当前用户是否关注对方用户和当前用户对对方用户设置朋友圈权限的标识，聊天界面中跳到的管理界面需要调用此接口
 */
#define seachIsattOrFCPermissions [serverIP stringByAppendingString:@"FriendCirclePermissions/seachIsattOrFCPermissions"]
/**
 设置朋友圈权限的接口
 */
#define setFriendCirclePermissions [serverIP stringByAppendingString:@"FriendCirclePermissions/setFriendCirclePermissions"]
///文化场所首页
#define findAllMerchant [serverIP stringByAppendingString:@"merchants/findAllMerchant"]
///根据指定位置来查询附近的商家
#define findPlaceMerchants [serverIP stringByAppendingString:@"merchants/findPlaceMerchants"]
///查询有新品上市的商家
#define findmerchantsNewProduct [serverIP stringByAppendingString:@"merchants/findmerchantsNewProduct"]
////展示能够接受预定的商家
#define findReservemerchants [serverIP stringByAppendingString:@"merchants/findReservemerchants"]
///根据商家的评分来降序展示商家
#define findmerchantsScore [serverIP stringByAppendingString:@"merchants/findmerchantsScore"]
///根据商家的人均消费来升序展示商家
#define findMerchantAverageConsumption [serverIP stringByAppendingString:@"merchants/findMerchantAverageConsumption"]
//根据指定商家类型来查询附近相同类型的商家
#define findPreciseMerchant [serverIP stringByAppendingString:@"merchants/findPreciseMerchant"]

///文艺消费
#define findAllMerchants [serverIP stringByAppendingString:@"consumption/findAllMerchants"]
//根据用户指定的位置去查询附近的商家
#define findConsumptionPlaceMerchants [serverIP stringByAppendingString:@"consumption/findPlaceMerchants"]
//根据类型查询
#define findConsumptionPreciseMerchant [serverIP stringByAppendingString:@"consumption/findPreciseMerchant"]
//#define findConsumptionPlaceMerchants [serverIP stringByAppendingString:@"consumption/findPlaceMerchants"]
//#define findConsumptionPlaceMerchants [serverIP stringByAppendingString:@"consumption/findPlaceMerchants"]
//#define findConsumptionPlaceMerchants [serverIP stringByAppendingString:@"consumption/findPlaceMerchants"]


#endif /* MineHttpsDefine_h */
