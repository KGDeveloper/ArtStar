//
//  MineMyselfWordAddLabelVC.m
//  ArtStar
//
//  Created by abc on 2018/6/13.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineMyselfWordAddLabelVC.h"

@interface MineMyselfWordAddLabelVC ()

@property (nonatomic,strong) YYTextView *textTF;

@end

@implementation MineMyselfWordAddLabelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLeftBtuWithFrame:CGRectMake(0, 0, 150, 30) title:_titleStr image:Image(@"back")];
    [self setRightBtuWithFrame:CGRectMake(0, 0, 50, 30) title:@"保存" image:nil];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    self.view.backgroundColor = Color_fafafa;
    
    [self setTextView];

}
- (void)rightNavBtuAction:(UIButton *)sender{
    if (self.sendLabelToViewController) {
        self.sendLabelToViewController(_textTF.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)setTextView{
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, NavTopHeight + 10, kScreenWidth, 100)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    _textTF = [[YYTextView alloc]initWithFrame:CGRectMake(15, 10, kScreenWidth - 30, 80)];
    _textTF.placeholderText = [NSString stringWithFormat:@"请输入你的%@",_titleStr];
    _textTF.placeholderTextColor = Color_cccccc;
    _textTF.placeholderFont = SYFont(12);
    _textTF.textColor = Color_333333;
    _textTF.font = SYFont(12);
    [backView addSubview:_textTF];
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
