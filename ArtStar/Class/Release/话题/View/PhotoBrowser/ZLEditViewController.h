//
//  ZLEditViewController.h
//  ZLPhotoBrowser
//
//  Created by long on 2017/6/23.
//  Copyright © 2017年 long. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,Cliptype){
    CliptypeV,//竖向
    CliptypeH,//横向
    CliptypeR,//圆形
};

@class ZLPhotoModel;

@interface ZLEditViewController : UIViewController

@property (nonatomic, strong) UIImage *oriImage;
@property (nonatomic, strong) ZLPhotoModel *model;
@property (nonatomic,assign) Cliptype clipType;

@end
