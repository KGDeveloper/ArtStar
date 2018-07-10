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

#define ViewX(view) view.frame.origin.x
#define ViewY(view) view.frame.origin.y

#define ViewWidth(view) view.frame.size.width
#define ViewHeight(view) view.frame.size.height

#define NavTopHeight (kScreenHeight == 812 ? 88 : 64)
#define NavButtomHeight (kScreenHeight == 812 ? 34 : 0)

#define TabLeViewFootView [[UIView alloc]initWithFrame:CGRectZero]

#define GeocodeApiKey @"446c203cd06fabadbfc26884db375281"
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
//#define serverIP @"http://192.168.1.13/"
//#define serverIP @"http://192.168.1.4/"
//MARK:----------------------------------------注册登录------------------------------------------------
#define sendMsgAuthCode [serverIP stringByAppendingString:@"sendMsgAuthCode"]
#define judgeMsgAuthCode [serverIP stringByAppendingString:@"judgeMsgAuthCode"]
#define registServer [serverIP stringByAppendingString:@"regist"]
#define loginServer [serverIP stringByAppendingString:@"login"]
#define toSetPayrollPwd [serverIP stringByAppendingString:@"toSetPayrollPwd"]
//MARK:-----------------------------------------社区-----------------------------------------------
#define communityServer [serverIP stringByAppendingString:@"community/ntvBynews"]
#define friendComment [serverIP stringByAppendingString:@"friendComment/commentOrReply"]
#define newsSearch [serverIP stringByAppendingString:@"community/newsSearch"]
#define hotSearch [serverIP stringByAppendingString:@"community/hotSearch"]
#define oldSearch [serverIP stringByAppendingString:@"community/oldSearch"]
#define deleteSearchNews [serverIP stringByAppendingString:@"community/deleteSearchNews"]
#define selectNewsByUid [serverIP stringByAppendingString:@"community/selectNewsByUid"]
#define commentNews [serverIP stringByAppendingString:@"community/commentNews"]
#define commentNewsByUid [serverIP stringByAppendingString:@"community/commentNewsByUid"]
#define closeNewsByNid [serverIP stringByAppendingString:@"community/closeNewsByNid"]
#define ntvByTopic [serverIP stringByAppendingString:@"community/ntvByTopic"]

//MARK:-------------------------------------------个人中心---------------------------------------------
#define editPerBnsCard [serverIP stringByAppendingString:@"personalBusinessCard/editPerBnsCard"]

//MARK:--------------------------------------------发布模块--------------------------------------------
#define ReleaseFriendTimelineAddfriendMessage [serverIP stringByAppendingString:@"ReleaseFriendTimeline/addfriendMessage"]

//MARK:---------------------------------------------朋友圈-------------------------------------------
/**
 查询朋友圈消息(自己刷圈）

 @return 查询朋友圈消息(自己刷圈）
 */
#define searchfriendMessages [serverIP stringByAppendingString:@"ReleaseFriendTimeline/searchfriendMessages"]
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
 我的中，查看个人名片

 @return 我的中，查看个人名片
 */
#define seachUserInforMore [serverIP stringByAppendingString:@"personalBusinessCard/seachUserInforMore"]









#endif /* FileDefine_h */
