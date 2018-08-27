//
//  ScoreViewController.m
//  ArtStar
//
//  Created by 文艺星球 on 2018/8/27.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "ScoreViewController.h"

@interface ScoreViewController ()

@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) UIView *starView;
@property (nonatomic,strong) UILabel *leveLab;
@property (nonatomic,strong) YYTextView *ideaView;
@property (nonatomic,assign) NSInteger scroe;

@end

@implementation ScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLeftBtuWithFrame:CGRectMake(15, 0, 150, 30) title:@"评分" image:Image(@"back")];
    [self setRightBtuWithFrame:CGRectMake(0, 0, 50, 30) title:@"确定" image:nil];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setStarViewUI];
    [self setViewUI];
}
// MARK: --评分--
- (void)rightNavBtuAction:(UIButton *)sender{
    if (_ideaView.text.length > 0) {
        __weak typeof(self) weakSelf = self;
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [KGRequestNetWorking postWothUrl:addCommentByUidSid parameters:@{@"sid":_newsID,@"uid":[KGUserInfo shareInterace].userID,@"pingjia":_ideaView.text,@"pingfen":@(_scroe)} succ:^(id result) {
            [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
            if ([result[@"code"] integerValue] == 200) {
                [MBProgressHUD bwm_showTitle:@"评价成功" toView:weakSelf.view hideAfter:1];
                sleep(3);
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }else{
                [MBProgressHUD bwm_showTitle:@"评价失败" toView:weakSelf.view hideAfter:1];
            }
        } fail:^(NSError *error) {
            [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
            [MBProgressHUD bwm_showTitle:@"评价失败" toView:weakSelf.view hideAfter:1];
        }];
    }else{
        [MBProgressHUD bwm_showTitle:@"请对进行评分" toView:self.view hideAfter:1];
    }
}

- (void)setViewUI{
    
    _ideaView = [[YYTextView alloc]initWithFrame:CGRectMake(15, NavTopHeight + 160, kScreenWidth - 30, 175)];
    _ideaView.placeholderText = @"写几句评价吧...";
    _ideaView.placeholderFont = SYFont(13);
    _ideaView.placeholderTextColor = Color_cccccc;
    _ideaView.textColor = Color_333333;
    _ideaView.font = SYFont(13);
    _ideaView.layer.borderWidth = 1;
    _ideaView.layer.borderColor = Color_ededed.CGColor;
    _ideaView.layer.cornerRadius = 5;
    _ideaView.layer.masksToBounds = YES;
    [self.view addSubview:_ideaView];
    
}

- (void)setStarViewUI{
    
    _starView = [[UIView alloc]initWithFrame:CGRectMake(0, NavTopHeight + 30, kScreenWidth, 110)];
    [self.view addSubview:_starView];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, kScreenWidth, 15)];
    titleLab.text = @"点击星星评分";
    titleLab.textColor = Color_333333;
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = SYFont(14);
    [_starView addSubview:titleLab];
    
    for (int i = 0; i < 5; i++) {
        [_starView addSubview:[self createStarButtonWithFrame:CGRectMake(kScreenWidth/2 - 67.5 + 30*i, 65, 15, 15) tag:200+i]];
    }
    
    _leveLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 90, kScreenWidth, 12)];
    _leveLab.text = @"";
    _leveLab.textColor = Color_999999;
    _leveLab.textAlignment = NSTextAlignmentCenter;
    _leveLab.font = SYFont(12);
    [_starView addSubview:_leveLab];
    
}

- (UIButton *)createStarButtonWithFrame:(CGRect)frame tag:(NSInteger)tag{
    UIButton *norBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    norBtu.frame = frame;
    norBtu.tag = tag;
    [norBtu setImage:Image(@"stargray") forState:UIControlStateNormal];
    [norBtu addTarget:self action:@selector(starbuttonAction:) forControlEvents:UIControlEventTouchUpInside];
    return norBtu;
}
- (void)starbuttonAction:(UIButton *)sender{
    for (id obj in _starView.subviews) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *norBtu = obj;
            if (norBtu.tag <= sender.tag) {
                [norBtu setImage:Image(@"star") forState:UIControlStateNormal];
            }else{
                [norBtu setImage:Image(@"stargray") forState:UIControlStateNormal];
            }
        }
    }
    if (sender.tag == 200) {
        _leveLab.text = @"写的很差";
        _scroe = 1;
    }else if (sender.tag == 201){
        _leveLab.text = @"写的一般";
        _scroe = 2;
    }else if (sender.tag == 202){
        _leveLab.text = @"写的还不错";
        _scroe = 3;
    }else if (sender.tag == 203){
        _leveLab.text = @"推荐";
        _scroe = 4;
    }else{
        _leveLab.text = @"极力推荐";
        _scroe = 5;
    }
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
