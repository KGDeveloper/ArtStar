//
//  MyselfWorksDetaialVC.m
//  ArtStar
//
//  Created by abc on 2018/7/2.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MyselfWorksDetaialVC.h"

@interface MyselfWorksDetaialVC ()

@property (nonatomic,strong) UIImageView *backImageView;
@property (nonatomic,strong) UILabel *detailLab;

@end

@implementation MyselfWorksDetaialVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLeftBtuWithFrame:CGRectMake(0, 0, 150, 30) title:@"多雨的小镇" image:Image(@"backwhite") color:[UIColor whiteColor]];
    self.view.backgroundColor = [UIColor blackColor];
    
    [self setUI];
}

- (void)setUI{
    _backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, NavTopHeight, kScreenWidth, kScreenHeight - NavTopHeight)];
    _backImageView.image = Image(@"2");
    _backImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_backImageView];
    
    _detailLab = [[UILabel alloc]initWithFrame:CGRectMake(15, kScreenHeight - 115, kScreenWidth - 30, 115)];
    _detailLab.text = @"安达市多阿斯达啊奥术大师多发生过的风格是的气温可能今年出口的客气点进去我叫你卡上啊思密达阿斯达按时到那时，但加拿大安科技大厦南科大伤口就打算买的阿门是的马上你打算明年的啊什么打算明年的啊";
    _detailLab.numberOfLines = 5;
    _detailLab.textColor = [UIColor whiteColor];
    _detailLab.font = SYFont(13);
    [self.view addSubview:_detailLab];
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
