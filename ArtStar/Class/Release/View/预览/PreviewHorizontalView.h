//
//  PreviewHorizontalView.h
//  ArtStar
//
//  Created by abc on 5/11/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,LabelAndImageType){
    LabelAndImageTypeLabelTop,//:--文字在上--
    LabelAndImageTypeImageTop,//:--图片在上--
    LabelAndImageTypeOnlyLabel,//:--只有文字--
    LabelAndImageTypeOnlyImage,//:--只有图片--
    LabelAndImageTypeCircular,//:--圆形--
};

typedef NS_ENUM(NSInteger,TextAlignmentType){
    TextAlignmentTypeLeft = 0,
    TextAlignmentTypeCenter,
    TextAlignmentTypeRight,
};

@interface PreviewHorizontalView : UIView

@property (nonatomic,copy) NSArray *titleArr;
@property (nonatomic,copy) NSArray *imageArr;
@property (nonatomic,copy) NSString *timeStr;
@property (nonatomic,copy) NSString *locationStr;
@property (nonatomic,copy) NSString *themeStr;
@property (nonatomic,assign) TextAlignmentType type;

- (instancetype)initWithFrame:(CGRect)frame type:(LabelAndImageType)type;

@end
