//
//  ViewForActivity.h
//  ArtStar
//
//  Created by 文艺星球 on 2018/8/30.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ActivityType){
    ActivityTypeRules = 0,
    ActivityTypePrize,
    ActivityTypeClick,
    ActivityTypeMapShow,
};

@interface ViewForActivity : UIView

/**
 页面类型
 */
@property (nonatomic,assign) NSInteger alertType;
/**
 加载展示图
 */
@property (nonatomic,copy) UIImage *showImage;
/**
 首页展示活动入口
 */
@property (nonatomic,copy) void(^mapShowPushActivityController)(void);

@end
