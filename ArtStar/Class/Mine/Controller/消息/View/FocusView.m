//
//  FocusView.m
//  ArtStar
//
//  Created by abc on 6/8/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "FocusView.h"
#import "FocusViewNickNameCell.h"
#import "FocusViewTopCell.h"
#import "FocusViewChatInfoCell.h"
#import "FocusViewChatPermissionsCell.h"
#import "FocusViewChatFocusCell.h"
#import "MsgTapNoteVC.h"

@interface FocusView ()<UITableViewDelegate,UITableViewDataSource,FocusViewChatPermissionsCellDelegate>

@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,strong) ReportView *reportView;

@end

@implementation FocusViewModel
@end

@implementation FocusView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _model = [FocusViewModel new];
        [self setView];
    }
    return self;
}

- (void)setView{
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth(self), ViewHeight(self))];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.tableFooterView = TabLeViewFootView;
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _listView.backgroundColor = Color_fafafa;
    _listView.scrollEnabled = NO;
    [self addSubview:_listView];
    
    [_listView registerNib:[UINib nibWithNibName:@"FocusViewNickNameCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FocusViewNickNameCell"];
    [_listView registerNib:[UINib nibWithNibName:@"FocusViewTopCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FocusViewTopCell"];
    [_listView registerNib:[UINib nibWithNibName:@"FocusViewChatInfoCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FocusViewChatInfoCell"];
    [_listView registerNib:[UINib nibWithNibName:@"FocusViewChatPermissionsCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FocusViewChatPermissionsCell"];
    [_listView registerNib:[UINib nibWithNibName:@"FocusViewChatFocusCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FocusViewChatFocusCell"];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 4) {
        return 60;
    }else{
        return 50;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else if (section == 1){
        return 2;
    }else if (section == 2){
        return 3;
    }else{
        return 1;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerForSection = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 5)];
    headerForSection.backgroundColor = Color_fafafa;
    return headerForSection;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            FocusViewNickNameCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FocusViewNickNameCell"];
            cell.detailLab.text = _model.nikName;
            return cell;
        }else{
            FocusViewTopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FocusViewTopCell"];
            return cell;
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            FocusViewChatInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FocusViewChatInfoCell"];
            cell.titleLab.text = @"查找聊天记录";
            return cell;
        }else{
            FocusViewChatInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FocusViewChatInfoCell"];
            cell.titleLab.text = @"清空聊天记录";
            return cell;
        }
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            FocusViewChatPermissionsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FocusViewChatPermissionsCell"];
            cell.titleLab.text = @"不让他看我的朋友圈";
            cell.detailLab.text = @"打开后,你在朋友圈发布的图文信息对方将无法看到";
            if (_userInfo) {
                if ([_userInfo[@"is_allow_look_other"] integerValue] == 0) {
                    cell.statusSwitch.on = YES;
                }else{
                    cell.statusSwitch.on = NO;
                }
            }
            cell.delegate = self;
            return cell;
        }else if (indexPath.row == 1){
            FocusViewChatPermissionsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FocusViewChatPermissionsCell"];
            cell.titleLab.text = @"不看他的朋友圈";
            cell.detailLab.text = @"打开后,对方在朋友圈发布的图文信息你将无法看到";
            if (_userInfo) {
                if ([_userInfo[@"is_look_other"] integerValue] == 0) {
                    cell.statusSwitch.on = YES;
                }else{
                    cell.statusSwitch.on = NO;
                }
            }
            cell.delegate = self;
            return cell;
        }else{
            FocusViewChatInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FocusViewChatInfoCell"];
            cell.titleLab.text = @"发送该名片";
            return cell;
        }
    }else if (indexPath.section == 3){
        FocusViewChatInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FocusViewChatInfoCell"];
        cell.titleLab.text = @"举报";
        return cell;
    }else{
        FocusViewChatFocusCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FocusViewChatFocusCell"];
        cell.titleLab.text = @"取消关注";
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            MsgTapNoteVC *noteNameVc = [[MsgTapNoteVC alloc]init];
            __weak typeof(self) mySelf = self;
            noteNameVc.sendNoteName = ^(NSString *noteName) {
                mySelf.model.nikName = noteName;
                [mySelf.listView reloadData];
            };
            [[self rootViewCintroller].navigationController pushViewController:noteNameVc animated:YES];
        }
    }else if (indexPath.section == 1){
        
    }else if (indexPath.section == 2){
        
    }else if (indexPath.section == 3){
        self.reportView.hidden = NO;
    }else{
        if (self.cancelFocus) {
            self.cancelFocus();
        }
    }
}
- (void)setUserInfo:(NSDictionary *)userInfo{
    _userInfo = userInfo;
    [_listView reloadData];
}
// MARK: --举报页面--
- (ReportView *)reportView{
    if (!_reportView) {
        _reportView = [[ReportView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        [[self rootViewCintroller].navigationController.view addSubview:_reportView];
    }
    return _reportView;
}
// MARK: --获取父视图--
- (UIViewController *)rootViewCintroller{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}
// MARK: --FocusViewChatPermissionsCellDelegate--
- (void)changeStatusWithName:(NSString *)name status:(NSString *)status{
    if ([name isEqualToString:@"不让他看我的朋友圈"]) {
        [self changeFriendIsSee:_userInfo[@"is_look_other"] allowSee:status];
    }else{
        [self changeFriendIsSee:status allowSee:_userInfo[@"is_allow_look_other"]];
    }
}
- (void)changeFriendIsSee:(NSString *)see allowSee:(NSString *)allowSee{
    [MBProgressHUD showHUDAddedTo:self animated:YES];
    __weak typeof(self) weakSelf = self;
    [KGRequestNetWorking postWothUrl:setFriendCirclePermissions parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"id":_userId,@"is_look_other":see,@"is_allow_look_other":allowSee} succ:^(id result) {
        [MBProgressHUD hideAllHUDsForView:weakSelf animated:YES];
        if ([result[@"code"] integerValue] == 200) {
            [MBProgressHUD bwm_showTitle:@"设置成功" toView:weakSelf hideAfter:1];
        }else{
            [MBProgressHUD bwm_showTitle:@"设置失败" toView:weakSelf hideAfter:1];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:weakSelf animated:YES];
        [MBProgressHUD bwm_showTitle:@"请求失败" toView:weakSelf hideAfter:1];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
