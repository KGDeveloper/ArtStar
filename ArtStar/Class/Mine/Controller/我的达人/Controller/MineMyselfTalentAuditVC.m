//
//  MineMyselfTalentAuditVC.m
//  ArtStar
//
//  Created by abc on 2018/6/19.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineMyselfTalentAuditVC.h"
#import "MineBookButtonView.h"
#import "MineAuditTableViewCell.h"
#import "MineTalentInfoModel.h"
#import "MineTalentPassModel.h"
#import "MineTalentLowEditView.h"

@interface MineMyselfTalentAuditVC ()<UITableViewDelegate,UITableViewDataSource,MineAuditTableViewCellDelegate>

/**
 加载达人记录
 */
@property (nonatomic,strong) UITableView *listView;
/**
 审核中
 */
@property (nonatomic,strong) MineBookButtonView *auditWaitBtu;
/**
 审核成功
 */
@property (nonatomic,strong) MineBookButtonView *auditSucBtu;
/**
 审核失败
 */
@property (nonatomic,strong) MineBookButtonView *auditFailBtu;
@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) UIView *topView;
/**
 判断点击审核中，审核通过还是审核失败
 */
@property (nonatomic,copy) NSString *status;
/**
 审核中
 */
@property (nonatomic,strong) NSMutableArray *waitingArr;
/**
 审核通过
 */
@property (nonatomic,strong) NSMutableArray *succArr;
/**
 审核失败
 */
@property (nonatomic,strong) NSMutableArray *failArr;
/**
 展示数据
 */
@property (nonatomic,strong) NSMutableArray *dataArr;
/**
 修改数据
 */
@property (nonatomic,strong) NSMutableArray *cellArr;
/**
 选择以及删除弹窗
 */
@property (nonatomic,strong) MineTalentLowEditView *editView;
/**
 判断是否开启编辑模式
 */
@property (nonatomic,assign) BOOL isEdit;

@end

@implementation MineMyselfTalentAuditVC

