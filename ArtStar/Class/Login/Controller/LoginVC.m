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

#import "LoginVC.h"
#import "ForgetVC.h"
#import "RegisterVC.h"
#import "FirstSMSLoginVC.h"
#import "AppDelegate.h"
#import "TabBarVC.h"
#import "GuidePageView.h"

@interface LoginVC ()
<UITextFieldDelegate,UIApplicationDelegate>
/**
 头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
/**
 密码登录按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *passLogin;
/**
 短信登录按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *smsLogin;
/**
 手机号输入框图标
 */
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
/**
 手机号输入框
 */
@property (weak, nonatomic) IBOutlet UITextField *userTF;
/**
 密码输入框图标
 */
@property (weak, nonatomic) IBOutlet UIImageView *passWordImage;
/**
 密码输入框
 */
@property (weak, nonatomic) IBOutlet UITextField *passWordTF;
/**
 密码输入框右侧，密文输入状态修改按钮，获取验证码按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *seePassWord;
/**
 登录按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *loginBtu;
/**
 注册按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *registBtu;
/**
 忘记密码按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *forgetBtu;
/**
 快速登录按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *quickLogin;
/**
 修改获取验证码按钮宽度
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *seeBtuWidth;
/**
 修改移动line的中心点
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *moveCenterX;
/**
 移动line
 */
@property (weak, nonatomic) IBOutlet UIView *moveLine;
/**
 获取验证码定时器
 */
@property (nonatomic,strong) NSTimer *timer;
/**
 获取验证码计数
 */
@property (nonatomic,assign) NSInteger number;
/**
 判断手机号是否符合规范
 */
@property (nonatomic,assign) BOOL phoneShure;
/**
 判断密码是否符合规范
 */
@property (nonatomic,assign) BOOL passShure;
/**
 提示标签
 */
@property (weak, nonatomic) IBOutlet UILabel *msgLab;
/**
 快速登录按钮居下距离
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *quickBtuY;
/**
 头像居上的高度
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerTop;
/**
 账号输入框下方直线
 */
@property (weak, nonatomic) IBOutlet UIView *topLine;
/**
 密码输入框下方直线
 */
@property (weak, nonatomic) IBOutlet UIView *buttomLine;
@property (nonatomic,assign) BOOL isSMSLogin;
@property (nonatomic,strong) GuidePageView *guideView;
@property (weak, nonatomic) IBOutlet UILabel *errorLab;

@end

