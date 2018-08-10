//
//  MsgTapNoteVC.m
//  ArtStar
//
//  Created by abc on 6/8/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "MsgTapNoteVC.h"

@interface MsgTapNoteVC ()

@property (nonatomic,strong) UITextField *textField;

@end

@implementation MsgTapNoteVC

- (void)rightNavBtuAction:(UIButton *)sender{
    if (_userID != nil) {
        NSString *url = nil;
        if ([_type isEqualToString:@"好友"]) {
            url = friendRemarks;
        }else if ([_type isEqualToString:@"粉丝"]){
            url = FansRemarks;
        }else if ([_type isEqualToString:@"关注"]){
            url = AttentionRemarks;
        }
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        __weak typeof(self) weakSelf = self;
        [KGRequestNetWorking postWothUrl:url parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"zid":_userID,@"remark":_textField.text} succ:^(id result) {
            [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
            if ([result[@"code"] integerValue] == 200) {
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [MBProgressHUD bwm_showTitle:@"修改失败" toView:weakSelf.view hideAfter:1];
            }
        } fail:^(NSError *error) {
            [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
            [MBProgressHUD bwm_showTitle:@"修改失败" toView:weakSelf.view hideAfter:1];
        }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBtuWithFrame:CGRectMake(0, 0, 150, 30) title:@"备注信息" image:Image(@"back")];
    [self setRightBtuWithFrame:CGRectMake(0, 0, 50, 30) title:@"完成" image:nil];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setViewUI];
}

- (void)setViewUI{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, NavTopHeight + 20, kScreenWidth - 30, 15)];
    label.text = @"备注名";
    label.textColor = Color_333333;
    label.font = SYFont(13);
    [self.view addSubview:label];
    
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(15, NavTopHeight + 65, kScreenWidth - 30, 15)];
    _textField.placeholder = @"请填写备注";
    _textField.font = SYFont(14);
    _textField.textColor = Color_333333;
    [self.view addSubview:_textField];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(15,NavTopHeight + 90, kScreenWidth - 30, 1)];
    line.backgroundColor = Color_cccccc;
    [self.view addSubview:line];
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
