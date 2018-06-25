/**
 
 ArtStar
 
 Created by: KG丿轩帝 on 2018/5/3
 
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

typedef NS_ENUM(NSInteger,EditReleaseType){
    EditReleaseTypeVideo = 0,//视频
    EditReleaseTypePictureAndTitle,//图文
    EditReleaseTypeTopic,//话题
};

typedef NS_ENUM(NSInteger,EditReleaseCardType){
    //MARK:--这是公共部分--
    EditReleaseCardTypeOnlyPicture = 0,//只有图片
    EditReleaseCardTypeOnlyTitle,//只有文字
    EditReleaseCardTypeTopRightTitle,//文字居上居右
    EditReleaseCardTypeTopCenterTitle,//文字居上居中
    EditReleaseCardTypeTopLeftTitle,//文字居上居左
    EditReleaseCardTypeButtomLeftTitle,//文字居下居左
    EditReleaseCardTypeButtomCenterTitle,//文字居下居中
    EditReleaseCardTypeButtomRightTitle,//文字居下居右
    EditReleaseCardTypeRightTopTitle,//文字居右居上
    EditReleaseCardTypeRightCenterTitle,//文字居右居中
    EditReleaseCardTypeRightbuttomTitle,//文字居右居下
    
    //MARK:--这是只有图文采用的,图片是圆形的--
    EditReleaseCardTypeRoundOnlyPicture,//只有图片
    EditReleaseCardTypeRoundTopRightTitle,//文字居上居右
    EditReleaseCardTypeRoundTopCenterTitle,//文字居上居中
    EditReleaseCardTypeRoundTopLeftTitle,//文字居上居左
    EditReleaseCardTypeRoundButtomLeftTitle,//文字居下居左
    EditReleaseCardTypeRoundButtomCenterTitle,//文字居下居中
    EditReleaseCardTypeRoundButtomRightTitle,//文字居下居右
    EditReleaseCardTypeRoundRightTopTitle,//文字居右居上
    EditReleaseCardTypeRoundRightCenterTitle,//文字居右居中
    EditReleaseCardTypeRoundRightbuttomTitle,//文字居右居下
    
};

@interface EditReleaseCard : UIView

+ (instancetype)initWithFrame:(CGRect)frame releaseType:(EditReleaseType)releaseType cardType:(EditReleaseCardType)cardType;

@end
