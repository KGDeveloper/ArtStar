//
//  CustomCalloutView.h
//  ArtStar
//
//  Created by 文艺星球 on 2018/9/1.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCalloutView : UIView
///商圈图
@property (nonatomic,strong) UIImage *image;
///商户名
@property (nonatomic,copy) NSString *title;
///地址
@property (nonatomic,copy) NSString *subtitle;

@end
