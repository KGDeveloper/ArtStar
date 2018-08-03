//
//  MineEditVCChooseImageView.h
//  ArtStar
//
//  Created by abc on 6/11/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MineSelfCenterImageLIstModel.h"

@interface MineEditVCChooseImageView : UIView

@property (nonatomic,copy) MineSelfCenterImageLIstModel *model;
@property (nonatomic,copy) void(^sendChooseFileToController)(NSString *fileStr);
@property (nonatomic,copy) void(^deleteChooseFileFromArr)(NSString *fileStr);

@end
