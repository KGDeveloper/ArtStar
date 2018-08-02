//
//  HeadlinesView.h
//  ArtStar
//
//  Created by abc on 5/24/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadlinesView : UIView

/**
 点赞，评论，分享
 */
@property (nonatomic,copy) void(^selectCellWithAction)(NSString *title,NSString *ID);
/**
 点击查看详情
 */
@property (nonatomic,copy) void(^pushViewController)(NSString *ID);
/**
 刷新数据
 */
@property (nonatomic,copy) void(^requestNewData)(NSString *type);
/**
 点击关闭新闻
 */
@property (nonatomic,copy) void(^closeNewsWithReson)(NSArray *resonArr,NSString *ID);
/**
 新闻数据
 */
@property (nonatomic,copy) NSArray *dataArr;
/**
 新闻最热5条数据
 */
@property (nonatomic,copy) NSArray *headerArr;

/**
 显示新闻页面顶部最热5条新闻
 */
- (void)showHeaderView;
/**
 隐藏新闻页面顶部最热5条新闻
 */
- (void)hideHeaderView;
/**
 开始刷新页面
 */
- (void)starRefrash;

@end
