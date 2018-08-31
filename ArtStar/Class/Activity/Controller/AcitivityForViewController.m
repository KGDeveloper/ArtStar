//
//  AcitivityForViewController.m
//  ArtStar
//
//  Created by 文艺星球 on 2018/8/31.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "AcitivityForViewController.h"

@interface AcitivityForViewController ()

@property (nonatomic,strong) ViewForActivity *activityView;

@end

@implementation AcitivityForViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNavBackGroundClearColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLeftBtuWithFrame:CGRectMake(0, 0, 50, 30) title:nil image:Image(@"back")];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setButton];
}
// MARK: --创建右侧点击按钮--
- (void)setButton{
    UIButton *rulesBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    rulesBtu.frame = CGRectMake(kScreenWidth - 75, NavTopHeight + 50, 60, 25);
    [rulesBtu setTitle:@"活动规则" forState:UIControlStateNormal];
    [rulesBtu setTitleColor:Color_333333 forState:UIControlStateNormal];
    rulesBtu.titleLabel.font = SYFont(12);
    rulesBtu.backgroundColor = Color_fafafa;
    rulesBtu.layer.cornerRadius = 5;
    rulesBtu.layer.masksToBounds = YES;
    [rulesBtu addTarget:self action:@selector(rulesAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rulesBtu];
    
    UIButton *clockBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    clockBtu.frame = CGRectMake(kScreenWidth - 75, NavTopHeight + 85, 60, 25);
    [clockBtu setTitle:@"打卡记录" forState:UIControlStateNormal];
    [clockBtu setTitleColor:Color_333333 forState:UIControlStateNormal];
    clockBtu.titleLabel.font = SYFont(12);
    clockBtu.backgroundColor = Color_fafafa;
    clockBtu.layer.cornerRadius = 5;
    clockBtu.layer.masksToBounds = YES;
    [clockBtu addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clockBtu];
    
    UIButton *prizeBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    prizeBtu.frame = CGRectMake(kScreenWidth - 75, NavTopHeight + 120, 60, 25);
    [prizeBtu setTitle:@"关于奖品" forState:UIControlStateNormal];
    [prizeBtu setTitleColor:Color_333333 forState:UIControlStateNormal];
    prizeBtu.titleLabel.font = SYFont(12);
    prizeBtu.backgroundColor = Color_fafafa;
    prizeBtu.layer.cornerRadius = 5;
    prizeBtu.layer.masksToBounds = YES;
    [prizeBtu addTarget:self action:@selector(prizeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:prizeBtu];
}
// MARK: --活动规则点击事件--
- (void)rulesAction{
    
}
// MARK: --打卡记录点击事件--
- (void)clickAction{
    
}
// MARK: --关于奖品点击事件--
- (void)prizeAction{
    
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
