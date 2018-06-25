//
//  MineLoadCoverVC.h
//  ArtStar
//
//  Created by abc on 6/12/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "BaseVC.h"


@class MineLoadCoverVCModel;
@interface MineLoadCoverVC : BaseVC

@property (nonatomic,strong) MineLoadCoverVCModel *model;

@end

@interface MineLoadCoverVCModel : NSObject

@property (nonatomic,copy) NSString *lowUrl;
@property (nonatomic,copy) NSString *headerUrl;
@property (nonatomic,copy) NSString *nikNameStr;
@property (nonatomic,copy) NSString *signtureStr;

@end
