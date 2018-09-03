//
//  MapTopScreeningView.h
//  ArtStar
//
//  Created by abc on 2018/6/22.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MapTopScreeningViewDelegate <NSObject>

- (void)sendChooseToVCType:(NSString *)type chooseStr:(NSString *)chooseStr;

@end

@interface MapTopScreeningView : UIView

@property (nonatomic,assign) NSInteger mapType;
@property (nonatomic,weak) id<MapTopScreeningViewDelegate>delegate;

@end
