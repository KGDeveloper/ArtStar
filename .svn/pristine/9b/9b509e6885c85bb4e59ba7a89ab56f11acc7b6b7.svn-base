//
//  KGCustomButton.h
//  BlockTest
//
//  Created by KG丿轩帝 on 2018/4/16.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 选择创建按钮的样式

 - OnlyHaveTitle: 只有文字，没有图片 默认
 - OnlyHaveImage: 只有图片，没有文字
 - LeftImageAndRightTitle: 图片在左，文字在右
 - LeftTitleAndRightImage: 文字在左，图片在右
 - TopImageAndButtomTitle: 图片在上，文字在下
 - TopTitleAndButtonImage: 文字在上，图片在下
 */
typedef NS_ENUM(NSInteger,ButtonType){
    
    OnlyHaveTitle = 0           ,
    OnlyHaveImage               ,
    LeftImageAndRightTitle      ,
    LeftTitleAndRightImage      ,
    TopImageAndButtomTitle      ,
    TopTitleAndButtonImage      ,
    
};

@interface KGCustomButton : UIView

/**
 按钮标题
 */
@property (nonatomic,copy) NSString *viewTitle;
/**
 按钮图片
 */
@property (nonatomic,strong) UIImage *viewImage;
/**
 显示文字的Label的大小（如果不设置，默认是文本的宽度是按钮本身的宽度，高度是根据高度比例计算1/3）
 */
@property (nonatomic,assign) CGSize labelSize;//设置大小前请先设置类型，否则冲突，你设置的大小会被忽略
/**
 显示图片的大小（如果不设置，默认是图片大小是按钮size）
 */
@property (nonatomic,assign) CGSize imageSize;//设置大小前请先设置类型，否则冲突，你设置的大小会被忽略
/**
 按钮内容居左距离（如果不设置，默认是居左为0）
 */
@property (nonatomic,assign) CGFloat leftDistance;
/**
 按钮内容居右距离（如果不设置，默认是居右为0）
 */
@property (nonatomic,assign) CGFloat rightDistance;
/**
 按钮内容居上距离（如果不设置，默认是居上为0）
 */
@property (nonatomic,assign) CGFloat topDistance;
/**
 按钮距离局下距离（如果不设置，默认是居下为0）
 */
@property (nonatomic,assign) CGFloat buttomDistance;
/**
 按钮样式（如果不设置，默认只有文字）
 */
@property (nonatomic,assign) ButtonType btuType;
/**
 标题文字颜色
 */
@property (nonatomic,copy) UIColor *textColor;
/**
 标题文字字体大小
 */
@property (nonatomic,strong) UIFont *textFont;

/**
 按钮的点击事件

 @param sender 按钮
 */
- (void)selectButton:(void(^)(KGCustomButton *btu))sender;

@end
