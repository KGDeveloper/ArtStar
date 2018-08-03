//
//  MineEditMyselfCardVC.h
//  ArtStar
//
//  Created by abc on 6/11/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "BaseVC.h"
#import "MineSelfCenterImageLIstModel.h"
#import "MineMyselfCenterInfoModel.h"


@interface MineEditMyselfCardVC : BaseVC

@property (nonatomic,strong) MineMyselfCenterInfoModel *model;
@property (nonatomic,copy) void(^refreshCenterListView)(void);

@end
