/**
 
 ArtStar
 
 Created by: KG丿轩帝 on 2018/4/20
 
 Copyright (c) 2017 My Company
 
 ☆★☆★☆★☆★☆★☆★☆★☆★☆
 ★　　│　心想　│　事成　│　　★
 ☆别╭═╮　　 ╭═╮　　 ╭═╮别☆
 ★恋│人│　　│奎│　　│幸│恋★
 ☆　│氣│　　│哥│　　│福│　☆
 ★　│超│　　│制│　　│滿│　★
 ☆别│旺│　　│作│　　│滿│别☆
 ★恋│㊣│　　│㊣│　　│㊣│恋★
 ☆　╰═╯ 天天╰═╯ 開心╰═╯　☆
 ★☆★☆★☆★☆★☆★☆★☆★☆★.
 
 */

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,KGAlertViewType){
    KGAlertViewTypeDefult = 0,//只有一个按钮
    KGAlertViewTypeCancel,//有两个按钮，左边关闭（红色），右边确认（蓝色）
    KGAlertViewTypeShure,//有两个按钮，右边关闭（红色），左边确认（蓝色）
};
@protocol KGAlertViewDelegate <NSObject>
/**
 取消按钮点击
 */
- (void)cancel;
/**
 默认模式按钮点击
 */
- (void)defult;
/**
 确认按钮点击
 */
- (void)shure;
@end

@interface KGAlertView : UIView
/**
 遵守代理，执行点击事件
 */
@property (nonatomic,assign) id<KGAlertViewDelegate>delegate;
/**
 警告框样式

 @param title 标题
 @param message 内容
 @param type 样式
 */
- (void)setAlertViewTitle:(NSString *)title message:(NSString *)message type:(KGAlertViewType)type;

@end
//MARK:--自定义选择相册还是拍照提示框--
@protocol KGCameraDelegate <NSObject>
/**
 点击拍照上传
 */
- (void)touchCamera;
/**
 点击本地上传
 */
- (void)touchPhoto;

@end

@interface KGCamera : UIView
/**
 获取点击事件
 */
@property (nonatomic,assign) id<KGCameraDelegate>delegate;

@end

@interface KGMessage : UIView

@end
