//
//  VideoVC.m
//  ArtStar
//
//  Created by abc on 5/7/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "VideoVC.h"

@interface VideoVC ()<ChangeTheModelViewDelegate>

@property (nonatomic,assign) EditVideoType chooseModel;//:--选择好的模板--
@property (nonatomic,strong) ChangeTheModelView *modelView;//:--编辑卡片--

@end

@implementation VideoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBtuWithFrame:CGRectMake(0, 0, 150, 30) title:@"编辑卡片" image:Image(@"back")];
    [self setRightBtuWithFrame:CGRectMake(0, 0, 50, 30) title:@"预览" image:nil];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#fafafa"];
    
    _modelView = [[ChangeTheModelView alloc]initWithFrame:self.view.frame type:EditTypeVideo];
    _modelView.delegate = self;
    [self.view addSubview:_modelView];
}
- (void)leftNavBtuAction:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)rightNavBtuAction:(UIButton *)sender{
    PreviewVC *vc = [[PreviewVC alloc]init];
    vc.model = _modelView.model;
    if ([_modelView.model.location isEqualToString:@"你在哪里？"]) {
        [[MBProgressHUD showHUDAddedTo:self.view animated:YES] bwm_hideWithTitle:@"请选择你的位置" hideAfter:1];
    }else{
        vc.type = EditTypeVideo;
        vc.videoType = _modelView.videoType;
        [self.navigationController pushViewController:vc animated:YES];
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
