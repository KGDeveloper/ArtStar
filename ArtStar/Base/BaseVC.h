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

@class BaseVC;
@interface BaseVC : UIViewController

- (void)setLeftBtuWithFrame:(CGRect)frame title:(NSString *)title image:(UIImage *)image;
- (void)setLeftBtuWithFrame:(CGRect)frame title:(NSString *)title image:(UIImage *)image color:(UIColor *)color;
- (void)setRightBtuWithFrame:(CGRect)frame title:(NSString *)title image:(UIImage *)image;
- (void)setNavBackGroundClearColor;
- (void) pushNoTabBarViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (void)leftNavBtuAction:(UIButton *)sender;
- (void)rightNavBtuAction:(UIButton *)sender;
- (void)setNavTitleView:(UIView *)titleView;

@end
