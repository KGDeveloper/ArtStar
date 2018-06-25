//
//  ModelFrameIndex.m
//  ArtStar
//
//  Created by abc on 5/8/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "ModelFrameIndex.h"

@implementation ModelFrameIndex

+ (ModelFrameIndex *)shareInterace{
    static ModelFrameIndex *obj = nil;
    if (obj == nil) {
        obj = [[ModelFrameIndex alloc]init];
    }
    return obj;
}

- (EditGraphicType)graphicTypeWithIndex:(NSInteger)index{
    switch (index) {
        case 0:
            return EditGraphicTypeOnlyTitle;//:--只有文字--
            break;
        case 1:
            return EditGraphicTypeOnlyPicture;//:--只有图片--
            break;
        case 2:
            return EditGraphicTypeCircular;//:--圆形图片--
            break;
        case 3:
            return EditGraphicTypeRightTop;//:--文字居右居上--
            break;
        case 4:
            return EditGraphicTypeRightCenter;//:--文字居右居中--
            break;
        case 5:
            return EditGraphicTypeTopLeft;//:--文字居上居左--
            break;
        case 6:
            return EditGraphicTypeTopCenter;//:--文字居上居中--break;
        case 7:
            return EditGraphicTypeTopRight;//:--文字居上居右--
            break;
        case 8:
            return EditGraphicTypeLeft;//:--文字居下居左--
            break;
        case 9:
            return EditGraphicTypeCenter;//:--文字居下居中--
            break;
        default:
            return EditGraphicTypeRight;//:--文字居下居右--
            break;
    }
}

- (EditVideoType)videoTypeWithIndex:(NSInteger)index{
    switch (index) {
        case 0:
            return EditVideoTypeOnlyVideo;//:--只有视频--
            break;
        case 1:
            return EditVideoTypeTopLeft;//:--文字居上居左--
            break;
        case 2:
            return EditVideoTypeTopCenter;//:--文字居上居中--
            break;
        case 3:
            return EditVideoTypeTopRight;//:--文字居上居右--
            break;
        case 4:
            return EditVideoTypeLeft;//:--文字居下居左--
            break;
        case 5:
            return EditVideoTypeCenter;//:--文字居下居中--
            break;
        default:
            return EditVideoTypeRight;//:--文字居下居右--
            break;
    }
}

- (EditThemeType)themeTypeWithIndex:(NSInteger)index{
    switch (index) {
        case 0:
            return EditThemeTypeCircular;//:--圆形图片--
            break;
        case 1:
            return EditThemeTypeRightTop;//:--文字居右居上--
            break;
        case 2:
            return EditThemeTypeRightCenter;//:--文字居右居中--
            break;
        case 3:
            return EditThemeTypeTopLeft;//:--文字居上居左--
            break;
        case 4:
            return EditThemeTypeTopCenter;//:--文字居上居中--
            break;
        case 5:
            return EditThemeTypeTopRight;//:--文字居上居右--
            break;
        case 6:
            return EditThemeTypeLeft;//:--文字居下居左--
            break;
        case 7:
            return EditThemeTypeCenter;//:--文字居下居中--
            break;
        default:
            return EditThemeTypeRight;//:--文字居下居右--
            break;
    }
}

@end
