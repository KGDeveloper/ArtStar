//
//  CommunityExhibitionModel.m
//  ArtStar
//
//  Created by 文艺星球 on 2018/7/31.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "CommunityExhibitionModel.h"

@implementation CommunityExhibitionModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"typeID":@"typeid",@"typeName":@"typename",@"ID":@"id"};
}

@end
