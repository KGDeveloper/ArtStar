//
//  ThemeVC.m
//  ArtStar
//
//  Created by abc on 5/7/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "ThemeVC.h"

@interface ThemeVC ()<ChangeTheModelViewDelegate>

@property (nonatomic,assign) EditThemeType chooseModel;//:--选择好的模板--
@property (nonatomic,strong) ChangeTheModelView *modelView;

@end

@implementation ThemeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBtuWithFrame:CGRectMake(0, 0, 150, 30) title:@"编辑卡片" image:Image(@"back")];
    [self setRightBtuWithFrame:CGRectMake(0, 0, 50, 30) title:@"预览" image:nil];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#fafafa"];
    
    _modelView = [[ChangeTheModelView alloc]initWithFrame:self.view.frame type:EditTypeTheme];
    _modelView.delegate = self;
    _modelView.themeType = _typeName;
    [self.view addSubview:_modelView];
}
- (void)leftNavBtuAction:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)rightNavBtuAction:(UIButton *)sender{
    PreviewVC *vc = [[PreviewVC alloc]init];
    vc.model = _modelView.model;
    if (_modelView.model.isShure == YES) {
        vc.type = EditTypeTheme;
        vc.themeType = _modelView.themeType;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [MBProgressHUD bwm_showTitle:@"请填写完成信息" toView:self.view hideAfter:1];
    }
}
//MARK:--ChangeTheModelViewDelegate--
- (void)pushViewControllerWithVC:(YourLocationVC *)vc{
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
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
