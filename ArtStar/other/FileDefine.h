//
//  FileDefine.h
//  ArtStar
//
//  Created by KG丿轩帝 on 2018/4/19.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#ifndef FileDefine_h
#define FileDefine_h

#define FZFont(font) [UIFont fontWithName:@"FZYINGXUEJW--GB1-0" size:font]
#define SYBFont(font) [UIFont fontWithName:@"SourceHanSansCN-Bold" size:font]
#define SYFont(font) [UIFont fontWithName:@"SourceHanSansCN-Regular" size:font]
#define Image(image) [UIImage imageNamed:image]

#define Color_333333 [UIColor colorWithHexString:@"#333333"]
#define Color_999999 [UIColor colorWithHexString:@"#999999"]
#define Color_f2f2f2 [UIColor colorWithHexString:@"#f2f2f2"]
#define Color_cccccc [UIColor colorWithHexString:@"#cccccc"]
#define Color_ededed [UIColor colorWithHexString:@"#ededed"]
#define Color_b3b3b3 [UIColor colorWithHexString:@"#b3b3b3"]
#define Color_fafafa [UIColor colorWithHexString:@"#fafafa"]
#define Color_Boy [UIColor colorWithHexString:@"#A9D9F6"]
#define Color_Girl [UIColor colorWithHexString:@"#FFC4C4"]
#define ImageBackColor [UIColor colorWithHexString:@"#f0f0f0"]

#define ViewX(view) view.frame.origin.x
#define ViewY(view) view.frame.origin.y

#define ViewWidth(view) view.frame.size.width
#define ViewHeight(view) view.frame.size.height

#define NavTopHeight (kScreenHeight == 812 ? 88 : 64)
#define NavButtomHeight (kScreenHeight == 812 ? 34 : 0)

#define TabLeViewFootView [[UIView alloc]initWithFrame:CGRectZero]

#define GeocodeApiKey @"e172283179a7520685fe0053ea06a4fd"

#define QiniuAK @"GtoI3GgOSMPciZWop4byiRMAGlvHv2RVvbCUXLYS"
#define QiniuSK @"d7wyhtUIYp7ekQ6vrLGYvGCvfvHePM-YIpe1d82_"
#define QiniuScope @"literarystar"

//MARK:-------------------------------------------话题，图文，视频发布cell高度---------------------------------------------
#define OnlyHaveImageHeight (kScreenWidth - 30)/690*468 + 118
#define OnlyHaveTitleHeight 245
#define TopAndBottomHeight (kScreenWidth - 30)/690*468 + 243
#define LeftAndRightHeight 118 + (kScreenWidth - 155)/450*690
#define talentHeight 238 + (kScreenWidth - 30)/690*468
#define curileImageHeight 513


//MARK:---------------------------------------登录模块-------------------------------------------------
#define serverIP @"http://192.168.1.119:80/"
//#define serverIP @"http://192.168.1.5/"
//#define serverIP @"http://192.168.1.3/"
//MARK:----------------------------------------注册登录------------------------------------------------
/**
 短信发送

 @param 包括自己 短信发送
 @return 短信发送
 */
#define sendMsgAuthCode [serverIP stringByAppendingString:@"sendMsgAuthCode"]
/**
 判断验证码是否正确（只有注册时使用）

 @param 包括自己 判断验证码是否正确（只有注册时使用）
 @return 判断验证码是否正确（只有注册时使用）
 */
#define judgeMsgAuthCode [serverIP stringByAppendingString:@"judgeMsgAuthCode"]
/**
 注册

 @param 包括自己 注册
 @return 注册
 */
#define registServer [serverIP stringByAppendingString:@"regist"]
/**
 登陆

 @param 包括自己 登陆
 @return 登陆
 */
#define loginServer [serverIP stringByAppendingString:@"login"]
/**
 跟新融云token的方法

 @param 包括自己 跟新融云token的方法
 @return 跟新融云token的方法
 */
#define toSetPayrollPwd [serverIP stringByAppendingString:@"toSetPayrollPwd"]
//MARK:--------------------------------------------发布模块--------------------------------------------
/**
 发布朋友圈消息包括动态、话题、和达人
 
 @param 包括自己 发布朋友圈消息包括动态、话题、和达人
 @return 发布朋友圈消息包括动态、话题、和达人
 */
