/**
 
 ArtStar
 
 Created by: KG丿轩帝 on 2018/4/28
 
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

#import <UIKit/UIKit.h>


@class CustomTabbar;

@protocol CustomTabbarDelegate <NSObject>

- (void)tabbar:(CustomTabbar *)tabbar clickCenterBtu:(UIButton *)sender;

@end

@interface CustomTabbar : UITabBar

@property (nonatomic,weak) id<CustomTabbarDelegate>mydelegate;
@property (nonatomic,copy) NSString *centerImage;


@end
