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

#import "PassWordVC.h"
#import "TabBarVC.h"
#import "AppDelegate.h"

@interface PassWordVC ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iamgeTop;
@property (weak, nonatomic) IBOutlet UILabel *nikName;
@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet UIButton *loadPass;
@property (weak, nonatomic) IBOutlet UITextField *passWordTF;
@property (weak, nonatomic) IBOutlet UIButton *registerBtu;
@property (weak, nonatomic) IBOutlet UIButton *returnBtu;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btuTop;
@property (weak, nonatomic) IBOutlet UILabel *errorLab;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *returnTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageTop;


@end

@implementation PassWordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.returnBtu.enabled = NO;
    self.passWordTF.delegate = self;
    self.returnTop.constant = NavTopHeight - 35;
    self.imageTop.constant = NavTopHeight + 25;
}
- (IBAction)returnClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)registCLick:(UIButton *)sender {
    if ([self valueFrameTextField:_passWordTF] >= 6 && [self valueFrameTextField:_passWordTF] <= 16) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        window.rootViewController = [[TabBarVC alloc]init];
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([self valueFrameTextField:_passWordTF] >= 6 && [self valueFrameTextField:_passWordTF] <= 16) {
        self.registerBtu.backgroundColor = Color_333333;
        self.registerBtu.enabled = YES;
        self.errorLab.hidden = YES;
    }else{
        self.errorLab.hidden = NO;
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