@implementation LoginVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"Guidepage"]) {
        self.guideView.hidden = NO;
        [[NSUserDefaults standardUserDefaults] setObject:@"启动页" forKey:@"Guidepage"];
    }
    [self.seePassWord setTitle:nil forState:UIControlStateNormal];
    [self.seePassWord setImage:Image(@"输入密码不可见") forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _number = 60;
    _phoneShure = NO;
    _passShure = NO;
    _isSMSLogin = NO;
    
    /*首先判断是iPhone X还是iPhone其他机型，然后设置布局*/
    self.quickBtuY.constant = 25 + NavButtomHeight;
    self.headerTop.constant = 80 + NavTopHeight - 44;
    
    /*默认界面加载后显示的是密码登录，所以设置输入框的预留字*/
    self.userTF.placeholder = @"请输入手机号";
    /*遵守代理，观察手机号输入是否完毕*/
    self.userTF.delegate = self;
    self.passWordTF.delegate = self;
    self.passWordTF.placeholder = @"密码";
    
    if (_userTF.text.length == 11 && _passWordTF.text.length >= 6) {
        _loginBtu.backgroundColor = Color_333333;
        _loginBtu.enabled = YES;
    }
    NSNotification *notification =[NSNotification notificationWithName:@"LoginRongClond" object:nil userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
}

- (void)cllLocation{
    if ([CLLocationManager locationServicesEnabled]){
        KGLocationCityManager *manager = [KGLocationCityManager shareManager];
        [manager obtainYourLocation];
    }else if ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusDenied) {
        __weak typeof(self) weakSelf = self;
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您的手机没有给予App定位权限，App无法正常获取到您的位置" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *shureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSURL *url = [NSURL URLWithString:@"App-Prefs:root=LOCATION_SERVICES"];
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                NSDictionary<NSString *,id>*options = @{UIApplicationOpenURLOptionsSourceApplicationKey:@YES};
                [[UIApplication sharedApplication] openURL:url options:options completionHandler:^(BOOL success) {
                    [weakSelf cllLocation];
                }];
            }
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:shureAction];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}
//MARK:--密码登录按钮点击事件--
- (IBAction)passLoginClick:(UIButton *)sender {
    self.forgetBtu.hidden = NO;
    _isSMSLogin = NO;
    if (_number != 60) {
        [_timer setFireDate:[NSDate distantFuture]];
    }
    [UIView animateWithDuration:0.2 animations:^{
        /*点击按钮后，修改line的位置*/
        self.moveCenterX.constant = ViewX(sender);
    } completion:^(BOOL finished) {
        /*点击按钮后，本身字体放大，提示用户当前显示的登录方式*/
        sender.titleLabel.font = FZFont(15.0);
        /*点击按钮后，本身字体变色，提示用户当前显示的登录方式*/
        [sender setTitleColor:Color_333333 forState:UIControlStateNormal];
        /*缩小字体，提示用户非选择状态*/
        self.smsLogin.titleLabel.font = FZFont(13.0);
        /*字体变色，提示用户非选择状态*/
        [self.smsLogin setTitleColor:Color_999999 forState:UIControlStateNormal];
        /*选择按钮后，输入框的提示文字也要随之改变，体现出动感*/
        self.userTF.placeholder = @"请输入手机号";
        self.passWordTF.placeholder = @"密码";
        /*设置只显示图片*/
        [self.seePassWord setTitle:nil forState:UIControlStateNormal];
        [self.seePassWord setImage:Image(@"输入密码不可见") forState:UIControlStateNormal];
        self.seePassWord.enabled = YES;
    }];
}
//MARK:--短信登录按钮点击事件--
- (IBAction)smsLoginClick:(UIButton *)sender {
    self.forgetBtu.hidden = YES;
    _isSMSLogin = YES;
    if (_number != 60) {
        [_timer setFireDate:[NSDate date]];
    }
    __weak typeof(self) mySelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        /*点击按钮后，修改line的位置*/
        self.moveCenterX.constant = ViewX(sender);
    } completion:^(BOOL finished) {
        /*点击按钮后，本身字体放大，提示用户当前显示的登录方式*/
        sender.titleLabel.font = FZFont(15.0);
        /*点击按钮后，本身字体变色，提示用户当前显示的登录方式*/
        [sender setTitleColor:Color_333333 forState:UIControlStateNormal];
        /*缩小字体，提示用户非选择状态*/
        self.passLogin.titleLabel.font = FZFont(13.0);
        /*字体变色，提示用户非选择状态*/
        [self.passLogin setTitleColor:Color_999999 forState:UIControlStateNormal];
        /*选择按钮后，输入框的提示文字也要随之改变，体现出动感*/
        self.userTF.placeholder = @"请输入手机号";
        /*判断是否处于获取验证码状态，是的话，关闭按钮的交互*/
        if (mySelf.number != 60) {
            self.seePassWord.enabled = NO;
        }else{
            /*设置只显示文字*/
            [self.seePassWord setTitle:@"获取验证码" forState:UIControlStateNormal];
        }
        self.passWordTF.placeholder = @"请输入验证码";
        [self.seePassWord setImage:nil forState:UIControlStateNormal];
    }];
    
}