- (void)rightNavBtuAction:(UIButton *)sender{
    if ([_status isEqualToString:@"审核中"]) {
        if ([sender.currentTitle isEqualToString:@"编辑"]) {
            [sender setTitle:@"取消编辑" forState:UIControlStateNormal];
            _isEdit = YES;
            [_listView reloadData];
            self.editView.hidden = NO;
            self.editView.detailStr = @"取消审核";
        }else{
            [sender setTitle:@"编辑" forState:UIControlStateNormal];
            _isEdit = NO;
            [_listView reloadData];
            self.editView.hidden = YES;
        }
    }else if ([_status isEqualToString:@"审核通过"]){
        if ([sender.currentTitle isEqualToString:@"编辑"]) {
            [sender setTitle:@"取消编辑" forState:UIControlStateNormal];
            _isEdit = YES;
            [_listView reloadData];
            self.editView.hidden = NO;
            self.editView.detailStr = @"删除";
        }else{
            [sender setTitle:@"编辑" forState:UIControlStateNormal];
            _isEdit = NO;
            [_listView reloadData];
            self.editView.hidden = YES;
        }
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBtuWithFrame:CGRectMake(0, 0, 150, 30) title:@"我的达人" image:Image(@"back")];
    [self setRightBtuWithFrame:CGRectMake(0, 0, 50, 30) title:@"编辑" image:nil];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _dataArr = [NSMutableArray array];
    _waitingArr = [NSMutableArray array];
    _succArr = [NSMutableArray array];
    _failArr = [NSMutableArray array];
    _cellArr = [NSMutableArray array];
    _status = @"审核中";
    _isEdit = NO;
    
    [self alentEditingStyle];
    [self alentFailedStyle];
    [self createData];
    [self setTopView];
    [self setTableView];
}
// MARK: --审核通过--
- (void)createData{
    [MBProgressHUD bwm_showHUDAddedTo:self.view title:@"正在加载..."];
    __weak typeof(self) weakSelf = self;
    dispatch_queue_t approvedQueue = dispatch_queue_create("请求审核通过", DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(approvedQueue, ^{
        [KGRequestNetWorking postWothUrl:checkPassIssue parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"uid":[KGUserInfo shareInterace].userID} succ:^(id result) {
            [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
            if ([result[@"code"] integerValue] == 200) {
                weakSelf.succArr = [MineTalentPassModel mj_objectArrayWithKeyValuesArray:result[@"data"]];
                weakSelf.auditSucBtu.count = [NSString stringWithFormat:@"%li",weakSelf.succArr.count];
            }
        } fail:^(NSError *error) {
            [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        }];
    });
}
// MARK: --审核失败--
- (void)alentFailedStyle{
    [MBProgressHUD bwm_showHUDAddedTo:self.view title:@"正在加载..."];
    __weak typeof(self) weakSelf = self;
    dispatch_queue_t failedApprovedQueue = dispatch_queue_create("请求审核未通过", DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(failedApprovedQueue, ^{
        [KGRequestNetWorking postWothUrl:checkNoPassIssue parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"uid":[KGUserInfo shareInterace].userID} succ:^(id result) {
            [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
            if ([result[@"code"] integerValue] == 200) {
                weakSelf.failArr = [MineTalentInfoModel mj_objectArrayWithKeyValuesArray:result[@"data"]];
                weakSelf.auditFailBtu.count = [NSString stringWithFormat:@"%li",weakSelf.failArr.count];
            }
        } fail:^(NSError *error) {
            [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        }];
    });
}
// MARK: --审核中--
- (void)alentEditingStyle{
    [MBProgressHUD bwm_showHUDAddedTo:self.view title:@"正在加载..."];
    __weak typeof(self) weakSelf = self;
    dispatch_queue_t reviewQueue = dispatch_queue_create("请求审核中", DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(reviewQueue, ^{
        [KGRequestNetWorking postWothUrl:checkunderReviewIssue parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"uid":[KGUserInfo shareInterace].userID} succ:^(id result) {
            [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
            if ([result[@"code"] integerValue] == 200) {
                weakSelf.waitingArr = [MineTalentInfoModel mj_objectArrayWithKeyValuesArray:result[@"data"]];
                weakSelf.dataArr = weakSelf.waitingArr.copy;
                weakSelf.auditWaitBtu.count = [NSString stringWithFormat:@"%li",weakSelf.waitingArr.count];
                [weakSelf.listView reloadData];
            }
        } fail:^(NSError *error) {
            [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        }];
    });
}
// MARK: --创建显示列表上方切换查看状态的按钮--
- (void)setTopView{
    
    _topView = [[UIView alloc]initWithFrame:CGRectMake(0, NavTopHeight, kScreenWidth, 60)];
    [self.view addSubview:_topView];
    // !!!: --审核中按钮--
    _auditWaitBtu = [[MineBookButtonView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth/3, 60)];
    _auditWaitBtu.count = @"3";
    _auditWaitBtu.name = @"审核中";
    _auditWaitBtu.btuColor = Color_333333;
    __weak typeof(self) mySelf = self;
    _auditWaitBtu.touchUpInside = ^{
        [mySelf changeTouchBtuColor:mySelf.auditWaitBtu];
    };
    [_topView addSubview:_auditWaitBtu];
    // !!!: --审核通过--
    _auditSucBtu = [[MineBookButtonView alloc]initWithFrame:CGRectMake(kScreenWidth/3, 0,kScreenWidth/3, 60)];
    _auditSucBtu.count = @"3";
    _auditSucBtu.name = @"审核通过";
    _auditSucBtu.btuColor = Color_999999;
    _auditSucBtu.touchUpInside = ^{
        [mySelf changeTouchBtuColor:mySelf.auditSucBtu];
    };
    [_topView addSubview:_auditSucBtu];
    // !!!: --审核失败--
    _auditFailBtu = [[MineBookButtonView alloc]initWithFrame:CGRectMake(kScreenWidth/3*2, 0,kScreenWidth/3, 60)];
    _auditFailBtu.count = @"3";
    _auditFailBtu.name = @"审核失败";
    _auditFailBtu.btuColor = Color_999999;
    _auditFailBtu.touchUpInside = ^{
        [mySelf changeTouchBtuColor:mySelf.auditFailBtu];
    };
    [_topView addSubview:_auditFailBtu];
    
    UIView *lowLine = [[UIView alloc]initWithFrame:CGRectMake(0,59, kScreenWidth, 1)];
    lowLine.backgroundColor = Color_ededed;
    [_topView addSubview:lowLine];
    
    _line = [[UIView alloc]initWithFrame:CGRectMake(0, 58, 50, 2)];
    _line.backgroundColor = Color_333333;
    _line.centerX = _auditWaitBtu.centerX;
    [_topView addSubview:_line];
    
}
// MARK: --审核中，审核通过，审核失败点击事件--
- (void)changeTouchBtuColor:(MineBookButtonView *)sender{
    for (id obj in _topView.subviews) {
        if ([obj isKindOfClass:[MineBookButtonView class]]) {
            MineBookButtonView *norBtu = obj;
            norBtu.btuColor = Color_999999;
        }
    }
    sender.btuColor = Color_333333;
    _status = sender.name;
    [UIView animateWithDuration:0.2 animations:^{
        self.line.centerX = sender.centerX;
    }];
    // !!!: --点击按钮的时候清空选择--
    if ([sender.name isEqualToString:@"审核中"]) {
        _dataArr = _waitingArr.copy;
        if (_isEdit == YES) {
            if (_cellArr.count > 0) {
                [_cellArr removeAllObjects];
            }
        }
    }else if ([sender.name isEqualToString:@"审核通过"]){
        _dataArr = _succArr.copy;
        if (_isEdit == YES) {
            if (_cellArr.count > 0) {
                [_cellArr removeAllObjects];
            }
        }
    }else if ([sender.name isEqualToString:@"审核失败"]){
        _dataArr = _failArr.copy;
    }
    [self setRightBtuWithFrame:CGRectMake(0, 0, 50, 30) title:@"编辑" image:nil];
    _isEdit = NO;
    [_listView reloadData];
    // !!!: --防止开启编辑模式后点击按钮切换--
    self.editView.hidden = YES;
}
// MARK: --创建显示列表--
- (void)setTableView{
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0,NavTopHeight + 60, kScreenWidth, kScreenHeight - NavTopHeight)];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.rowHeight = 150;
    _listView.tableFooterView = TabLeViewFootView;
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _listView.backgroundColor = Color_fafafa;
    [self.view addSubview:_listView];
    
    [_listView registerNib:[UINib nibWithNibName:@"MineAuditTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineAuditTableViewCell"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineAuditTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineAuditTableViewCell"];
    cell.delegate = self;
    // !!!: --根据状态，改变显示的image--
    if ([_status isEqualToString:@"审核中"]) {
        cell.auditImage.image = Image(@"审核中");
    }else if ([_status isEqualToString:@"审核通过"]){
        cell.auditImage.image = Image(@"审核通过");
    }else{
        cell.auditImage.image = Image(@"审核失败");
    }
    // !!!: --加载数据--
    if (_dataArr.count > 0) {
        // !!!: --用来判断在编辑状态下是否被选中--
        __block BOOL isChoose = NO;
        if ([_status isEqualToString:@"审核中"] || [_status isEqualToString:@"审核失败"]) {
            MineTalentInfoModel *model = _dataArr[indexPath.row];
            NSArray *timeArr = [model.issueDate componentsSeparatedByString:@" "];
            NSArray *dateArr = [[timeArr firstObject] componentsSeparatedByString:@"-"];
            cell.dayLab.text = [dateArr lastObject];
            cell.mouthLab.text = dateArr[1];
            cell.locationLab.text = model.location;
            [cell.topImage sd_setImageWithURL:[NSURL URLWithString:[model.images firstObject]]];
            cell.countLab.text = [NSString stringWithFormat:@"1/%li",model.images.count];
            cell.textLab.text = model.headline;
            cell.detaiLab.text = model.siteIntroduce;
            cell.cellID = [model.iId integerValue];
            [_cellArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj isEqual:model.iId]) {
                    isChoose = YES;
                    *stop = YES;
                }
            }];
        }else if ([_status isEqualToString:@"审核通过"]){
            MineTalentPassModel *model = _dataArr[indexPath.row];
            NSArray *timeArr = [model.createTime componentsSeparatedByString:@" "];
            NSArray *dateArr = [[timeArr firstObject] componentsSeparatedByString:@"-"];
            cell.dayLab.text = [dateArr lastObject];
            cell.mouthLab.text = dateArr[1];
            cell.locationLab.text = model.location;
            [cell.topImage sd_setImageWithURL:[NSURL URLWithString:[model.imageUrl firstObject]]];
            cell.countLab.text = [NSString stringWithFormat:@"1/%li",model.imageUrl.count];
            cell.textLab.text = model.title;
            cell.detaiLab.text = model.content;
            cell.cellID = [model.ID integerValue];
            [_cellArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj isEqual:model.ID]) {
                    isChoose = YES;
                    *stop = YES;
                }
            }];
        }
        // !!!: --判断是否处于编辑状态--
        if (_isEdit == NO) {
            cell.viewWidth.constant = 0;
            cell.editBtu.hidden = YES;
        }else{
            cell.viewWidth.constant = 30;
            cell.editBtu.hidden = NO;
            if (isChoose == YES) {
                [cell.editBtu setImage:Image(@"编辑选中状态") forState:UIControlStateNormal];
            }else{
                [cell.editBtu setImage:Image(@"编辑未选中状态") forState:UIControlStateNormal];
            }
        }
    }
    return cell;
}
// MARK: --MineAuditTableViewCellDelegate--
- (void)changeTalentStatusWithID:(NSInteger)ID status:(NSString *)cellStatus{
    if ([cellStatus isEqualToString:@"添加"]) {
        [_cellArr addObject:@(ID)];
    }else{
        [_cellArr removeObject:@(ID)];
    }
}
// MARK: --选择以及删除弹窗--
- (MineTalentLowEditView *)editView{
    if (!_editView) {
        _editView = [[MineTalentLowEditView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 50, kScreenWidth, 50)];
        _editView.title = @"全选";
        __weak typeof(self) weakSelf = self;
        // !!!: --点击全选按钮，选中所有--
        _editView.chooseAllCell = ^(NSString *clear) {
            weakSelf.cellArr = [NSMutableArray array];
            // !!!: --判断是审核中还是审核通过--
            if ([clear isEqualToString:@"全选"]) {
                if ([weakSelf.status isEqualToString:@"审核中"]) {
                    [weakSelf.dataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        MineTalentInfoModel *model = obj;
                        [weakSelf.cellArr addObject:@([model.iId integerValue])];
                        [weakSelf.listView reloadData];
                    }];
                    // !!!: --根据不同状态获取不同id--
                }else if ([weakSelf.status isEqualToString:@"审核通过"]){
                    [weakSelf.dataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        MineTalentPassModel *model = obj;
                        [weakSelf.cellArr addObject:@([model.ID integerValue])];
                        [weakSelf.listView reloadData];
                    }];
                }
            }else{
                // !!!: --如果是取消全选，因为上面已经重新初始化数组了，所以在这里直接reloadData就可以--
                [weakSelf.listView reloadData];
            }
        };
        // !!!: --取消审核还是删除审核通过--
        _editView.deleteChooseCell = ^(NSString *deleteStr) {
            if ([deleteStr isEqualToString:@"取消审核"]) {
                [weakSelf changeTalentAudit:UpdateunderReviewIssue];
            }else{
                [weakSelf changeTalentAudit:deletePassIssue];
            }
        };
        [self.view insertSubview:_editView atIndex:99];
    }
    return _editView;
}
// MARK: --根据状态不同请求不同接口改变状态--
- (void)changeTalentAudit:(NSString *)url{
    __weak typeof(self) weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [KGRequestNetWorking postWothUrl:url parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"uid":[KGUserInfo shareInterace].userID,@"iIds":_cellArr} succ:^(id result) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        if ([result[@"code"] integerValue] == 200) {
            [[MBProgressHUD bwm_showHUDAddedTo:weakSelf.view title:@"操作成功"] hide:YES afterDelay:1];
            [weakSelf alentEditingStyle];
            [weakSelf alentFailedStyle];
            [weakSelf createData];
        }else{
            [[MBProgressHUD bwm_showHUDAddedTo:weakSelf.view title:@"操作失败"] hide:YES afterDelay:1];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        [[MBProgressHUD bwm_showHUDAddedTo:weakSelf.view title:@"请求失败"] hide:YES afterDelay:1];
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
