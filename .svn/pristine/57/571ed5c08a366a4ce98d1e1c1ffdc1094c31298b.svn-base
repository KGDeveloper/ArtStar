//
//  KGCustomButton.m
//  BlockTest
//
//  Created by KG丿轩帝 on 2018/4/16.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGCustomButton.h"

/**
 获取相应view的宽度

 @param view 控件
 @return 返回一个CGFloat类型数据
 */
#define ViewWidth(view) view.frame.size.width
/**
 获取相应view的高度

 @param view 控件
 @return 返回一个CGFloat类型的数据
 */
#define ViewHeight(view) view.frame.size.height
/**
 获取View的起点X

 @param view 对象view
 @return 返回view对象的起点x坐标
 */
#define ViewX(view) view.frame.origin.x
/**
 获取View的起点Y
 
 @param view 对象view
 @return 返回view对象的起点y坐标
 */
#define ViewY(view) view.frame.origin.y

typedef void(^SelectSelfBlock)(void);

@interface KGCustomButton ()
/**
 按钮图片
 */
@property (nonatomic,strong) UIImageView *btuImage;
/**
 按钮文字
 */
@property (nonatomic,strong) UILabel *btuTitle;
/**
 按钮的点击事件
 */
@property (nonatomic,copy) SelectSelfBlock selectBlcok;

@end

@implementation KGCustomButton

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self drawUI];
    }
    return self;
}
/**
 添加文字和图片到view上
 */
- (void)drawUI{
    if (ViewHeight(self) < 50) {
        self.btuTitle.frame = CGRectMake(0,
                                         0,
                                         ViewWidth(self),
                                         30);
    }else{
        self.btuTitle.frame = CGRectMake(0,
                                         0,
                                         ViewWidth(self),
                                         ViewHeight(self)/3);
    }
    self.btuTitle.center = CGPointMake(ViewWidth(self)/2, ViewHeight(self)/2);
    self.btuImage.frame = CGRectMake(0,
                                     0,
                                     ViewWidth(self),
                                     ViewHeight(self));
    self.btuImage.hidden = YES;
}
/**
 设置按钮样式

 @param btuType 按钮样式
 */
- (void)setBtuType:(ButtonType)btuType{
    _btuType = btuType;
    [self buttonType:0.0 type:0];
}

/**
 按钮上的图片

 @return 按钮图片
 */
- (UIImageView *)btuImage{
    if (!_btuImage) {
        _btuImage = [[UIImageView alloc]init];
        [self addSubview:_btuImage];
    }
    return _btuImage;
}

/**
 按钮上的文字

 @return 按钮标题
 */
- (UILabel *)btuTitle{
    if (!_btuTitle) {
        _btuTitle = [[UILabel alloc]init];
        [_btuTitle setAdjustsFontSizeToFitWidth:YES];
        _btuTitle.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_btuTitle];
    }
    return _btuTitle;
}
/**
 设置按钮的图片

 @param viewImage 按钮图片
 */
- (void)setViewImage:(UIImage *)viewImage{
    _viewImage = viewImage;
    self.btuImage.image = viewImage;
}
/**
 设置按钮标题

 @param viewTitle 按钮标题
 */
- (void)setViewTitle:(NSString *)viewTitle{
    _viewTitle = viewTitle;
    self.btuTitle.text = viewTitle;
}
/**
 设置按钮标题的大小

 @param labelSize 标题label的大小
 */
- (void)setLabelSize:(CGSize)labelSize{
    _labelSize = labelSize;
    self.btuTitle.frame = CGRectMake(ViewX(self.btuTitle),
                                     ViewY(self.btuTitle),
                                     labelSize.width,
                                     labelSize.height);
    if (_btuType == OnlyHaveTitle) {
        self.btuTitle.center = CGPointMake(ViewWidth(self)/2,
                                           ViewHeight(self)/2);
    }
}
/**
 设置按钮图片大小

 @param imageSize 图片大小
 */
