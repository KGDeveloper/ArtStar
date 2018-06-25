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
    
}
- (IBAction)returnClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)nextClick:(UIButton *)sender {
    RegisterVC *regist = [[RegisterVC alloc]initWithNibName:@"RegisterVC" bundle:nil];
    regist.isFirst = YES;
    [self presentViewController:regist animated:YES completion:nil];
}
- (IBAction)loginClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)forgetClick:(UIButton *)sender {
    ForgetVC *regist = [[ForgetVC alloc]initWithNibName:@"ForgetVC" bundle:nil];
    [self presentViewController:regist animated:YES completion:nil];
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