- (IBAction)seePassWordClick:(UIButton *)sender {
    /*首先判断按钮被点击时，是处于密码登录状态，还是短信登录状态*/
    if ([sender.currentImage isEqual:Image(@"输入密码不可见")] || [sender.currentImage isEqual:Image(@"输入密码可见-点击")]) {
        /*如果是密码登录状态，点击打开密文输入或者关闭密文输入*/
        if (self.passWordTF.secureTextEntry == YES) {
            [sender setImage:Image(@"输入密码可见-点击") forState:UIControlStateNormal];
            self.passWordTF.secureTextEntry = NO;
        }else{
            [sender setImage:Image(@"输入密码不可见") forState:UIControlStateNormal];
            self.passWordTF.secureTextEntry = YES;
        }
    }else{
        /*如果是短信登录，点击后开始获取验证码，并且关闭按钮的交互*/
        if ([sender.currentTitle isEqualToString:@"获取验证码"]) {
            [self sendSMSToServer];
        }else{
            sender.enabled = NO;
        }
    }
}

- (IBAction)registClick:(UIButton *)sender {
    FirstSMSLoginVC *vc = [[FirstSMSLoginVC alloc] initWithNibName:@"FirstSMSLoginVC" bundle:nil];
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)forgetClick:(UIButton *)sender {
    ForgetVC *forget = [[ForgetVC alloc]initWithNibName:@"ForgetVC" bundle:nil];
    [self presentViewController:forget animated:YES completion:nil];
}

- (IBAction)quickClick:(UIButton *)sender {
    
    
    
}
- (IBAction)loginClick:(UIButton *)sender {
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"YourLocationLatitude"]) {
        [self cllLocation];
        return ;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *latitude = [[NSUserDefaults standardUserDefaults] objectForKey:@"YourLocationLatitude"];
    NSString *longitude = [[NSUserDefaults standardUserDefaults] objectForKey:@"YourLocationLongitude"];
    __weak typeof(self) mySelf = self;
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:_userTF.text forKey:@"telphone"];
    [parameters setObject:longitude forKey:@"longitude"];
    [parameters setObject:latitude forKey:@"latitude"];
    if (_isSMSLogin == YES) {
        [parameters setObject:_passWordTF.text forKey:@"msgAuthCode"];
    }else{
        [parameters setObject:_passWordTF.text forKey:@"password"];
    }
    [KGRequestNetWorking postWothUrl:loginServer parameters:parameters succ:^(id result) {
        mySelf.errorLab.hidden = YES;
        [MBProgressHUD hideAllHUDsForView:mySelf.view animated:YES];
        if ([result[@"message"] isEqualToString:@"操作成功！"]) {
            NSArray *dataArr = result[@"data"];
            NSDictionary *userDic = dataArr[0];
            [[NSUserDefaults standardUserDefaults] setObject:userDic[@"age"] forKey:@"userAge"];//:--number类型--
            [[NSUserDefaults standardUserDefaults] setObject:userDic[@"sex"] forKey:@"userSex"];//:--number类型--
            [[NSUserDefaults standardUserDefaults] setObject:userDic[@"state"] forKey:@"userState"];//:--number类型--
            [[NSUserDefaults standardUserDefaults] setObject:userDic[@"token"] forKey:@"userToken"];
            [[NSUserDefaults standardUserDefaults] setObject:userDic[@"tokenCode"] forKey:@"userTokenCode"];
            [[NSUserDefaults standardUserDefaults] setObject:userDic[@"username"] forKey:@"userName"];
            [[NSUserDefaults standardUserDefaults] setObject:userDic[@"portraitUri"] forKey:@"portraitUri"];
            id personSignature = userDic[@"personSignature"];
            if (![personSignature isKindOfClass:[NSNull class]]) {
                [[NSUserDefaults standardUserDefaults] setObject:userDic[@"personSignature"] forKey:@"personSignature"];
            }
            [[NSUserDefaults standardUserDefaults] setObject:userDic[@"telphone"] forKey:@"userPhone"];
            [[NSUserDefaults standardUserDefaults] setObject:userDic[@"id"] forKey:@"userID"];
            [[NSUserDefaults standardUserDefaults] setObject:userDic[@"isOnLine"] forKey:@"isOnLine"];
            [[NSUserDefaults standardUserDefaults] setObject:userDic[@"companyUrl"] forKey:@"companyUrl"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            window.rootViewController = [[TabBarVC alloc]init];
            //:--注册融云--
            AppDelegate *app = [[UIApplication sharedApplication] delegate];
            [app registRongIM];
        }else{
            [MBProgressHUD bwm_showTitle:result[@"message"] toView:mySelf.view hideAfter:1];
        }
    } fail:^(NSError *error) {
        mySelf.errorLab.hidden = NO;
        mySelf.errorLab.text = @"登录超时";
        [MBProgressHUD hideHUDForView:mySelf.view animated:YES];
    }];
}

