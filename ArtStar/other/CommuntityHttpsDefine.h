//
//  CommuntityHttpsDefine.h
//  ArtStar
//
//  Created by 文艺星球 on 2018/7/31.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#ifndef CommuntityHttpsDefine_h
#define CommuntityHttpsDefine_h

//MARK:-----------------------------------------社区-----------------------------------------------
/**
 根据前台传过来的用户ID和类别名称查出对应的新闻的集合
 
 @param 包括自己 根据前台传过来的用户ID和类别名称查出对应的新闻的集合
 @return 根据前台传过来的用户ID和类别名称查出对应的新闻的集合
 */
#define communityServer [serverIP stringByAppendingString:@"community/ntvBynews"]
/**
 新闻搜索
 
 @param 包括自己 新闻搜索
 @return 新闻搜索
 */
#define newsSearch [serverIP stringByAppendingString:@"community/newsSearch"]
/**
 新闻热搜词展示5个
 
 @param 包括自己 新闻热搜词展示5个
 @return 新闻热搜词展示5个
 */
#define hotSearch [serverIP stringByAppendingString:@"community/hotSearch"]
/**
 新聞历史搜索
 
 @param 包括自己 新聞历史搜索
 @return 新聞历史搜索
 */
#define oldSearch [serverIP stringByAppendingString:@"community/oldSearch"]
/**
 新闻清空历史搜索
 
 @param 包括自己 新闻清空历史搜索
 @return 新闻清空历史搜索
 */
#define deleteSearchNews [serverIP stringByAppendingString:@"community/deleteSearchNews"]
/**
 点击查看新闻详情
 
 @param 包括自己 点击查看新闻详情
 @return 点击查看新闻详情
 */
#define selectNewsByUid [serverIP stringByAppendingString:@"community/selectNewsByUid"]
/**
 根据新闻ID查出评论
 
 @param 包括自己 根据新闻ID查出评论
 @return 根据新闻ID查出评论
 */
#define commentNews [serverIP stringByAppendingString:@"community/commentNews"]
/**
 评论新闻
 
 @param 包括自己 评论新闻
 @return 评论新闻
 */
#define commentNewsByUid [serverIP stringByAppendingString:@"community/commentNewsByUid"]
/**
 关闭新闻
 
 @param 包括自己 关闭新闻
 @return 关闭新闻
 */
#define closeNewsByNid [serverIP stringByAppendingString:@"community/closeNewsByNid"]
/**
 根据前台传过来的类别名称查出对应的话题的集合
 
 @param 包括自己 根据前台传过来的类别名称查出对应的话题的集合
 @return 根据前台传过来的类别名称查出对应的话题的集合
 */
#define ntvByTopic [serverIP stringByAppendingString:@"community/ntvByTopic"]
/**
 根据类别名称查出对应的展览
 
 @param 包括自己 根据类别名称查出对应的展览
 @return 根据类别名称查出对应的展览
 */
#define selectSlistByTypename [serverIP stringByAppendingString:@"community/selectSlistByTypename"]
/**
 新闻下根据评论ID点赞

 @return 新闻下根据评论ID点赞
 */
#define dianComment [serverIP stringByAppendingString:@"community/dianComment"]
/**
 回复评论

 @return 回复评论
 */
#define commentByUid [serverIP stringByAppendingString:@"community/commentByUid"]
/**
 新闻举报反馈

 @return 新闻举报反馈
 */
#define addBackPinglun [serverIP stringByAppendingString:@"community/addBackPinglun"]
/**
 根据前台传过来的用户ID和用户对话题的关系值查询对应的话题集合

 @return 根据前台传过来的用户ID和用户对话题的关系值查询对应的话题集合
 */
#define utBytopic [serverIP stringByAppendingString:@"community/utBytopic"]
/**
 社区话题搜索

 @return 社区话题搜索
 */
#define topicSearch [serverIP stringByAppendingString:@"community/topicSearch"]
/**
 话题搜索历史

 @return 话题搜索历史
 */
#define oldSearchTopic [serverIP stringByAppendingString:@"community/oldSearchTopic"]
/**
 根据展览id查看展览详情

 @return 根据展览id查看展览详情
 */
#define selectShowBySid [serverIP stringByAppendingString:@"community/selectShowBySid"]

#endif /* CommuntityHttpsDefine_h */