- (void)setImageSize:(CGSize)imageSize{
    _imageSize = imageSize;
    self.btuImage.frame = CGRectMake(ViewX(self.btuImage),
                                     ViewY(self.btuImage),
                                     imageSize.width,
                                     imageSize.width);
    if (_btuType == OnlyHaveTitle) {
        self.btuTitle.center = CGPointMake(ViewWidth(self)/2, ViewHeight(self)/2);
    }
}
/**
 设置居左位置

 @param leftDistance 居左距离
 */
- (void)setLeftDistance:(CGFloat)leftDistance{
    [self buttonType:leftDistance type:1];
}
/**
 设置居右位置

 @param rightDistance 居右距离
 */
- (void)setRightDistance:(CGFloat)rightDistance{
    [self buttonType:rightDistance type:2];
}
/**
 设置居上位置

 @param topDistance 居上距离
 */
- (void)setTopDistance:(CGFloat)topDistance{
    [self buttonType:topDistance type:3];
}
/**
 设置居下位置

 @param buttomDistance 居下距离
 */
- (void)setButtomDistance:(CGFloat)buttomDistance{
    [self buttonType:buttomDistance type:4];
}
/**
 设置按钮图片和标题的位置

 @param size 位置
 @param type 类型
 */
- (void)buttonType:(CGFloat)size type:(NSInteger)type{
    switch (type) {//默认

        case 0:
            switch (_btuType) {
                case OnlyHaveTitle://只有文字
                    self.btuImage.hidden = YES;
                    self.btuTitle.hidden = NO;
                    break;
                case OnlyHaveImage://只有图片
                    self.btuImage.hidden = NO;
                    self.btuTitle.hidden = YES;
                    break;
                case LeftImageAndRightTitle://图片居左，文字居右
                    self.btuImage.hidden = NO;
                    self.btuImage.frame = CGRectMake(0,
                                                     ViewHeight(self)/3,
                                                     ViewHeight(self)/3,
                                                     ViewHeight(self)/3);
                    self.btuTitle.frame = CGRectMake(ViewHeight(self)/3,
                                                     ViewHeight(self)/2 - ViewHeight(self)/6,
                                                     ViewWidth(self) - ViewHeight(self)/3,
                                                     ViewHeight(self)/3);
                    break;
                case LeftTitleAndRightImage://文字居左，图片居右
                    self.btuImage.hidden = NO;
                    self.btuImage.frame = CGRectMake(ViewWidth(self) - ViewHeight(self)/3,
                                                     ViewHeight(self)/3,
                                                     ViewHeight(self)/3,
                                                     ViewHeight(self)/3);
                    self.btuTitle.frame = CGRectMake(0,
                                                     ViewHeight(self)/2 - ViewHeight(self)/6,
                                                     ViewWidth(self) - ViewHeight(self)/3,
                                                     ViewHeight(self)/3);
                    break;
                case TopImageAndButtomTitle://图片居上，文字居下
                    self.btuImage.hidden = NO;
                    self.btuImage.frame = CGRectMake(ViewWidth(self)/2 - ViewHeight(self)/6,
                                                     0,
                                                     ViewHeight(self)/3,
                                                     ViewHeight(self)/3);
                    self.btuTitle.frame = CGRectMake(0,
                                                     ViewHeight(self)/2 + ViewHeight(self)/6,
                                                     ViewWidth(self),
                                                     ViewHeight(self)/3);
                    break;
                default://文字居上，图片居下
                    self.btuImage.hidden = NO;
                    self.btuImage.frame = CGRectMake(ViewWidth(self)/2 - ViewHeight(self)/6,
                                                     ViewHeight(self) -  ViewHeight(self)/3,
                                                     ViewHeight(self)/3,
                                                     ViewHeight(self)/3);
                    self.btuTitle.frame = CGRectMake(0,
                                                     0,
                                                     ViewWidth(self),
                                                     ViewHeight(self)/3);
                    break;
            }
            break;
        case 1://设置居左
            switch (_btuType) {
                case OnlyHaveTitle://只有文字
                    self.btuImage.hidden = YES;
                    self.btuTitle.hidden = NO;
                    self.btuTitle.frame = CGRectMake(ViewX(self.btuTitle) + size,
                                                     ViewY(self.btuTitle),
                                                     ViewWidth(self.btuTitle) - size,
                                                     ViewHeight(self.btuTitle));
                    break;
                case OnlyHaveImage://只有图片
                    self.btuImage.hidden = NO;
                    self.btuTitle.hidden = YES;
                    self.btuImage.frame = CGRectMake(ViewX(self.btuImage) + size,
                                                     ViewY(self.btuImage),
                                                     ViewWidth(self.btuImage) - size,
                                                     ViewHeight(self.btuImage));
                    break;
                case LeftImageAndRightTitle://图片居左，文字居右
                    self.btuImage.hidden = NO;
                    self.btuImage.frame = CGRectMake(ViewX(self.btuImage) + size,
                                                     ViewY(self.btuImage),
                                                     ViewHeight(self.btuImage),
                                                     ViewHeight(self.btuImage));
                    self.btuTitle.frame = CGRectMake(ViewWidth(self.btuImage) + ViewX(self.btuImage),
                                                     ViewY(self.btuTitle),
                                                     ViewWidth(self.btuTitle) - size,
                                                     ViewHeight(self.btuTitle));
                    break;
                case LeftTitleAndRightImage://文字居左，图片居右
                    self.btuImage.hidden = NO;
                    self.btuTitle.frame = CGRectMake(ViewX(self.btuTitle) + size,
                                                     ViewY(self.btuTitle),
                                                     ViewWidth(self.btuTitle) - size,
                                                     ViewHeight(self.btuTitle));
                    break;
                case TopImageAndButtomTitle://图片居上，文字居下
                    self.btuImage.hidden = NO;
                    self.btuImage.frame = CGRectMake(size + ViewX(self.btuImage),
                                                     ViewY(self.btuImage),
                                                     ViewWidth(self.btuImage),
                                                     ViewHeight(self.btuImage));
                    self.btuTitle.frame = CGRectMake(size + ViewX(self.btuTitle),
                                                     ViewY(self.btuTitle),
                                                     ViewWidth(self.btuTitle) - size,
                                                     ViewHeight(self.btuTitle));
                    break;
                default://文字居上，图片居下
                    self.btuImage.hidden = NO;
                    self.btuImage.frame = CGRectMake(size + ViewX(self.btuImage),
                                                     ViewY(self.btuImage),
                                                     ViewWidth(self.btuImage),
                                                     ViewHeight(self.btuImage));
                    self.btuTitle.frame = CGRectMake(size + ViewX(self.btuTitle),
                                                     ViewY(self.btuTitle),
                                                     ViewWidth(self.btuTitle) - size,
                                                     ViewHeight(self.btuTitle));
                    break;
            }
            break;
        case 2://设置居右
            switch (_btuType) {
                case OnlyHaveTitle://只有文字
                    self.btuImage.hidden = YES;
                    self.btuTitle.hidden = NO;
                    self.btuTitle.frame = CGRectMake(ViewX(self.btuTitle),
                                                     ViewY(self.btuTitle),
                                                     ViewWidth(self.btuTitle) - size,
                                                     ViewHeight(self.btuTitle));
                    break;
                case OnlyHaveImage://只有图片
                    self.btuImage.hidden = NO;
                    self.btuTitle.hidden = YES;
                    self.btuImage.frame = CGRectMake(ViewX(self.btuImage),
                                                     ViewY(self.btuImage),
                                                     ViewWidth(self.btuImage) - size,
                                                     ViewHeight(self.btuImage));
                    break;
                case LeftImageAndRightTitle://图片居左，文字居右
                    self.btuImage.hidden = NO;
                    self.btuTitle.frame = CGRectMake(ViewX(self.btuTitle),
                                                     ViewY(self.btuTitle),
                                                     ViewWidth(self.btuTitle) - size,
                                                     ViewHeight(self.btuTitle));
                    break;
                case LeftTitleAndRightImage://文字居左，图片居右
                    self.btuImage.hidden = NO;
                    self.btuImage.frame = CGRectMake(ViewWidth(self) - ViewWidth(self.btuImage) - size,
                                                     ViewY(self.btuImage),
                                                     ViewWidth(self.btuImage),
                                                     ViewHeight(self.btuImage));
                    self.btuTitle.frame = CGRectMake(ViewX(self.btuTitle),
                                                     ViewY(self.btuTitle),
                                                     ViewWidth(self.btuTitle) - size,
                                                     ViewHeight(self.btuTitle));
                    break;
                case TopImageAndButtomTitle://图片居上，文字居下
                    self.btuImage.hidden = NO;
                    self.btuImage.frame = CGRectMake(ViewWidth(self) - size - ViewHeight(self)/3,
                                                     0,
                                                     ViewHeight(self)/3,
                                                     ViewHeight(self)/3);
                    self.btuTitle.frame = CGRectMake(0,
                                                     ViewHeight(self)/2 + ViewHeight(self)/6,
                                                     ViewWidth(self) - size,
                                                     ViewHeight(self)/3);
                    break;
                default://文字居上，图片居下
                    self.btuImage.hidden = NO;
                    self.btuImage.frame = CGRectMake(ViewWidth(self) - ViewWidth(self.btuImage) - size,
                                                     ViewY(self.btuImage),
                                                     ViewWidth(self.btuImage),
                                                     ViewHeight(self.btuImage));
                    self.btuTitle.frame = CGRectMake(ViewX(self.btuTitle),
                                                     ViewY(self.btuTitle),
                                                     ViewWidth(self.btuTitle) - size,
                                                     ViewHeight(self.btuTitle));
                    break;
            }
            break;
        case 3://设置居上
            switch (_btuType) {
                case OnlyHaveTitle://只有文字
                    self.btuImage.hidden = YES;
                    self.btuTitle.hidden = NO;
                    self.btuTitle.frame = CGRectMake(ViewX(self.btuTitle),
                                                     ViewY(self.btuTitle) + size  ,
                                                     ViewWidth(self.btuTitle),
                                                     ViewHeight(self.btuTitle));
                    break;
                case OnlyHaveImage://只有图片
                    self.btuImage.hidden = NO;
                    self.btuTitle.hidden = YES;
                    self.btuImage.frame = CGRectMake(ViewX(self.btuImage),
                                                     ViewY(self.btuImage) + size,
                                                     ViewWidth(self.btuImage),
                                                     ViewHeight(self.btuImage) - size);
                    break;
                case LeftImageAndRightTitle://图片居左，文字居右
                    self.btuImage.hidden = NO;
                    self.btuImage.frame = CGRectMake(ViewX(self.btuImage),
                                                     ViewY(self.btuImage) + size,
                                                     ViewWidth(self.btuImage),
                                                     ViewHeight(self.btuImage));
                    self.btuTitle.frame = CGRectMake(ViewX(self.btuTitle),
                                                     ViewY(self.btuTitle) + size,
                                                     ViewWidth(self.btuTitle),
                                                     ViewHeight(self.btuTitle));
                    break;
                case LeftTitleAndRightImage://文字居左，图片居右
                    self.btuImage.hidden = NO;
                    self.btuImage.frame = CGRectMake(ViewX(self.btuImage),
                                                     ViewY(self.btuImage) + size ,
                                                     ViewWidth(self.btuImage),
                                                     ViewHeight(self.btuImage));
                    self.btuTitle.frame = CGRectMake(ViewX(self.btuTitle),
                                                     ViewY(self.btuTitle) + size ,
                                                     ViewWidth(self.btuTitle),
                                                     ViewHeight(self.btuTitle));
                    break;
                case TopImageAndButtomTitle://图片居上，文字居下
                    self.btuImage.hidden = NO;
                    self.btuImage.frame = CGRectMake(ViewX(self.btuImage),
                                                     ViewY(self.btuImage) + size,
                                                     ViewWidth(self.btuImage),
                                                     ViewHeight(self.btuImage));
                    break;
                default://文字居上，图片居下
                    self.btuImage.hidden = NO;
                    self.btuTitle.frame = CGRectMake(ViewX(self.btuTitle),
                                                     ViewY(self.btuTitle) + size,
                                                     ViewWidth(self.btuTitle),
                                                     ViewHeight(self.btuTitle));
                    break;
            }
            break;
        default://设置居下
            switch (_btuType) {
                case OnlyHaveTitle://只有文字
                    self.btuImage.hidden = YES;
                    self.btuTitle.hidden = NO;
                    self.btuTitle.frame = CGRectMake(ViewX(self.btuTitle),
                                                     ViewHeight(self) - size - ViewHeight(self.btuTitle),
                                                     ViewWidth(self.btuTitle),
                                                     ViewHeight(self.btuTitle));
                    break;
                case OnlyHaveImage://只有图片
                    self.btuImage.hidden = NO;
                    self.btuTitle.hidden = YES;
                    self.btuImage.frame = CGRectMake(ViewX(self.btuImage),
                                                     ViewY(self.btuImage),
                                                     ViewWidth(self.btuImage),
                                                     ViewHeight(self.btuImage) - size);
                    break;
                case LeftImageAndRightTitle://图片居左，文字居右
                    self.btuImage.hidden = NO;
                    self.btuImage.frame = CGRectMake(ViewX(self.btuImage),
                                                     ViewHeight(self) - ViewHeight(self.btuImage) - size,
                                                     ViewWidth(self.btuImage),
                                                     ViewHeight(self.btuImage));
                    self.btuTitle.frame = CGRectMake(ViewX(self.btuTitle),
                                                     ViewHeight(self) - ViewHeight(self.btuTitle) - size ,
                                                     ViewWidth(self.btuTitle),
                                                     ViewHeight(self.btuTitle));
                    break;
                case LeftTitleAndRightImage://文字居左，图片居右
                    self.btuImage.hidden = NO;
                    self.btuImage.frame = CGRectMake(ViewX(self.btuImage),
                                                     ViewHeight(self) - ViewHeight(self.btuImage) - size,
                                                     ViewWidth(self.btuImage),
                                                     ViewHeight(self.btuImage));
                    self.btuTitle.frame = CGRectMake(ViewX(self.btuTitle),
                                                     ViewHeight(self) - ViewHeight(self.btuTitle) - size,
                                                     ViewWidth(self.btuTitle),
                                                     ViewHeight(self.btuTitle));
                    break;
                case TopImageAndButtomTitle://图片居上，文字居下
                    self.btuImage.hidden = NO;
                    self.btuTitle.frame = CGRectMake(ViewX(self.btuTitle),
                                                     ViewHeight(self) - ViewHeight(self.btuTitle) - size,
                                                     ViewWidth(self.btuTitle),
                                                     ViewHeight(self.btuTitle));
                    break;
                default://文字居上，图片居下
                    self.btuImage.hidden = NO;
                    self.btuImage.frame = CGRectMake(ViewX(self.btuImage),
                                                     ViewHeight(self) -  ViewHeight(self.btuImage) - size,
                                                     ViewWidth(self.btuImage),
                                                     ViewHeight(self.btuImage));
                    break;
            }
            break;
    }
    
}
/**
 设置标题字体颜色

 @param textColor 字体颜色
 */
- (void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    self.btuTitle.textColor = textColor;
}
/**
 设置标题字体字号

 @param textFont 字号
 */
- (void)setTextFont:(UIFont *)textFont{
    _textFont = textFont;
    self.btuTitle.font = textFont;
    [self.btuTitle setAdjustsFontSizeToFitWidth:NO];
}
/**
 按钮的点击事件

 @param sender 按钮
 */
- (void)selectButton:(void (^)(KGCustomButton *btu))sender{
    __weak typeof(self) weakSelf = self;
    self.selectBlcok = ^{
        sender(weakSelf);
    };
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.selectBlcok) {
        self.selectBlcok();
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
