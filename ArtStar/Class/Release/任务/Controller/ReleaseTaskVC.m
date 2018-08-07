//
//  ReleaseTaskVC.m
//  ArtStar
//
//  Created by 文艺星球 on 2018/8/3.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "ReleaseTaskVC.h"
#import "ReleaseTaskView.h"

@interface ReleaseTaskVC ()

/**
 发布任务按钮
 */
@property (nonatomic,strong) UIButton *releaseTaskBtu;
/**
 接取任务按钮
 */
@property (nonatomic,strong) UIButton *makeTaskBtu;
/**
 滑动线条
 */
@property (nonatomic,strong) UIView *line;
/**
 发布任务界面
 */
@property (nonatomic,strong) ReleaseTaskView *releaseTaskView;

@end

@implementation ReleaseTaskVC

- (void)leftNavBtuAction:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLeftBtuWithFrame:CGRectMake(0, 0, 150, 30) title:@"任务" image:Image(@"back")];
    [self setRightBtuWithFrame:CGRectMake(0, 0, 50, 30) title:nil image:Image(@"清单")];
    self.view.backgroundColor = [UIColor whiteColor];
    // !!!: --创建顶部发布任务以及接取任务切换按钮--
    [self setTopHeaderViewUI];
    [self.view bringSubviewToFront:self.releaseTaskView];
}
// MARK: --顶部切换热不任务和接去任务--
- (void)setTopHeaderViewUI{
    // !!!: --发布任务--
    _releaseTaskBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _releaseTaskBtu.frame = CGRectMake(0, NavTopHeight, kScreenWidth/2,48);
    [_releaseTaskBtu setTitle:@"发布任务" forState:UIControlStateNormal];
    [_releaseTaskBtu setTitleColor:Color_333333 forState:UIControlStateNormal];
    _releaseTaskBtu.titleLabel.font = SYFont(15);
    [_releaseTaskBtu addTarget:self action:@selector(releaseTaskAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_releaseTaskBtu];
    // !!!: --接取任务--
    _makeTaskBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _makeTaskBtu.frame = CGRectMake(kScreenWidth/2, NavTopHeight, kScreenWidth/2,48);
    [_makeTaskBtu setTitle:@"接取任务" forState:UIControlStateNormal];
    [_makeTaskBtu setTitleColor:Color_999999 forState:UIControlStateNormal];
    _makeTaskBtu.titleLabel.font = SYFont(14);
    [_makeTaskBtu addTarget:self action:@selector(makeTaskAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_makeTaskBtu];
    // !!!: --滑动线条--
    _line = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth/4 - 30, NavTopHeight + 48, 60, 2)];
    _line.backgroundColor = Color_333333;
    [self.view addSubview:_line];
    // !!!: --底部线条--
    UIView *lowLine = [[UIView alloc]initWithFrame:CGRectMake(0, NavTopHeight + 49, kScreenWidth, 1)];
    lowLine.backgroundColor = Color_ededed;
    [self.view addSubview:lowLine];
}
// MARK: --发布任务点击事件--
- (void)releaseTaskAction:(UIButton *)sender{
    [sender setTitleColor:Color_333333 forState:UIControlStateNormal];
    sender.titleLabel.font = SYFont(15);
    [_makeTaskBtu setTitleColor:Color_999999 forState:UIControlStateNormal];
    _makeTaskBtu.titleLabel.font = SYFont(14);
    [UIView animateWithDuration:0.2 animations:^{
        self.line.centerX = sender.centerX;
    }];
}
// MARK: --接取任务点击事件--
- (void)makeTaskAction:(UIButton *)sender{
    [sender setTitleColor:Color_333333 forState:UIControlStateNormal];
    sender.titleLabel.font = SYFont(15);
    [_releaseTaskBtu setTitleColor:Color_999999 forState:UIControlStateNormal];
    _releaseTaskBtu.titleLabel.font = SYFont(14);
    [UIView animateWithDuration:0.2 animations:^{
        self.line.centerX = sender.centerX;
    }];
}
// MARK: --发布任务界面--
- (ReleaseTaskView *)releaseTaskView{
    if (!_releaseTaskView) {
        _releaseTaskView = [[ReleaseTaskView alloc]initWithFrame:CGRectMake(0, NavTopHeight + 50, kScreenWidth, kScreenHeight - NavTopHeight - 50)];
        [self.view addSubview:_releaseTaskView];
    }
    return _releaseTaskView;
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
