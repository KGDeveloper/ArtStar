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

@interface RegisterVC ()
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

@end

@implementation RegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
//MARK:--返回按钮点击事件--
- (IBAction)returnClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
//MARK:--选择生日按钮--
- (IBAction)birtdayClick:(UIButton *)sender {
    
}
//MARK:--选择男--
- (IBAction)manSexClick:(UIButton *)sender {
    
}
//MARK:--选择女--
- (IBAction)womanClick:(UIButton *)sender {
    
}
//MARK:--选择保密--
- (IBAction)unKnowClick:(UIButton *)sender {
    
}
//MARK:--下一步点击事件--
- (IBAction)nextClick:(UIButton *)sender {
    
}
//MARK:--点击头像事件--
- (IBAction)headerClick:(UITapGestureRecognizer *)sender {
    
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
