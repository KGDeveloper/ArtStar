//
//  PreviewVC.h
//  ArtStar
//
//  Created by abc on 5/11/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "BaseVC.h"

@class PreviewVCModel;
@class ChangeTheModelView;

@interface PreviewVC : BaseVC

@property (nonatomic,strong) PreviewVCModel *model;
@property (nonatomic,assign) EditType type;
@property (nonatomic,assign) EditThemeType themeType;
@property (nonatomic,assign) EditVideoType videoType;
@property (nonatomic,assign) EditGraphicType graphicType;

@end

@interface PreviewVCModel : NSObject

/**
 保存选择的照片数组
 */
@property (nonatomic,copy) NSDictionary *imageURLs;
/**
 位置信息
 */
@property (nonatomic,copy) NSString *location;
/**
 消息类型
 */
@property (nonatomic,copy) NSString *typeStr;
/**
 标题
 */
@property (nonatomic,copy) NSString *title;
/**
 权限
 */
@property (nonatomic,copy) NSString *visitPermission;
@property (nonatomic,copy) NSString *str1;
@property (nonatomic,copy) NSString *str2;
@property (nonatomic,copy) NSString *str3;
@property (nonatomic,copy) NSString *str4;
@property (nonatomic,copy) NSString *str5;
/**
 话题分类
 */
@property (nonatomic,copy) NSString *topicType;
/**
 排版
 */
@property (nonatomic,copy) NSString *composing;
/**
 @人集合
 */
@property (nonatomic,copy) NSArray *ids;

@end

