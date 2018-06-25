//
//  KGCity.m
//  ArtStar
//
//  Created by abc on 5/31/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "KGCity.h"

@implementation KGCity

+ (NSArray *)province{
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"KGCity" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    NSArray *cityArr = dic.allKeys;
    return cityArr;
}

+ (NSArray *)cityWithprovince:(NSString *)province{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"KGCity" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    return dic[province];
}

@end
