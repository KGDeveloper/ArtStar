//
//  MineMyselfWordChooseYourLoveVC.h
//  ArtStar
//
//  Created by abc on 2018/6/13.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "BaseVC.h"

@interface MineMyselfWordChooseYourLoveVC : BaseVC

@property (nonatomic,copy) NSString *titleStr;

@end

@interface MineLoveMoviesModel : NSObject

@property (nonatomic,copy) NSString *region;
@property (nonatomic,copy) NSString *writer;
@property (nonatomic,copy) NSNumber *userId;
@property (nonatomic,copy) NSNumber *ID;
@property (nonatomic,assign) double bookGrade;
@property (nonatomic,copy) NSString *bookName;
@property (nonatomic,copy) NSString *imageUrl;
@property (nonatomic,copy) NSString *createTime;

@end

@interface MineLoveMusicModel : NSObject

@property (nonatomic,copy) NSString *region;
@property (nonatomic,copy) NSString *writer;
@property (nonatomic,copy) NSNumber *userId;
@property (nonatomic,copy) NSNumber *ID;
@property (nonatomic,assign) double bookGrade;
@property (nonatomic,copy) NSString *bookName;
@property (nonatomic,copy) NSString *imageUrl;
@property (nonatomic,copy) NSString *createTime;

@end

@interface MineLoveBookModel : NSObject

@property (nonatomic,copy) NSString *url;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *detailStr;

@end

