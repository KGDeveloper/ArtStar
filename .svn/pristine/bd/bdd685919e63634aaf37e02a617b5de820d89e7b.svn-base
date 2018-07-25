//
//  ModelFrameIndex.h
//  ArtStar
//
//  Created by abc on 5/8/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import <Foundation/Foundation.h>
//MARK:--视频模板--
typedef NS_ENUM(NSInteger,EditVideoType){
    EditVideoTypeOnlyVideo = 0,//:--只有视频--
    EditVideoTypeTopLeft,//:--文字居上居左--
    EditVideoTypeTopCenter,//:--文字居上居中--
    EditVideoTypeTopRight,//:--文字居上居右--
    EditVideoTypeLeft,//:--文字居下居左--
    EditVideoTypeCenter,//:--文字居下居中--
    EditVideoTypeRight,//:--文字居下居右--
};
//MARK:--话题模板--
typedef NS_ENUM(NSInteger,EditThemeType){
    EditThemeTypeOnlyTitle = 0,//:--只有文字--
    EditThemeTypeOnlyPicture,//:--只有图片--
    EditThemeTypeCircular,//:--圆形图片--
    EditThemeTypeRightTop,//:--文字居右居上--
    EditThemeTypeRightCenter,//:--文字居右居中--
    EditThemeTypeTopLeft,//:--文字居上居左--
    EditThemeTypeTopCenter,//:--文字居上居中--
    EditThemeTypeTopRight,//:--文字居上居右--
    EditThemeTypeLeft,//:--文字居下居左--
    EditThemeTypeCenter,//:--文字居下居中--
    EditThemeTypeRight,//:--文字居下居右--
};
//MARK:--图文模板--
typedef NS_ENUM(NSInteger,EditGraphicType){
    EditGraphicTypeOnlyTitle = 0,//:--只有文字--
    EditGraphicTypeOnlyPicture,//:--只有图片--
    EditGraphicTypeCircular,//:--圆形图片--
    EditGraphicTypeRightTop,//:--文字居右居上--
    EditGraphicTypeRightCenter,//:--文字居右居中--
    EditGraphicTypeTopLeft,//:--文字居上居左--
    EditGraphicTypeTopCenter,//:--文字居上居中--
    EditGraphicTypeTopRight,//:--文字居上居右--
    EditGraphicTypeLeft,//:--文字居下居左--
    EditGraphicTypeCenter,//:--文字居下居中--
    EditGraphicTypeRight,//:--文字居下居右--
};
@class ModelFrameIndex;
@interface ModelFrameIndex : NSObject

+ (ModelFrameIndex *)shareInterace;
- (EditThemeType)themeTypeWithIndex:(NSInteger)index;
- (EditVideoType)videoTypeWithIndex:(NSInteger)index;
- (EditGraphicType)graphicTypeWithIndex:(NSInteger)index;

@end
