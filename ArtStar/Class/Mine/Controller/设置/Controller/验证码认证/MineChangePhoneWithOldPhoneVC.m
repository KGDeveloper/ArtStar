//
//  MineChangePhoneWithOldPhoneVC.m
//  ArtStar
//
//  Created by abc on 2018/6/19.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineChangePhoneWithOldPhoneVC.h"
#import "MinePasswordTF.h"

@interface MineChangePhoneWithOldPhoneVC ()<UITextFieldDelegate>{
    NSTimer *_timer;
    NSInteger _number;
}

@property (nonatomic,strong) MinePasswordTF *phoneTF;
@property (nonatomic,strong) MinePasswordTF *smsTF;
@property (nonatomic,strong) UIButton *questSMSBtu;
@property (nonatomic,strong) UIButton *finishBtu;
@property (nonatomic,strong) UILabel *errorLab;

@end

@implementation MineChangePhoneWithOldPhoneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBtuWithFrame:CGRectMake(0, 0, 150, 30) title:@"短信认证" image:Image(@"back")];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUI];
}

- (void)setUI{
    
    _phoneTF = [[MinePasswordTF alloc]initWithFrame:CGRectMake(50, NavTopHeight + 100, kScreenWidth - 100, 30)];
    _phoneTF.leftView = [self setLeftViewImage:Image(@"账号-未点击")];
    _phoneTF.leftViewMode = UITextFieldViewModeAlways;
    _phoneTF.placeholder = @"请输入您的手机号";
    _phoneTF.font = SYFont(14);
    _phoneTF.textColor = Color_333333;
    _phoneTF.delegate = self;
    [self.view addSubview:_phoneTF];
    
    UIView *topline = [[UIView alloc]initWithFrame:CGRectMake(50, NavTopHeight + 140, kScreenWidth - 100, 1)];
    topline.backgroundColor = Color_ededed;
    [self.view addSubview:topline];
    
    _smsTF = [[MinePasswordTF alloc]initWithFrame:CGRectMake(50, NavTopHeight + 160,150, 30)];
    _smsTF.leftView = [self setLeftViewImage:Image(@"绑定手机号")];
    _smsTF.leftViewMode = UITextFieldViewModeAlways;
    _smsTF.placeholder = @"请输入验证码";
    _smsTF.font = SYFont(14);
    _smsTF.textColor = Color_333333;
    _smsTF.delegate = self;
    _smsTF.secureTextEntry = YES;
    [self.view addSubview:_smsTF];
    
    _questSMSBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _questSMSBtu.frame = CGRectMake(kScreenWidth - 120, NavTopHeight + 160, 70, 30);
    [_questSMSBtu setTitle:@"获取验证码" forState:UIControlStateNormal];
    _questSMSBtu.titleLabel.font = SYFont(12);
    [_questSMSBtu setTitleColor:Color_999999 forState:UIControlStateNormal];
    _questSMSBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [_questSMSBtu addTarget:self action:@selector(questSMS:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_questSMSBtu];
    
    UIView *lowline = [[UIView alloc]initWithFrame:CGRectMake(50, NavTopHeight + 190, kScreenWidth - 100, 1)];
    lowline.backgroundColor = Color_ededed;
    [self.view addSubview:lowline];
    
    _finishBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _finishBtu.frame = CGRectMake(50, NavTopHeight + 240, kScreenWidth - 100, 40);
    _finishBtu.backgroundColor = Color_999999;
    _finishBtu.enabled = NO;
    [_finishBtu setTitle:@"提交" forState:UIControlStateNormal];
    [_finishBtu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _finishBtu.titleLabel.font = SYFont(16);
    [_finishBtu addTarget:self action:@selector(nextTouchUpInSide:) forControlEvents:UIControlEventTouchUpInside];
    _finishBtu.layer.cornerRadius = 5;
    _finishBtu.layer.masksToBounds = YES;
    [self.view addSubview:_finishBtu];
    
    _errorLab = [[UILabel alloc]initWithFrame:CGRectMake(50, NavTopHeight + 195, kScreenWidth - 100, 11)];
    _errorLab.text = @"验证码错误";
    _errorLab.font = SYFont(11);
    _errorLab.textColor = [UIColor colorWithHexString:@"#ff6666"];
    _errorLab.hidden = YES;
    [self.view addSubview:_errorLab];
    
}

- (void)questSMS:(UIButton *)sender{
    sender.enabled = NO;
    _number = 60;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeButtonTitle) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    __weak typeof(self) weakSelf = self;
    [KGRequestNetWorking postWothUrl:sendMsgAuthCode parameters:@{@"telphone":_phoneTF.text,@"templateId":@"3"} succ:^(id result) {
        if ([result[@"code"] integerValue] == 200) {
            [MBProgressHUD bwm_showTitle:@"发送成功，注意接收" toView:weakSelf.view hideAfter:1];
        }else{
            [MBProgressHUD bwm_showTitle:@"发送验证码失败" toView:weakSelf.view hideAfter:1];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD bwm_showTitle:@"请求失败" toView:weakSelf.view hideAfter:1];
    }];
}

- (void)changeButtonTitle{
    [_questSMSBtu setTitle:[NSString stringWithFormat:@"%lds后重新获取",(long)_number] forState:UIControlStateNormal];
    if (_number == 0) {
        _questSMSBtu.enabled = YES;
        _number = 60;
        [_timer invalidate];
        _timer = nil;
        [_questSMSBtu setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
    _number--;
}

- (void)nextTouchUpInSide:(UIButton *)sender{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak typeof(self) weakSelf = self;
    if ([_phoneTF.placeholder isEqualToString:@"请输入您的手机号"]) {
        [KGRequestNetWorking postWothUrl:SendVerificationNumbers parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"telphone":_phoneTF.text,@"content":_smsTF.text} succ:^(id result) {
            [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
            if ([result[@"code"] integerValue] == 200) {
                [MBProgressHUD bwm_showTitle:@"验证通过" toView:weakSelf.view hideAfter:1];
                weakSelf.phoneTF.text = @"";
                weakSelf.phoneTF.placeholder = @"请输入您的新手机号";
                weakSelf.smsTF.text = @"";
                [self->_timer invalidate];
                self->_timer = nil;
            }else{
                [MBProgressHUD bwm_showTitle:@"验证失败" toView:weakSelf.view hideAfter:1];
            }
        } fail:^(NSError *error) {
            [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
            [MBProgressHUD bwm_showTitle:@"请求出错" toView:weakSelf.view hideAfter:1];
        }];
    }else{
        [KGRequestNetWorking postWothUrl:SendVerificationNumbers parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"telphone":_phoneTF.text,@"content":_smsTF.text} succ:^(id result) {
            [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
            if ([result[@"code"] integerValue] == 200) {
                [MBProgressHUD bwm_showTitle:@"您的手机号码已经修改成功，登录密码不变，请下次使用新的手机号码登录" toView:weakSelf.view hideAfter:1];
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }else{
                [MBProgressHUD bwm_showTitle:@"修改失败" toView:weakSelf.view hideAfter:1];
            }
        } fail:^(NSError *error) {
            [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
            [MBProgressHUD bwm_showTitle:@"请求出错" toView:weakSelf.view hideAfter:1];
        }];
    }
}

- (UIImageView *)setLeftViewImage:(UIImage *)image{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 16,20)];
    imageView.image = image;
    return imageView;
}

- (void)viewWillDisappear:(BOOL)animated{
    [_timer invalidate];
    _timer = nil;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (_phoneTF.text.length > 1) {
        _questSMSBtu.enabled = YES;
        if (_smsTF.text.length > 1) {
            _finishBtu.enabled = YES;
            _finishBtu.backgroundColor = Color_333333;
        }else{
            _finishBtu.enabled = NO;
            _finishBtu.backgroundColor = Color_999999;
        }
    }else{
        _questSMSBtu.enabled = NO;
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