#define ReleaseFriendTimelineAddfriendMessage [serverIP stringByAppendingString:@"ReleaseFriendTimeline/addfriendMessage"]
/**
 发布：我要做达人
 
 @param 包括自己 发布：我要做达人
 @return 发布：我要做达人
 */
#define saveMerchantIssue [serverIP stringByAppendingString:@"Issue/saveMerchantIssue"]
//MARK:---------------------------------------------朋友圈-------------------------------------------
/**
 查询朋友圈消息(自己刷圈）

 @return 查询朋友圈消息(自己刷圈）
 */
#define searchfriendMessages [serverIP stringByAppendingString:@"ReleaseFriendTimeline/searchfriendMessages"]
/**
 朋友圈消息删除

 @param 包括自己 朋友圈消息删除
 @return 朋友圈消息删除
 */
#define deleteFriendMsg [serverIP stringByAppendingString:@"ReleaseFriendTimeline/deleteFriendMsg"]
/**
 查看别人的朋友圈(包括自己)

 @return 查看别人的朋友圈(包括自己)
 */
#define searchOthercfm [serverIP stringByAppendingString:@"ReleaseFriendTimeline/searchOthercfm"]
/**
 点击消息查看详情页

 @return 点击消息查看详情页
 */
#define friendViews [serverIP stringByAppendingString:@"ReleaseFriendTimeline/friendViews"]
/**
 点赞

 @return 点赞
 */
#define firendlikeCount [serverIP stringByAppendingString:@"ReleaseFriendTimeline/firendlikeCount"]
/**
 朋友圈未读消息条数显示的接口

 @return 朋友圈未读消息条数显示的接口
 */
#define friendsunreadMessageCount [serverIP stringByAppendingString:@"ReleaseFriendTimeline/unreadMessageCount"]
/**
 查看未读消息提示

 @return 查看未读消息提示
 */
#define pushUnreadMessages [serverIP stringByAppendingString:@"ReleaseFriendTimeline/pushUnreadMessages"]
/**
 消息评论或者回复评论

 @return 消息评论或者回复评论
 */
#define commentOrReply [serverIP stringByAppendingString:@"friendComment/commentOrReply"]
/**
 点击消息查看详情页

 @return 点击消息查看详情页
 */
#define friendViews [serverIP stringByAppendingString:@"ReleaseFriendTimeline/friendViews"]
/**
 添加收藏的接口

 @return 添加收藏的接口
 */
#define addPersonCollect [serverIP stringByAppendingString:@"personCollect/addPersonCollect"]
/**
 关注

 @return 关注
 */
#define attorcel [serverIP stringByAppendingString:@"attention/attorcel"]
/**
 用户自己发布任务

 @return 用户自己发布任务
 */
#define saveUserTask [serverIP stringByAppendingString:@"task/saveUserTask"]
/**
 查询自己所在城市的任务

 @return 查询自己所在城市的任务
 */
#define checkUserTask [serverIP stringByAppendingString:@"task/checkUserTask"]
/**
 查询自己接收的任务但未完成

 @return 查询自己接收的任务但未完成
 */
#define MyreceptionUserTask [serverIP stringByAppendingString:@"task/MyreceptionUserTask"]
/**
 查询自己接收并且完成的任务

 @return 查询自己接收并且完成的任务
 */
#define MyreceptionOverUserTask [serverIP stringByAppendingString:@"task/MyreceptionOverUserTask"]
/**
 查询自己发布的任务

 @return 查询自己发布的任务
 */
#define MyreceptionAllUserTask [serverIP stringByAppendingString:@"task/MyreceptionAllUserTask"]
/**
 取消任务路径

 @return 取消任务路径
 */
#define delUserTask [serverIP stringByAppendingString:@"task/delUserTask"]
/**
 根据Id 查看任务的详情

 @return 根据Id 查看任务的详情
 */
#define checkOneUserTask [serverIP stringByAppendingString:@"task/checkOneUserTask"]


#endif /* FileDefine_h */
