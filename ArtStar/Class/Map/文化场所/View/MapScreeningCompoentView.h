//
//  MapScreeningCompoentView.h
//  ArtStar
//
//  Created by abc on 2018/6/22.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapScreeningCompoentView : UIView

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSArray *choosebtuArr;
@property (nonatomic,copy) void(^chooseScreeningType)(NSString *str);

@end
