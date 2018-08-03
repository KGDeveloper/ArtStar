//
//  MineSelfMyLabelsDetailModel.h
//  ArtStar
//
//  Created by abc on 2018/7/11.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MineSelfMyLabelsDetailModel : NSObject

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSArray *children;
@property (nonatomic,copy) NSNumber *ID;
@property (nonatomic,copy) NSString *path;
@property (nonatomic,copy) NSNumber *pid;

@end
