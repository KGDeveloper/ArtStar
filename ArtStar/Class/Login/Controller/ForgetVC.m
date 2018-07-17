/**
 
 ArtStar
 
 Created by: KG丿轩帝 on 2018/4/19
 
 Copyright (c) 2017 My Company
 
 ☆★☆★☆★☆★☆★☆★☆★☆★☆
 ★　　│　心想　│　事成　│　　★
 ☆别╭═╮　　 ╭═╮　　 ╭═╮别☆
 ★恋│人│　　│奎│　　│幸│恋★
 ☆　│氣│　　│哥│　　│福│　☆
 ★　│超│　　│制│　　│滿│　★
 ☆别│旺│　　│作│　　│滿│别☆
 ★恋│㊣│　　│㊣│　　│㊣│恋★
 ☆　╰═╯ 天天╰═╯ 開心╰═╯　☆
 ★☆★☆★☆★☆★☆★☆★☆★☆★.
 
 */

#import "ForgetVC.h"
#import "LoginVC.h"

@interface ForgetVC ()
<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *returnTop;
/**
 头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
/**
 头像居上
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerImageTop;
/**
 手机号图标
 */
@property (weak, nonatomic) IBOutlet UIImageView *phoneImage;
/**
 手机号输入框
 */
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
/**
 验证码图标
 */
@property (weak, nonatomic) IBOutlet UIImageView *smsImage;
/**
 验证码输入框
 */
@property (weak, nonatomic) IBOutlet UITextField *smsTF;
/**
 获取验证码
 */
@property (weak, nonatomic) IBOutlet UIButton *sendSMS;
/**
 密码图标
 */
@property (weak, nonatomic) IBOutlet UIImageView *passImage;
/**
 密码输入框
 */
@property (weak, nonatomic) IBOutlet UITextField *passTF;
/**
 点击查看密码
 */
@property (weak, nonatomic) IBOutlet UIButton *seePass;
/**
 注册按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *registBtu;
/**
 提示信息
 */
@property (weak, nonatomic) IBOutlet UILabel *msgLab;
/**
 顶部直线
 */
@property (weak, nonatomic) IBOutlet UIView *topLine;
/**
 中间直线
 */
@property (weak, nonatomic) IBOutlet UIView *centerLine;
/**
 底部直线
 */
@property (weak, nonatomic) IBOutlet UIView *buttomLine;
/**
 获取验证码定时器
 */
@property (nonatomic,strong) NSTimer *timer;
/**
 计数器
 */
@property (nonatomic,assign) NSInteger number;
/**
 判断手机号是否规范
 */
@property (nonatomic,assign) BOOL phoneShure;
/**
 判断验证码是否规范
 */
@property (nonatomic,assign) BOOL smsShure;
/**
 判断密码是否规范
 */
@property (nonatomic,assign) BOOL passShure;
@property (weak, nonatomic) IBOutlet UILabel *errorLab;

@end

@implementation ForgetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _number = 60;
    _phoneShure = NO;
    _passShure = NO;
    _smsShure = NO;

    self.returnTop.constant = NavTopHeight - 35;
    self.headerImageTop.constant = NavTopHeight + 25;
    
    self.phoneTF.delegate = self;
    self.smsTF.delegate = self;
    self.passTF.delegate = self;
}
/**
 返回按钮点击事件

 @param sender 返回按钮
 */
- (IBAction)returnClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
/**
 获取验证码按钮点击事件

 @param sender 获取验证码按钮
 */
- (IBAction)sendSMSClick:(UIButton *)sender {
    [self sendSMSToServer];
    sender.enabled = NO;
}
/**
 查看密码按钮点击事件

 @param sender 查看密码按钮
 */
- (IBAction)seePassClick:(UIButton *)sender {
    /*如果是密码登录状态，点击打开密文输入或者关闭密文输入*/
    if (self.passTF.secureTextEntry == YES) {
        self.passTF.secureTextEntry = NO;
        [sender setImage:Image(@"输入密码可见-点击") forState:UIControlStateNormal];
    }else{
        self.passTF.secureTextEntry = YES;
        [sender setImage:Image(@"输入密码不可见") forState:UIControlStateNormal];
    }
}
/**
 忘记密码点击按钮

 @param sender 忘记密码按钮
 */
