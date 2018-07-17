/**
 
 ArtStar
 
 Created by: KG丿轩帝 on 2018/4/20
 
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

#import "RegisterVC.h"
#import "DatePickerView.h"
#import "PassWordVC.h"
#import "AppDelegate.h"
#import "TabBarVC.h"
#import "LoginVC.h"

@interface RegisterVC ()
<DatePickerViewDelegate,
UITextFieldDelegate,
KGCameraDelegate>
/**
 返回按钮居上的距离
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *returnBtuTop;
/**
 头像居上的距离
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerImageTop;
/**
 头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
/**
 昵称下方直线
 */
@property (weak, nonatomic) IBOutlet UIView *topLine;
/**
 生日下方直线
 */
@property (weak, nonatomic) IBOutlet UIView *centerLine;
/**
 性别下方直线
 */
@property (weak, nonatomic) IBOutlet UIView *buttomLine;
/**
 昵称输入框
 */
@property (weak, nonatomic) IBOutlet UITextField *nikNameTF;
/**
 选择生日按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *birthdayBtu;
/**
 性别男
 */
@property (weak, nonatomic) IBOutlet UIButton *manBtu;
/**
 性别女
 */
@property (weak, nonatomic) IBOutlet UIButton *womanBtu;
/**
 性别保密
 */
@property (weak, nonatomic) IBOutlet UIButton *unKnowSexBtu;
/**
 下一步按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *nextBtu;
/**
 出生日期选择器
 */
@property (nonatomic,strong) DatePickerView *dataPickView;
/**
 选择性别
 */
@property (nonatomic,copy) NSString *sexStr;
/**
 选择框
 */
@property (nonatomic,strong) KGCamera *cameraView;
@property (nonatomic,copy) NSString *birthday;
@property (weak, nonatomic) IBOutlet UILabel *errorLab;

@end

