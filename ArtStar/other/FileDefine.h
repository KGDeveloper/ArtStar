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

#define GeocodeApiKey @"12c88a2b6a7130459f81a9545d5a5dfd"

//MARK:-------------------------------------------话题，图文，视频发布cell高度---------------------------------------------
#define OnlyHaveImageHeight (kScreenWidth - 30)/690*468 + 118
#define OnlyHaveTitleHeight 245
#define TopAndBottomHeight (kScreenWidth - 30)/690*468 + 243
#define LeftAndRightHeight 118 + (kScreenWidth - 155)/450*690
#define talentHeight 238 + (kScreenWidth - 30)/690*468
#define curileImageHeight 513


//MARK:---------------------------------------登录模块-------------------------------------------------
//#define serverIP @"http://192.168.1.119:80/"
//#define serverIP @"http://192.168.1.13/"
#define serverIP @"http://192.168.1.4/"

#define sendMsgAuthCode [serverIP stringByAppendingString:@"sendMsgAuthCode"]
#define judgeMsgAuthCode [serverIP stringByAppendingString:@"judgeMsgAuthCode"]
#define registServer [serverIP stringByAppendingString:@"regist"]
#define loginServer [serverIP stringByAppendingString:@"login"]
#define toSetPayrollPwd [serverIP stringByAppendingString:@"toSetPayrollPwd"]
#define communityServer [serverIP stringByAppendingString:@"community/ntvBynews"]
#define ReleaseFriendTimeline [serverIP stringByAppendingString:@"ReleaseFriendTimeline/searchfriendMessages"]
#define firendlikeCount [serverIP stringByAppendingString:@"ReleaseFriendTimeline/firendlikeCount"]
#define ReleaseFriendTimelineunreadMessageCount [serverIP stringByAppendingString:@"ReleaseFriendTimeline/unreadMessageCount"]
#define pushUnreadMessages [serverIP stringByAppendingString:@"ReleaseFriendTimeline/pushUnreadMessages"]
#define friendComment [serverIP stringByAppendingString:@"friendComment/commentOrReply"]






























#endif /* FileDefine_h */