- (IBAction)forgetClick:(UIButton *)sender {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak typeof(self) mySelf = self;
    [KGRequestNetWorking postWothUrl:toSetPayrollPwd parameters:@{@"telphone":_phoneTF.text,@"msgAuthCode":_smsTF.text,@"password":_passTF.text} succ:^(id result) {
        if ([result[@"code"] integerValue] == 200) {
            mySelf.errorLab.hidden = NO;
            mySelf.errorLab.text = @"修改成功，2s后自动跳转登录页面";
            sleep(2);
            mySelf.errorLab.hidden = YES;
            LoginVC *loginVC = [[LoginVC alloc]init];
            [mySelf presentViewController:loginVC animated:YES completion:nil];
        }else{
            mySelf.errorLab.hidden = NO;
            mySelf.errorLab.text = @"修改失败";
        }
        [MBProgressHUD hideHUDForView:mySelf.view animated:YES];
    } fail:^(NSError *error) {
        mySelf.errorLab.hidden = NO;
        mySelf.errorLab.text = @"访问服务器失败";
        [MBProgressHUD hideHUDForView:mySelf.view animated:YES];
    }];
}
//MARK:--UITextFieldDelegate--
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == self.phoneTF) {
        if ([self valueFrameTextField:self.phoneTF] == 11) {
            _phoneShure = YES;
            _topLine.backgroundColor = Color_333333;
            [_phoneImage setTintColor:Color_333333];
            _phoneImage.image = [_phoneImage.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        }else{
            self.msgLab.hidden = NO;
            self.msgLab.text = @"手机号格式错误";
            _phoneShure = NO;
            _topLine.backgroundColor = Color_999999;
            _phoneImage.image = [_phoneImage.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
    }else if (textField == self.passTF){
        if ([self valueFrameTextField:self.passTF] >= 6 && [self valueFrameTextField:self.passTF] <= 16) {
            _passShure = YES;
            _buttomLine.backgroundColor = Color_333333;
            [_passImage setTintColor:Color_333333];
            _passImage.image = [_passImage.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        }else{
            self.msgLab.hidden = NO;
            self.msgLab.text = @"密码格式错误";
            _passShure = NO;
            _buttomLine.backgroundColor = Color_999999;
            _passImage.image = [_passImage.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
    }else{
        if ([self valueFrameTextField:self.smsTF] == 6) {
            _smsShure = YES;
            _centerLine.backgroundColor = Color_333333;
            [_smsImage setTintColor:Color_333333];
            _smsImage.image = [_smsImage.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        }else{
            self.msgLab.hidden = NO;
            self.msgLab.text = @"验证码格式错误";
            _smsShure = NO;
            _centerLine.backgroundColor = Color_999999;
            _smsImage.image = [_smsImage.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
    }
    if (_phoneShure == YES && _passShure == YES && _smsShure == YES) {
        self.msgLab.hidden = YES;
        self.registBtu.enabled = YES;
        self.registBtu.backgroundColor = Color_333333;
    }
}
- (NSInteger)valueFrameTextField:(UITextField *)textF{
    return textF.text.length;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    self.registBtu.enabled = NO;
    self.registBtu.backgroundColor = Color_999999;
}
//MARK:创建定时器，开始发送验证码计时
- (void)sendSMSToServer{
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(requestSMS) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    [KGRequestNetWorking postWothUrl:sendMsgAuthCode parameters:@{@"telphone":_phoneTF.text,@"templateId":@"3"} succ:^(id result) {
        
    } fail:^(NSError *error) {
        
    }];
}
- (void)requestSMS{
    [self.sendSMS setTitle:[NSString stringWithFormat:@"重新获取(%lds)",(long)_number] forState:UIControlStateNormal];
    if (_number == 0) {
        [_timer invalidate];
        _timer = nil;
        _number = 60;
        self.sendSMS.enabled = YES;
        [self.sendSMS setTitle:@"获取验证码" forState:UIControlStateNormal];
    }else{
        _number --;
    }
}
//MARK:--防止输完验证码后登陆成功，但是定时器还没有被释放--
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_timer invalidate];
    _timer = nil;
    _number = 60;
    self.sendSMS.enabled = YES;
    [self.sendSMS setTitle:@"获取验证码" forState:UIControlStateNormal];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.phoneTF resignFirstResponder];
    [self.smsTF resignFirstResponder];
    [self.passTF resignFirstResponder];
    
    
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
