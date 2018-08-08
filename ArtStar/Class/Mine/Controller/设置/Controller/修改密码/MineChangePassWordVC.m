//
//  MineChangePassWordVC.m
//  ArtStar
//
//  Created by abc on 2018/6/19.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineChangePassWordVC.h"
#import "MinePasswordTF.h"

@interface MineChangePassWordVC ()<UITextFieldDelegate>{
    BOOL _oldSee;
    BOOL _firstSee;
    BOOL _secondSee;
}

@property (nonatomic,strong) MinePasswordTF *oldPass;
@property (nonatomic,strong) MinePasswordTF *firstNewPass;
@property (nonatomic,strong) MinePasswordTF *secondNewPass;
@property (nonatomic,strong) UIButton *finishBtu;
@property (nonatomic,strong) UILabel *errorLab;

@end

@implementation MineChangePassWordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBtuWithFrame:CGRectMake(0, 0, 150, 30) title:@"密码认证" image:Image(@"back")];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _oldSee = NO;
    _firstSee = NO;
    _secondSee = NO;
    
    [self setUI];
}

- (void)setUI{
    //:--旧密码输入框--
    _oldPass = [[MinePasswordTF alloc]initWithFrame:CGRectMake(50, NavTopHeight + 100, kScreenWidth - 100, 30)];
    _oldPass.leftView = [self setLeftView];
    _oldPass.rightView = [self setRightView];
    _oldPass.leftViewMode = UITextFieldViewModeAlways;
    _oldPass.rightViewMode = UITextFieldViewModeAlways;
    _oldPass.placeholder = @"请输入您的旧密码";
    _oldPass.font = SYFont(14);
    _oldPass.textColor = Color_333333;
    _oldPass.delegate = self;
    _oldPass.secureTextEntry = YES;
    [self.view addSubview:_oldPass];
    
    UIView *topline = [[UIView alloc]initWithFrame:CGRectMake(50, NavTopHeight + 140, kScreenWidth - 100, 1)];
    topline.backgroundColor = Color_ededed;
    [self.view addSubview:topline];
    //:--新密码输入框--
    _firstNewPass = [[MinePasswordTF alloc]initWithFrame:CGRectMake(50, NavTopHeight + 150, kScreenWidth - 100, 30)];
    _firstNewPass.leftView = [self setLeftView];
    _firstNewPass.rightView = [self setRightView];
    _firstNewPass.leftViewMode = UITextFieldViewModeAlways;
    _firstNewPass.rightViewMode = UITextFieldViewModeAlways;
    _firstNewPass.placeholder = @"请输入您的新密码";
    _firstNewPass.font = SYFont(14);
    _firstNewPass.textColor = Color_333333;
    _firstNewPass.delegate = self;
    _firstNewPass.secureTextEntry = YES;
    [self.view addSubview:_firstNewPass];
    
    UIView *centerline = [[UIView alloc]initWithFrame:CGRectMake(50, NavTopHeight + 190, kScreenWidth - 100, 1)];
    centerline.backgroundColor = Color_ededed;
    [self.view addSubview:centerline];
    //:--新密码确认输入框--
    _secondNewPass = [[MinePasswordTF alloc]initWithFrame:CGRectMake(50, NavTopHeight + 200, kScreenWidth - 100, 30)];
    _secondNewPass.leftView = [self setLeftView];
    _secondNewPass.rightView = [self setRightView];
    _secondNewPass.leftViewMode = UITextFieldViewModeAlways;
    _secondNewPass.rightViewMode = UITextFieldViewModeAlways;
    _secondNewPass.placeholder = @"请确认您的新密码";
    _secondNewPass.font = SYFont(14);
    _secondNewPass.textColor = Color_333333;
    _secondNewPass.delegate = self;
    _secondNewPass.secureTextEntry = YES;
    [self.view addSubview:_secondNewPass];
    
    UIView *lowline = [[UIView alloc]initWithFrame:CGRectMake(50, NavTopHeight + 240, kScreenWidth - 100, 1)];
    lowline.backgroundColor = Color_ededed;
    [self.view addSubview:lowline];
    //:--提示文字--
    _errorLab = [[UILabel alloc]initWithFrame:CGRectMake(50, NavTopHeight + 245, kScreenWidth - 100, 11)];
    _errorLab.text = @"新密码输入错误";
    _errorLab.font = SYFont(11);
    _errorLab.textColor = [UIColor colorWithHexString:@"#ff6666"];
    _errorLab.hidden = YES;
    [self.view addSubview:_errorLab];
    //:--下一步按钮，在这里先关闭交互，防止程序请求奔溃--
    _finishBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _finishBtu.frame = CGRectMake(50, NavTopHeight + 290, kScreenWidth - 100, 40);
    _finishBtu.backgroundColor = Color_999999;
    _finishBtu.enabled = NO;
    [_finishBtu setTitle:@"提交" forState:UIControlStateNormal];
    [_finishBtu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _finishBtu.titleLabel.font = SYFont(16);
    [_finishBtu addTarget:self action:@selector(nextTouchUpInSide:) forControlEvents:UIControlEventTouchUpInside];
    _finishBtu.layer.cornerRadius = 5;
    _finishBtu.layer.masksToBounds = YES;
    [self.view addSubview:_finishBtu];
    
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
    if (sender.superview == _oldPass) {
        if (_oldSee == NO) {
            _oldPass.secureTextEntry = NO;
            _oldSee = YES;
        }else{
            _oldPass.secureTextEntry = YES;
            _oldSee = NO;
        }
    }else if (sender.superview == _firstNewPass){
        if (_firstSee == NO) {
            _firstNewPass.secureTextEntry = NO;
            _firstSee = YES;
        }else{
            _firstNewPass.secureTextEntry = YES;
            _firstSee = NO;
        }
    }else{
        if (_secondSee == NO) {
            _secondNewPass.secureTextEntry = NO;
            _secondSee = YES;
        }else{
            _secondNewPass.secureTextEntry = YES;
            _secondSee = NO;
        }
    }
}
// MARK: --先请求旧密码是否正确--
- (void)nextTouchUpInSide:(UIButton *)sender{
    if ([_firstNewPass.text isEqualToString:_secondNewPass.text]) {
        __weak typeof(self) weakSelf = self;
        [MBProgressHUD bwm_showHUDAddedTo:self.view title:@"正在验证旧密码..."];
        [KGRequestNetWorking postWothUrl:checkPasswords parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"id":[KGUserInfo shareInterace].userID,@"password":_oldPass.text} succ:^(id result) {
            [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
            if ([result[@"code"] integerValue] == 200) {
                [weakSelf questChangePassWord];
            }else{
                [MBProgressHUD bwm_showTitle:@"旧密码错误" toView:weakSelf.view hideAfter:1];
            }
        } fail:^(NSError *error) {
            [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
            [MBProgressHUD bwm_showTitle:@"请求出错" toView:weakSelf.view hideAfter:1];
        }];
    }else{
        [MBProgressHUD bwm_showTitle:@"新密码两次输入不一致" toView:self.view hideAfter:1];
    }
}
// MARK: --旧密码验证通过后，修改新密码--
- (void)questChangePassWord{
    __weak typeof(self) weakSelf = self;
    [MBProgressHUD bwm_showHUDAddedTo:self.view title:@"正在修改密码..."];
    [KGRequestNetWorking postWothUrl:SendPassWords parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"id":[KGUserInfo shareInterace].userID,@"password":_firstNewPass.text} succ:^(id result) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        if ([result[@"code"] integerValue] == 200) {
            [MBProgressHUD bwm_showTitle:@"您的登录密码已修改，请下次使用新的登录密码" toView:weakSelf.view hideAfter:1];
        }else{
            [MBProgressHUD bwm_showTitle:@"修改失败" toView:weakSelf.view hideAfter:1];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        [MBProgressHUD bwm_showTitle:@"请求出错" toView:weakSelf.view hideAfter:1];
    }];
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (_oldPass.text.length > 1) {
        if (_firstNewPass.text.length > 1) {
            if (_secondNewPass.text.length > 1) {
                _finishBtu.backgroundColor = Color_333333;
                _finishBtu.enabled = YES;
            }else{
                _finishBtu.backgroundColor = Color_999999;
                _finishBtu.enabled = NO;
            }
        }else{
            _finishBtu.backgroundColor = Color_999999;
            _finishBtu.enabled = NO;
        }
    }else{
        _finishBtu.backgroundColor = Color_999999;
        _finishBtu.enabled = NO;
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