@implementation RegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sexStr = @"未选择";
    self.nikNameTF.delegate = self;
    
    self.returnBtuTop.constant = NavTopHeight - 35;
    self.headerImageTop.constant = NavTopHeight + 25;
}
//MARK:--返回按钮点击事件--
- (IBAction)returnClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
//MARK:--选择生日按钮--
- (IBAction)birtdayClick:(UIButton *)sender {
    [self.nikNameTF resignFirstResponder];
    self.dataPickView.hidden = NO;
    [self changeNextButtonColor];
}
//MARK:--选择男--
- (IBAction)manSexClick:(UIButton *)sender {
    self.sexStr = @"1";
    [self.womanBtu setImage:Image(@"性别未选中") forState:UIControlStateNormal];
    [self.unKnowSexBtu setImage:Image(@"性别未选中") forState:UIControlStateNormal];
    [sender setImage:Image(@"性别选中") forState:UIControlStateNormal];
    [self changeNextButtonColor];
}
//MARK:--选择女--
- (IBAction)womanClick:(UIButton *)sender {
    self.sexStr = @"0";
    [sender setImage:Image(@"性别选中") forState:UIControlStateNormal];
    [self.manBtu setImage:Image(@"性别未选中") forState:UIControlStateNormal];
    [self.unKnowSexBtu setImage:Image(@"性别未选中") forState:UIControlStateNormal];
    [self changeNextButtonColor];
}
//MARK:--选择保密--
- (IBAction)unKnowClick:(UIButton *)sender {
    self.sexStr = @"-1";
    [self.womanBtu setImage:Image(@"性别未选中") forState:UIControlStateNormal];
    [self.manBtu setImage:Image(@"性别未选中") forState:UIControlStateNormal];
    [sender setImage:Image(@"性别选中") forState:UIControlStateNormal];
    [self changeNextButtonColor];
}
//MARK:--下一步点击事件--
- (IBAction)nextClick:(UIButton *)sender {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    if ([self toDetermineWhetherToComplete] == YES) {
        __weak typeof(self) mySelf = self;
        [KGRequestNetWorking postWothUrl:registServer parameters:@{@"telphone":_userPhoneStr,@"username":_nikNameTF.text,@"birthday":_birthday,@"password":_userPassStr,@"imageURL":@"http://p1.qzone.la/upload/20150222/yk961fx2.jpg",@"sex":_sexStr} succ:^(id result) {
            if ([result[@"message"] isEqualToString:@"用户已存在"]) {
                mySelf.errorLab.hidden = NO;
            }else if ([result[@"message"] isEqualToString:@"操作成功！"]){
                mySelf.errorLab.hidden = NO;
                mySelf.errorLab.text = @"注册成功，2s后自动前往登录页面";
                sleep(2);
                LoginVC *loginVC = [[LoginVC alloc]init];
                [mySelf presentViewController:loginVC animated:YES completion:nil];
            }
            [MBProgressHUD hideHUDForView:mySelf.view animated:YES];
        } fail:^(NSError *error) {
            [MBProgressHUD hideHUDForView:mySelf.view animated:YES];
        }];
    }
}
//MARK:--点击头像事件--
- (IBAction)headerClickj:(UIButton *)sender {
    self.cameraView.hidden = NO;
}
//MARK:--根据日期判断星座--
-(NSString *)getAstroWithMonth:(int)m day:(int)d{
    NSString *astroString = @"魔羯水瓶双鱼白羊金牛双子巨蟹狮子处女天秤天蝎射手魔羯";
    NSString *astroFormat = @"102123444543";
    NSString *result;
    if (m<1||m>12||d<1||d>31){return @"错误日期格式!";}
    if(m==2 && d>29){return @"错误日期格式!";}
    else if(m==4 || m==6 || m==9 || m==11) {
        if (d>30) {return @"错误日期格式!!!";}
    }
    result=[NSString stringWithFormat:@"%@",[astroString substringWithRange:NSMakeRange(m*2-(d < [[astroFormat substringWithRange:NSMakeRange((m-1), 1)] intValue] - (-19))*2,2)]];
    return result;
}
//MARK:--日期选择器--
- (DatePickerView *)dataPickView{
    if (!_dataPickView) {
        _dataPickView = [[DatePickerView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 250 - NavButtomHeight, kScreenWidth, 250)];
        _dataPickView.hidden = YES;
        _dataPickView.delegate = self;
        [self.view addSubview:_dataPickView];
    }
    return _dataPickView;
}
//MARK:--日期选择器代理方法--
- (void)getSelectDate:(NSString *)date type:(DateType)type{
    NSInteger month = [[date componentsSeparatedByString:@"/"][1] integerValue];
    NSInteger day = [[date componentsSeparatedByString:@"/"][2] integerValue];
    _birthday = [date stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    [self.birthdayBtu setTitle:[NSString stringWithFormat:@"%@ (%@座)",_birthday,[self getAstroWithMonth:(int)month day:(int)day]] forState:UIControlStateNormal];
    [self.birthdayBtu setTitleColor:Color_333333 forState:UIControlStateNormal];
}
//MARK:--修改下一步按钮的状态--
- (void)changeNextButtonColor{
    if ([self toDetermineWhetherToComplete] == YES) {
        self.nextBtu.backgroundColor = Color_333333;
    }else{
        self.nextBtu.backgroundColor = Color_999999;
    }
}
//MARK:--判断信息是否填写完全--
- (BOOL)toDetermineWhetherToComplete{
    if (self.nikNameTF.text.length > 0 && ![self.birthdayBtu.currentTitle isEqualToString:@"请选择出生日期"] && ![self.sexStr isEqualToString:@"未选择"]) {
        return YES;
    }else{
        return NO;
    }
}
//MARK:--检测改变按钮状态--
- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self changeNextButtonColor];
}
//MARK:--选择框--
- (KGCamera *)cameraView{
    if (!_cameraView) {
        _cameraView = [[KGCamera alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _cameraView.hidden = YES;
        _cameraView.delegate = self;
        [self.view addSubview:_cameraView];
    }
    return _cameraView;
}
//MARK:--KGCameraDelegate--
//MARK:--点击拍照上传--
- (void)touchCamera{
    self.cameraView.hidden = YES;
}
//MARK:--点击本地上传--
- (void)touchPhoto{
    self.cameraView.hidden = YES;
}
//MARK:--打开相机--

//MARK:--打开相册，选择照片--

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
