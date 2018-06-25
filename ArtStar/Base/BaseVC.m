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

#import "BaseVC.h"

@interface BaseVC ()

@property (nonatomic,strong) UIView *navBackView;
@property (nonatomic,strong) UIButton *leftBtu;
@property (nonatomic,strong) UIButton *rightBtu;

@end

@implementation BaseVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
}
#pragma makr - push隐藏tabbar
- (void) pushNoTabBarViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    viewController.hidesBottomBarWhenPushed = YES;
    UIImage *image = [self imageWithColor:Color_ededed];
    [self.navigationController.navigationBar setShadowImage:image];
    [self.navigationController pushViewController:viewController animated:animated];
}

- (void)setLeftBtuWithTitle:(NSString *)title image:(UIImage *)image{
    
    _leftBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftBtu.frame = CGRectMake(15, 0,100, 30);
    [_leftBtu setTitle:title forState:UIControlStateNormal];
    [_leftBtu setTitleColor:Color_333333 forState:UIControlStateNormal];
    [_leftBtu setImage:image forState:UIControlStateNormal];
    _leftBtu.titleLabel.font = SYBFont(15);
    _leftBtu.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    _leftBtu.imageEdgeInsets = UIEdgeInsetsMake(7.5, 0, 7.5,0);
    _leftBtu.imageView.contentMode = UIViewContentModeScaleAspectFill;
    _leftBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_leftBtu addTarget:self action:@selector(leftNavBtuAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:_leftBtu];
    self.navigationItem.leftBarButtonItem = left;
}

- (void)leftNavBtuAction:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightNavBtuAction:(UIButton *)sender{
    
}

- (void)setRightBtuWithTitle:(NSString *)title image:(UIImage *)image{
    
    _rightBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtu.frame = CGRectMake(0, 0,60, 30);
    [_rightBtu setTitle:title forState:UIControlStateNormal];
    [_rightBtu setTitleColor:Color_333333 forState:UIControlStateNormal];
    [_rightBtu setImage:image forState:UIControlStateNormal];
    _rightBtu.titleLabel.font = SYFont(15);
    _rightBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    _rightBtu.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [_rightBtu addTarget:self action:@selector(rightNavBtuAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:_rightBtu];
    self.navigationItem.rightBarButtonItem = right;
}
- (void)setNavBackGroundClearColor{
    UIColor *color = [UIColor clearColor];
    UIImage *image = [self imageWithColor:color];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:image];
}
- (UIImage *)imageWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
}

- (void)setNavTitleView:(UIView *)titleView{
    self.navigationItem.titleView = titleView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
