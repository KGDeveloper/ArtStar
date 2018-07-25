//
//  MineChatDetaialViewController.m
//  ArtStar
//
//  Created by abc on 2018/6/26.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineChatDetaialViewController.h"
#import "MsgTapCellHeaderPushFocusVC.h"

@interface MineChatDetaialViewController ()

@end

@implementation MineChatDetaialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:Color_333333,NSFontAttributeName:SYBFont(15)}];
    [self leftNavButton];
    [self rightNavButton];
    
    UIView *custom = [[[NSBundle mainBundle] loadNibNamed:@"MineMessageFirstIntoShowView" owner:self options:nil] lastObject];
    custom.frame = CGRectMake(0,NavTopHeight + 20, 295, 185);
    custom.centerX = kScreenWidth/2;
    [self.view addSubview:custom];
}

- (void)leftNavButton{
    UIButton *leftBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtu.frame = CGRectMake(15, 0,100, 30);
    [leftBtu setImage:Image(@"back") forState:UIControlStateNormal];
    leftBtu.titleLabel.font = SYBFont(15);
    leftBtu.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    leftBtu.imageEdgeInsets = UIEdgeInsetsMake(7.5, 0, 7.5,0);
    leftBtu.imageView.contentMode = UIViewContentModeScaleAspectFill;
    leftBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [leftBtu addTarget:self action:@selector(leftNavBtuAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:leftBtu];
    self.navigationItem.leftBarButtonItem = left;
}
- (void)leftNavBtuAction:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightNavButton{
    UIButton *rightBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtu.frame = CGRectMake(15, 0,100, 30);
    [rightBtu setTitle:@"管理" forState:UIControlStateNormal];
    [rightBtu setTitleColor:Color_333333 forState:UIControlStateNormal];
    rightBtu.titleLabel.font = SYFont(15);
    rightBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightBtu addTarget:self action:@selector(rightNavBtuAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:rightBtu];
    self.navigationItem.rightBarButtonItem = right;
}
- (void)rightNavBtuAction:(UIButton *)sender{
    [self.navigationController pushViewController:[[MsgTapCellHeaderPushFocusVC alloc]init] animated:YES];
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
