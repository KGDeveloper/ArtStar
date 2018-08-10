//
//  MineReleaseHositryPictureModel.h
//  ArtStar
//
//  Created by 文艺星球 on 2018/8/10.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MineReleaseHositryPictureModel : NSObject

@property (nonatomic,copy) NSString *location;
@property (nonatomic,copy) NSNumber *uid;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSNumber *ID;
@property (nonatomic,copy) NSString *createTimeStr;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSArray *imageUrl;
@property (nonatomic,copy) NSNumber *rfmid;
@property (nonatomic,copy) NSNumber *issid;
@property (nonatomic,copy) NSString *createTime;
@property (nonatomic,copy) NSNumber *issueType;

@end
