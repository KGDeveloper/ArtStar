//
//  MsgTapCellHeaderPushFocusVC.m
//  ArtStar
//
//  Created by abc on 6/8/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "MsgTapCellHeaderPushFocusVC.h"
#import "FocusView.h"
#import "CancelFocusView.h"

@interface MsgTapCellHeaderPushFocusVC ()

@property (nonatomic,strong) FocusView *focus;
@property (nonatomic,strong) CancelFocusView *cancelFocus;

@end

@implementation MsgTapCellHeaderPushFocusVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLeftBtuWithFrame:CGRectMake(0, 0, 150, 30) title:_userName image:Image(@"back")];
    self.view.backgroundColor = Color_fafafa;
    [self createData];
}
// MARK: --请求数据查看是否已经关注对方--
- (void)createData{
    __weak typeof(self) weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [KGRequestNetWorking postWothUrl:seachIsattOrFCPermissions parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"id":_userId} succ:^(id result) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        if ([result[@"code"] integerValue] == 200) {
            NSArray *tmpArr = result[@"data"];
            NSDictionary *dic = [tmpArr firstObject];
            if ([dic[@"isattentioned"] integerValue] == 0) {
                weakSelf.cancelFocus.hidden = NO;
            }else{
                weakSelf.focus.userInfo = dic[@"friendCirclePermissions"];
            }
        }
    } fail:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
    }];
}
// MARK: --已近关注页面--
- (FocusView *)focus{
    if (!_focus) {
        _focus = [[FocusView alloc]initWithFrame:CGRectMake(0,NavTopHeight, kScreenWidth, kScreenHeight - NavTopHeight)];
        _focus.userId = _userId;
        __weak typeof(self) mySelf = self;
        _focus.cancelFocus = ^{
            [mySelf requestCancelFocus];
        };
        [self.view addSubview:_focus];
    }
    return _focus;
}
// MARK: --取消关注后页面--
- (CancelFocusView *)cancelFocus{
    if (!_cancelFocus) {
        _cancelFocus = [[CancelFocusView alloc]initWithFrame:CGRectMake(0,NavTopHeight, kScreenWidth, kScreenHeight - NavTopHeight)];
        __weak typeof(self) mySelf = self;
        _cancelFocus.focusOn = ^{
            [mySelf requestFocus];
        };
        [self.view addSubview:_cancelFocus];
    }
    return _cancelFocus;
}
// MARK: --请求关注好友--
- (void)requestFocus{
    __weak typeof(self) weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [KGRequestNetWorking postWothUrl:attorcel parameters:@{@"toId":_userId,@"tokenCode":[KGUserInfo shareInterace].userTokenCode} succ:^(id result) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        if ([result[@"code"] integerValue] == 200) {
            [weakSelf.view bringSubviewToFront:weakSelf.focus];
        }else{
            [MBProgressHUD bwm_showTitle:@"关注失败" toView:weakSelf.view hideAfter:1];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        [MBProgressHUD bwm_showTitle:@"请求失败" toView:weakSelf.view hideAfter:1];
    }];
}
// MARK: --请求取消关注--
- (void)requestCancelFocus{
    __weak typeof(self) weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [KGRequestNetWorking postWothUrl:attorcel parameters:@{@"toId":_userId,@"tokenCode":[KGUserInfo shareInterace].userTokenCode} succ:^(id result) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        if ([result[@"code"] integerValue] == 200) {
            [weakSelf.view bringSubviewToFront:weakSelf.cancelFocus];
        }else{
            [MBProgressHUD bwm_showTitle:@"取消关注失败" toView:weakSelf.view hideAfter:1];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        [MBProgressHUD bwm_showTitle:@"请求失败" toView:weakSelf.view hideAfter:1];
    }];
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
