//
//  ViewForActivity.h
//  ArtStar
//
//  Created by 文艺星球 on 2018/8/30.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ActivityType){
    ActivityTypeAlert = 0,
    ActivityTypeList,
    ActivityTypeAbout,
};

@interface ViewForActivity : UIView

@property (nonatomic,assign) NSInteger alertType;

@end
