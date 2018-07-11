/**
 
 ArtStar
 
 Created by: KG丿轩帝 on 2018/4/28
 
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

#import "FirstSMSLoginVC.h"
#import "RegisterVC.h"
#import "ForgetVC.h"

@interface FirstSMSLoginVC ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *returnBtu;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *returnTop;
@property (weak, nonatomic) IBOutlet UIImageView *headerIamge;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageTop;
@property (weak, nonatomic) IBOutlet UIView *topLine;
@property (weak, nonatomic) IBOutlet UIView *centerLine;
@property (weak, nonatomic) IBOutlet UIView *buttomLine;
@property (weak, nonatomic) IBOutlet UIImageView *phoneImage;
@property (weak, nonatomic) IBOutlet UIImageView *smsImage;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *smsTF;
@property (weak, nonatomic) IBOutlet UIButton *smsBtu;
@property (weak, nonatomic) IBOutlet UIButton *loadBtu;
@property (weak, nonatomic) IBOutlet UIButton *agreeBtu;
@property (weak, nonatomic) IBOutlet UIButton *readBtu;
@property (weak, nonatomic) IBOutlet UIButton *netBtu;
@property (weak, nonatomic) IBOutlet UIButton *loginBtu;
@property (weak, nonatomic) IBOutlet UIButton *forgetBtu;
@property (weak, nonatomic) IBOutlet UILabel *topErrorLab;
@property (weak, nonatomic) IBOutlet UILabel *buttomErrorBtu;
@property (weak, nonatomic) IBOutlet UITextField *passWordTF;

@property (nonatomic,assign) BOOL writePhone;
@property (nonatomic,assign) BOOL writePass;
@property (nonatomic,assign) BOOL writeSMS;
@property (nonatomic,assign) BOOL agree;

/**
 获取验证码定时器
 */
@property (nonatomic,strong) NSTimer *timer;
/**
 获取验证码计数
 */
@property (nonatomic,assign) NSInteger number;

@end

@implementation FirstSMSLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _writeSMS = NO;
    _writePass = NO;
    _writePhone = NO;
    _agree = NO;
    
    _phoneTF.delegate = self;
    _smsTF.delegate = self;
    _passWordTF.delegate = self;
    
    self.returnTop.constant = NavTopHeight - 35;
    self.imageTop.constant = NavTopHeight + 25;
    
    _number = 60;
    
}
- (IBAction)returnClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)nextClick:(UIButton *)sender {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak typeof(self) mySelf = self;
    [KGRequestNetWorking postWothUrl:judgeMsgAuthCode parameters:@{@"telphone":_phoneTF.text,@"msgAuthCode":_smsTF.text} succ:^(id result) {
        mySelf.buttomErrorBtu.hidden = YES;
        if ([result[@"message"] isEqualToString:@"操作成功！"]) {
            RegisterVC *registVC = [[RegisterVC alloc]initWithNibName:@"RegisterVC" bundle:nil];
            registVC.isFirst = YES;
            registVC.userPhoneStr = mySelf.phoneTF.text;
            registVC.userPassStr = mySelf.passWordTF.text;
            [self presentViewController:registVC animated:YES completion:nil];
        }
        [MBProgressHUD hideHUDForView:mySelf.view animated:YES];
    } fail:^(NSString *error) {
        mySelf.buttomErrorBtu.hidden = NO;
        mySelf.buttomErrorBtu.text = @"验证码错误";
        [MBProgressHUD hideHUDForView:mySelf.view animated:YES];
    }];
}
- (IBAction)takeSMSCode:(UIButton *)sender {
    [self sendSMSToServer];
    sender.enabled = NO;
}
//MARK:创建定时器，开始发送验证码计时
- (void)sendSMSToServer{
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(requestSMS) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    __weak typeof(self) mySelf = self;
    [KGRequestNetWorking postWothUrl:sendMsgAuthCode parameters:@{@"telphone":_phoneTF.text,@"templateId":@"1"} succ:^(id result) {
        if ([result[@"message"] isEqualToString:@"发送短信失败"]) {
            mySelf.topErrorLab.hidden = NO;
            mySelf.topErrorLab.text = @"验证码发送失败";
        }else{
            mySelf.topErrorLab.hidden = YES;
        }
    } fail:^(NSString *error) {
        mySelf.topErrorLab.hidden = NO;
        mySelf.topErrorLab.text = @"验证码发送失败";
    }];
    
}
- (void)requestSMS{
    [self.smsBtu setTitle:[NSString stringWithFormat:@"重新获取(%lds)",(long)_number] forState:UIControlStateNormal];
    if (_number == 0) {
        [_timer invalidate];
        _timer = nil;
        _number = 60;
        self.smsBtu.enabled = YES;
        [self.smsBtu setTitle:@"获取验证码" forState:UIControlStateNormal];
    }else{
        _number --;
    }
}
- (IBAction)seePassWord:(UIButton *)sender {
    if (_passWordTF.secureTextEntry == YES) {
        [sender setImage:Image(@"输入密码可见-点击") forState:UIControlStateNormal];
    }else{
        [sender setImage:Image(@"输入密码不可见") forState:UIControlStateNormal];
    }
}
- (IBAction)loginClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)forgetClick:(UIButton *)sender {
    ForgetVC *forgetVC = [[ForgetVC alloc]initWithNibName:@"ForgetVC" bundle:nil];
    [self presentViewController:forgetVC animated:YES completion:nil];
}
- (IBAction)agreeClick:(UIButton *)sender {
    if ([sender.currentImage isEqual:Image(@"对号选取框")]) {
        [sender setImage:Image(@"选择框") forState:UIControlStateNormal];
    }else{
        [sender setImage:Image(@"对号选取框") forState:UIControlStateNormal];
    }
}
- (IBAction)readClick:(UIButton *)sender {
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([self valueToInfo] == YES) {
        self.netBtu.backgroundColor = Color_333333;
        self.netBtu.enabled = YES;
    }else{
        self.netBtu.backgroundColor = Color_999999;
        self.netBtu.enabled = NO;
    }
}
- (BOOL)valueToInfo{
    if ([self valueFrameTextField:self.phoneTF] == 11) {
        _writePhone = YES;
    }else{
        _writePhone = NO;
    }
    if ([self valueFrameTextField:self.smsTF] == 6) {
        _writeSMS = YES;
    }else{
        _writeSMS = NO;
    }
    if ([self valueFrameTextField:self.passWordTF] >= 6 && [self valueFrameTextField:self.passWordTF] <= 16) {
        _writePass = YES;
    }else{
        _writePass = NO;
    }
    
    if (_writePhone == YES && _writeSMS == YES && _writePass == YES) {
        return  YES;
    }else{
        return NO;
    }
}
- (NSInteger)valueFrameTextField:(UITextField *)textF{
    return textF.text.length;
}

//MARK:--防止输完验证码后登陆成功，但是定时器还没有被释放--
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_timer invalidate];
    _timer = nil;
    _number = 60;
    self.smsBtu.enabled = YES;
    [self.smsBtu setTitle:@"获取验证码" forState:UIControlStateNormal];
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
