//
//  MineJoinAddBaseInfoVC.m
//  ArtStar
//
//  Created by abc on 2018/6/15.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineJoinAddBaseInfoVC.h"
#import "MineTheIdentityJoinTableViewCell.h"
#import "MineAddBaseInfoTableViewCell.h"
#import "MineAddBaseNameAndPhoneTableViewCell.h"
#import "MineAddBaseInfoChooseIDTableViewCell.h"
#import "MineChooseCardTypeView.h"
#import "MineWriteTheIdentityInfoVC.h"

@interface MineJoinAddBaseInfoVC ()<UITableViewDelegate,UITableViewDataSource,MineAddBaseInfoChooseIDTableViewCellDelegate,MineAddBaseNameAndPhoneTableViewCellDelegate>

@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,strong) MineChooseCardTypeView *chooseCardView;
@property (nonatomic,strong) NSMutableDictionary *infoDic;

@end

@implementation MineJoinAddBaseInfoVC


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBtuWithFrame:CGRectMake(0, 0, 150, 30) title:@"补充基本信息" image:Image(@"back")];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _infoDic = [NSMutableDictionary dictionary];
    [_infoDic setObject:@"二代身份证" forKey:@"papersType"];
    [_infoDic setObject:[KGUserInfo shareInterace].userName forKey:@"userNickname"];
    [self setTableView];
}

- (void)setTableView{
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0,NavTopHeight, kScreenWidth, kScreenHeight - NavTopHeight)];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.tableFooterView = TabLeViewFootView;
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _listView.scrollEnabled = NO;
    _listView.backgroundColor = Color_fafafa;
    [self.view addSubview:_listView];
    
    [_listView registerNib:[UINib nibWithNibName:@"MineTheIdentityJoinTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineTheIdentityJoinTableViewCell"];
    [_listView registerNib:[UINib nibWithNibName:@"MineAddBaseInfoTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineAddBaseInfoTableViewCell"];
    [_listView registerNib:[UINib nibWithNibName:@"MineAddBaseNameAndPhoneTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineAddBaseNameAndPhoneTableViewCell"];
    [_listView registerNib:[UINib nibWithNibName:@"MineAddBaseInfoChooseIDTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineAddBaseInfoChooseIDTableViewCell"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0){
        return 60;
    }else if (indexPath.row == 1){
        return 110;
    }else if (indexPath.row == 2){
        return 110;
    }else{
        return 70;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0){
        MineAddBaseInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineAddBaseInfoTableViewCell"];
        cell.detailLab.text = [KGUserInfo shareInterace].userName;
        return cell;
    }else if (indexPath.row == 1){
        MineAddBaseNameAndPhoneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineAddBaseNameAndPhoneTableViewCell"];
        cell.delegate = self;
        return cell;
    }else if (indexPath.row == 2){
        MineAddBaseInfoChooseIDTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineAddBaseInfoChooseIDTableViewCell"];
        cell.carfLab.text = _infoDic[@"papersType"];
        cell.delegate = self;
        return cell;
    }else{
        MineTheIdentityJoinTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineTheIdentityJoinTableViewCell"];
        cell.textLab.text = @"下一步(1/2)";
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 3) {
        if (_infoDic[@"userName"]) {
            if (_infoDic[@"tel"]) {
                if (_infoDic[@"papersType"]) {
                    if (_infoDic[@"identityCardId"]) {
                        MineWriteTheIdentityInfoVC *identity = [[MineWriteTheIdentityInfoVC alloc]init];
                        identity.msgDic = _infoDic.copy;
                        [self pushNoTabBarViewController:identity animated:YES];
                    }else{
                        [MBProgressHUD bwm_showTitle:@"请填证件号码" toView:self.view hideAfter:1];
                    }
                }else{
                    [MBProgressHUD bwm_showTitle:@"请选择证件类型" toView:self.view hideAfter:1];
                }
            }else{
                [MBProgressHUD bwm_showTitle:@"请填写手机号" toView:self.view hideAfter:1];
            }
        }else{
            [MBProgressHUD bwm_showTitle:@"请填写真实姓名" toView:self.view hideAfter:1];
        }
    }
}
// MARK: --MineAddBaseNameAndPhoneTableViewCellDelegate--
- (void)sendYourNameTelephone:(NSString *)name phone:(NSString *)phone{
    if (name != nil) {
        [_infoDic setObject:name forKey:@"userName"];
    }else{
        [_infoDic setObject:phone forKey:@"tel"];
    }
}
- (MineChooseCardTypeView *)chooseCardView{
    if (!_chooseCardView) {
        _chooseCardView = [[MineChooseCardTypeView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        __weak typeof(self) weakSelf = self;
        _chooseCardView.sendIDcardType = ^(NSString *type) {
            [weakSelf.infoDic setObject:type forKey:@"papersType"];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
            [weakSelf.listView reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationAutomatic];
        };
        [self.navigationController.view addSubview:_chooseCardView];
    }
    return _chooseCardView;
}
//MARK:--MineAddBaseInfoChooseIDTableViewCellDelegate--
- (void)showChooseCardView{
    self.chooseCardView.hidden = NO;
}
- (void)sendIDCardNumber:(NSString *)idCard{
    [_infoDic setObject:idCard forKey:@"identityCardId"];
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