//MARK:创建定时器，开始发送验证码计时
- (void)sendSMSToServer{
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(requestSMS) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    
    [KGRequestNetWorking postWothUrl:sendMsgAuthCode parameters:@{@"telphone":_userTF.text,@"templateId":@"2"} succ:^(id result) {
        
    } fail:^(NSError *error) {
        
    }];
    
}
- (void)requestSMS{
    [self.seePassWord setTitle:[NSString stringWithFormat:@"重新获取(%lds)",(long)_number] forState:UIControlStateNormal];
    if (_number == 0) {
        [_timer invalidate];
        _timer = nil;
        _number = 60;
        self.seePassWord.enabled = YES;
        [self.seePassWord setTitle:@"获取验证码" forState:UIControlStateNormal];
    }else{
        _number --;
    }
}
//MARK:--UITextFieldDelegate--
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == self.userTF) {
        if ([self valueFrameTextField:self.userTF] == 11) {
            _phoneShure = YES;
            _topLine.backgroundColor = Color_333333;
            _userImage.tintColor = Color_333333;
            _userImage.image = [_userImage.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        }else{
            self.errorLab.hidden = NO;
            self.errorLab.text = @"手机号格式错误";
            _phoneShure = NO;
            _topLine.backgroundColor = Color_999999;
            _userImage.image = [_userImage.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
    }else{
        if ([self.seePassWord.currentImage isEqual:Image(@"输入密码不可见")]) {
            if ([self valueFrameTextField:self.passWordTF] >= 6 && [self valueFrameTextField:self.passWordTF] <= 16) {
                _passShure = YES;
                _buttomLine.backgroundColor = Color_333333;
                _passWordImage.tintColor = Color_333333;
                _passWordImage.image =[_passWordImage.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            }else{
                self.errorLab.hidden = NO;
                self.errorLab.text = @"密码格式错误";
                _passShure = NO;
                _buttomLine.backgroundColor = Color_999999;
                _passWordImage.image = [_passWordImage.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            }
        }else{
            if ([self valueFrameTextField:self.passWordTF] == 6) {
                _passShure = YES;
                _buttomLine.backgroundColor = Color_333333;
                _passWordImage.tintColor = Color_333333;
                _passWordImage.image =[_passWordImage.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            }else{
                self.errorLab.hidden = NO;
                self.errorLab.text = @"验证码格式错误";
                _passShure = NO;
                _buttomLine.backgroundColor = Color_999999;
                _passWordImage.image = [_passWordImage.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            }
        }
    }
    if (_phoneShure == YES && _passShure == YES) {
        self.msgLab.hidden = YES;
        self.loginBtu.enabled = YES;
        self.loginBtu.backgroundColor = Color_333333;
    }
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    self.loginBtu.enabled = NO;
    self.loginBtu.backgroundColor = Color_999999;
}
//MARK:--防止输完验证码后登陆成功，但是定时器还没有被释放--
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_timer invalidate];
    _timer = nil;
    _number = 60;
    self.seePassWord.enabled = YES;
    [self.seePassWord setTitle:@"获取验证码" forState:UIControlStateNormal];
}
- (NSInteger)valueFrameTextField:(UITextField *)textF{
    return textF.text.length;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.userTF resignFirstResponder];
    [self.passWordTF resignFirstResponder];
}

- (GuidePageView *)guideView{
    if (!_guideView) {
        _guideView = [[GuidePageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        [self.view insertSubview:_guideView atIndex:99];
    }
    return _guideView;
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
