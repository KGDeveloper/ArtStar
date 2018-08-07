//
//  MineTalentPassModel.h
//  ArtStar
//
//  Created by 文艺星球 on 2018/8/7.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MineTalentPassModel : NSObject

@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *createTime;
@property (nonatomic,copy) NSString *createTimeStr;
@property (nonatomic,copy) NSNumber *ID;
@property (nonatomic,copy) NSArray *imageUrl;
@property (nonatomic,copy) NSNumber *issId;
@property (nonatomic,copy) NSString *issueType;
@property (nonatomic,copy) NSString *location;
@property (nonatomic,copy) NSNumber *rfmId;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *uid;

@end
