//
//  ChangeTheModelView.h
//  ArtStar
//
//  Created by abc on 5/8/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YourLocationVC.h"

typedef NS_ENUM(NSInteger,EditType){
    EditTypeVideo,
    EditTypeTheme,
    EditTypeGraphic,
};

@protocol ChangeTheModelViewDelegate <NSObject>

- (void)pushViewControllerWithVC:(YourLocationVC *)vc;

@end

@class PreviewVCModel;
@interface ChangeTheModelView : UIView
/**
 传入话题模型
 */
@property (nonatomic,assign) EditThemeType themeType;
/**
 传入视频模型
 */
@property (nonatomic,assign) EditVideoType videoType;
/**
 传入图文模型
 */
@property (nonatomic,assign) EditGraphicType graphicType;
/**
 向外部发送数据
 */
@property (nonatomic,copy) PreviewVCModel *model;
@property (nonatomic,weak) id<ChangeTheModelViewDelegate>delegate;
/**
 自定义初始化方法

 @param frame frame
 @param type 选择是视频，话题，还是图文
 @return view
 */
- (instancetype)initWithFrame:(CGRect)frame type:(EditType)type;


@end
