/**
 
 ArtStar
 
 Created by: KG丿轩帝 on 2018/5/3
 
 Copyright (c) 2017 My Company
 
 ☆★☆★☆★☆★☆★☆★☆★☆★☆
 ★　　│　心想　│　事成　│　　★
 ☆别╭═╮　　 ╭═╮　　 ╭═╮别☆
 ★恋│人│　　│奎│　　│幸│恋★
 ☆　│氣│　　│哥│　　│福│　☆
 ★　│超│　　│制│　　│滿│　★
 ☆别│旺│　　│作│　　│滿│别☆
 ★恋│㊣│　　│㊣│　　│㊣│恋★
 ☆　╰═╯ 天天╰═╯ 開心╰═╯　☆
 ★☆★☆★☆★☆★☆★☆★☆★☆★.
 
 */

#import "EditReleaseCard.h"

@interface EditReleaseCard ()
/**
 发布类型
 */
@property (nonatomic,assign) EditReleaseType releaseType;
/**
 模板类型
 */
@property (nonatomic,assign) EditReleaseCardType cardType;

@end

@implementation EditReleaseCard

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

+ (instancetype)initWithFrame:(CGRect)frame releaseType:(EditReleaseType)releaseType cardType:(EditReleaseCardType)cardType{
    EditReleaseCard *editCard = [[EditReleaseCard alloc]initWithFrame:frame];
    editCard.releaseType = releaseType;
    editCard.cardType = cardType;
    return editCard;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end