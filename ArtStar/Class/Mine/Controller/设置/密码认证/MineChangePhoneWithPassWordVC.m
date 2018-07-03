//
//  MineChangePhoneWithPassWordVC.m
//  ArtStar
//
//  Created by abc on 2018/6/19.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineChangePhoneWithPassWordVC.h"
#import "MinePasswordTF.h"
#import "MineChangePhoneWithPassFinishVC.h"

@interface MineChangePhoneWithPassWordVC ()<UITextFieldDelegate>

@property (nonatomic,strong) MinePasswordTF *passTF;
@property (nonatomic,strong) UIButton *netBtu;
@property (nonatomic,strong) UILabel *errorLab;

@property (nonatomic,assign) BOOL status;

@end

@implementation MineChangePhoneWithPassWordVC


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBtuWithFrame:CGRectMake(0, 0, 150, 30) title:@"密码认证" image:Image(@"back")];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _status = NO;
    [self setUI];
}

- (void)setUI{
    
    _passTF = [[MinePasswordTF alloc]initWithFrame:CGRectMake(50, NavTopHeight + 100, kScreenWidth - 100, 30)];
    _passTF.leftView = [self setLeftView];
    _passTF.rightView = [self setRightView];
    _passTF.leftViewMode = UITextFieldViewModeAlways;
    _passTF.rightViewMode = UITextFieldViewModeAlways;
    _passTF.placeholder = @"请输入您的登录密码";
    _passTF.font = SYFont(14);
    _passTF.textColor = Color_333333;
    _passTF.delegate = self;
    _passTF.secureTextEntry = YES;
    [self.view addSubview:_passTF];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(50, NavTopHeight + 140, kScreenWidth - 100, 1)];
    line.backgroundColor = Color_ededed;
    [self.view addSubview:line];
    
    _errorLab = [[UILabel alloc]initWithFrame:CGRectMake(50, NavTopHeight + 145, kScreenWidth - 100, 11)];
    _errorLab.text = @"登录密码错误";
    _errorLab.font = SYFont(11);
    _errorLab.textColor = [UIColor colorWithHexString:@"#ff6666"];
    _errorLab.hidden = YES;
    [self.view addSubview:_errorLab];
    
    _netBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _netBtu.frame = CGRectMake(50, NavTopHeight + 190, kScreenWidth - 100, 40);
    _netBtu.backgroundColor = Color_999999;
    [_netBtu setTitle:@"下一步" forState:UIControlStateNormal];
    [_netBtu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _netBtu.titleLabel.font = SYFont(16);
    [_netBtu addTarget:self action:@selector(nextTouchUpInSide:) forControlEvents:UIControlEventTouchUpInside];
    _netBtu.layer.cornerRadius = 5;
    _netBtu.layer.masksToBounds = YES;
    [self.view addSubview:_netBtu];
    
}

- (void)nextTouchUpInSide:(UIButton *)sender{
    _errorLab.hidden = NO;
    [self pushNoTabBarViewController:[[MineChangePhoneWithPassFinishVC alloc]init] animated:YES];
}

- (UIImageView *)setLeftView{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 16,20)];
    imageView.image = Image(@"密码");
    return imageView;
}
- (UIButton *)setRightView{
    UIButton *rightBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtu.frame = CGRectMake(0, 0, 16,11);
    [rightBtu setImage:Image(@"输入密码不可见") forState:UIControlStateNormal];
    [rightBtu addTarget:self action:@selector(selectPssWord:) forControlEvents:UIControlEventTouchUpInside];
    return rightBtu;
}

- (void)selectPssWord:(UIButton *)sender{
    if (_status == YES) {
        _passTF.secureTextEntry = NO;
        _status = NO;
    }else{
        _passTF.secureTextEntry = YES;
        _status = YES;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.text.length > 6) {
        _netBtu.backgroundColor = Color_333333;
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
