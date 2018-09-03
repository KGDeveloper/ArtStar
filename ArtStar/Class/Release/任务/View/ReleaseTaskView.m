//
//  ReleaseTaskView.m
//  ArtStar
//
//  Created by 文艺星球 on 2018/8/3.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "ReleaseTaskView.h"
#import "ReleaseTaskWriteCell.h"
#import "ReleaseTaskIntrduiceCell.h"
#import "MusicChooseCityView.h"

@interface ReleaseTaskView ()<UITableViewDelegate,UITableViewDataSource,ReleaseTaskWriteCellDelegate,ReleaseTaskIntrduiceCellDelegate>

/**
 发布任务填写表单
 */
@property (nonatomic,strong) UITableView *taskView;
/**
 保存cell标题以及预留字
 */
@property (nonatomic,strong) NSArray *dataArr;
/**
 保存发布任务内容
 */
@property (nonatomic,strong) NSMutableDictionary *dic;
/**
 时间选择器
 */
@property (nonatomic,strong) UIDatePicker *datePick;
/**
 设置开始时间
 */
@property (nonatomic,assign) BOOL isStar;
/**
 选择时间view
 */
@property (nonatomic,strong) UIView *chooseView;
/**
 时间值
 */
@property (nonatomic,copy) NSString *chooseTimeStr;
/**
 选择任务发布城市
 */
@property (nonatomic,strong) MusicChooseCityView *cityView;

@end

@implementation ReleaseTaskView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _dataArr = @[@{@"name":@"任务名称",@"title":@"请填写任务名称"},@{@"name":@"开始时间",@"title":@"请选择任务开始时间"},@{@"name":@"结束时间",@"title":@"请选择任务结束时间"},@{@"name":@"任务地点",@"title":@"请填写任务地点"},@{@"name":@"任务城市",@"title":@"请填写任务城市"},@{@"name":@"任务薪酬",@"title":@"请填写任务薪酬"},@{@"name":@"联系方式",@"title":@"请填写联系方式"},@{@"name":@"任务类型",@"title":@"请填写任务类型"}];
        _dic = [NSMutableDictionary dictionary];
        _isStar = YES;
        [self setTaskListView];
    }
    return self;
}
// MARK: --创建任务表单--
- (void)setTaskListView{
    _taskView = [[UITableView alloc]initWithFrame:self.bounds];
    _taskView.delegate = self;
    _taskView.dataSource = self;
    _taskView.tableFooterView = TabLeViewFootView;
    _taskView.bounces = NO;
    _taskView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self addSubview:_taskView];
    
    [_taskView registerNib:[UINib nibWithNibName:@"ReleaseTaskWriteCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ReleaseTaskWriteCell"];
    [_taskView registerNib:[UINib nibWithNibName:@"ReleaseTaskIntrduiceCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ReleaseTaskIntrduiceCell"];
}
// MARK: --UITableViewDelegate--
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < 8) {
        return 50;
    }else{
        return 200;
    }
}
// MARK :--UITableViewDataSource--
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 9;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < 8) {
        ReleaseTaskWriteCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReleaseTaskWriteCell" forIndexPath:indexPath];
        NSDictionary *dic = _dataArr[indexPath.row];
        cell.nameLab.text = dic[@"name"];
        cell.titleText.placeholder = dic[@"title"];
        cell.delegate = self;
        if (_dic[@"btime"]) {
            if (indexPath.row == 1) {
                cell.titleText.text = _dic[@"btime"];
            }
        }
        if (_dic[@"otime"]) {
            if (indexPath.row == 2) {
                cell.titleText.text = _dic[@"otime"];
            }
        }
        if (_dic[@"city"]) {
            if (indexPath.row == 4) {
                cell.titleText.text = _dic[@"city"];
            }
        }
        return cell;
    }else{
        ReleaseTaskIntrduiceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReleaseTaskIntrduiceCell" forIndexPath:indexPath];
        cell.delegate = self;
        return cell;
    }
}
// MARK: --ReleaseTaskWriteCellDelegate--
- (void)changeTextFieldEditStyleWithString:(NSString *)text{
    if ([text isEqualToString:@"请选择任务开始时间"]) {
        _isStar = YES;
        self.chooseView.hidden = NO;
    }else if ([text isEqualToString:@"请选择任务结束时间"]){
        _isStar = NO;
        self.chooseView.hidden = NO;
    }else{
        self.cityView.hidden = NO;
    }
}
- (void)whenTextFieldEndEditSendContentTextToTheUIView:(NSString *)text placeholder:(NSString *)placeholder{
    if ([placeholder isEqualToString:@"请填写任务名称"]) {
        [_dic setObject:text forKey:@"tname"];
    }else if ([placeholder isEqualToString:@"请填写任务地点"]){
        [_dic setObject:text forKey:@"tdrtess"];
    }else if ([placeholder isEqualToString:@"请填写任务薪酬"]){
        [_dic setObject:@(text.integerValue) forKey:@"money"];
    }else if ([placeholder isEqualToString:@"请填写联系方式"]){
        [_dic setObject:text forKey:@"tel"];
    }else if ([placeholder isEqualToString:@"请填写任务类型"]){
        [_dic setObject:text forKey:@"type"];
    }
}
// MARK: --ReleaseTaskIntrduiceCellDelegate--
- (void)sendTaskDescribe:(NSString *)describe{
    [_dic setObject:describe forKey:@"describe"];
}
- (void)releaseTask:(NSString *)type taskId:(NSInteger)taskID{
    if (_dic[@"tname"]) {
        if (_dic[@"btime"]) {
            if (_dic[@"otime"]) {
                if (_dic[@"tdrtess"]) {
                    if (_dic[@"money"]) {
                        if (_dic[@"tel"]) {
                            if (_dic[@"type"]) {
                                if (_dic[@"city"]) {
                                    if (_dic[@"describe"]) {
                                        [MBProgressHUD showHUDAddedTo:self animated:YES];
                                        __weak typeof(self) weakSelf = self;
                                        [_dic setObject:@([[KGUserInfo shareInterace].userID integerValue]) forKey:@"uid"];
                                        NSDictionary *pamarters = _dic.copy;
                                        [KGRequestNetWorking postWothUrl:saveUserTask parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"userTask":pamarters} succ:^(id result) {
                                            [MBProgressHUD hideAllHUDsForView:weakSelf animated:YES];
                                            if ([result[@"code"] integerValue] == 200) {
                                                [MBProgressHUD bwm_showTitle:@"发布成功" toView:self hideAfter:1];
                                            }else{
                                                [MBProgressHUD bwm_showTitle:@"发布失败" toView:self hideAfter:1];
                                            }
                                        } fail:^(NSError *error) {
                                            [MBProgressHUD hideAllHUDsForView:weakSelf animated:YES];
                                            [MBProgressHUD bwm_showTitle:@"请求出错" toView:self hideAfter:1];
                                        }];
                                    }else{[MBProgressHUD bwm_showTitle:@"请填写任务描述" toView:self hideAfter:1];}
                                }else{[MBProgressHUD bwm_showTitle:@"请填写任务城市" toView:self hideAfter:1];}
                            }else{[MBProgressHUD bwm_showTitle:@"请填写任务类型，如：导游" toView:self hideAfter:1];}
                        }else{[MBProgressHUD bwm_showTitle:@"请填写联系方式" toView:self hideAfter:1];}
                    }else{[MBProgressHUD bwm_showTitle:@"请填写任务薪酬" toView:self hideAfter:1];}
                }else{[MBProgressHUD bwm_showTitle:@"请填写任务地点" toView:self hideAfter:1];}
            }else{[MBProgressHUD bwm_showTitle:@"请选择任务结束" toView:self hideAfter:1];}
        }else{[MBProgressHUD bwm_showTitle:@"请选择任务开始" toView:self hideAfter:1];}
    }else{[MBProgressHUD bwm_showTitle:@"请填写任务名称" toView:self hideAfter:1];}
}
// MARK: --时间选择器--
- (UIView *)chooseView{
    if (!_chooseView) {
        _chooseView = [[UIView alloc]initWithFrame:CGRectMake(0,ViewHeight(self) - 250, kScreenWidth, 250)];
        _chooseView.backgroundColor = [UIColor whiteColor];
        [self insertSubview:_chooseView atIndex:99];
        
        UIButton *cancelBtu = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtu.frame = CGRectMake(15, 0, 50, 50);
        [cancelBtu setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtu setTitleColor:Color_999999 forState:UIControlStateNormal];
        cancelBtu.titleLabel.font = SYFont(12);
        [cancelBtu addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        [_chooseView addSubview:cancelBtu];
        
        UIButton *shureBtu = [UIButton buttonWithType:UIButtonTypeCustom];
        shureBtu.frame = CGRectMake(kScreenWidth - 75, 0, 50, 50);
        [shureBtu setTitle:@"确定" forState:UIControlStateNormal];
        [shureBtu setTitleColor:Color_333333 forState:UIControlStateNormal];
        shureBtu.titleLabel.font = SYFont(12);
        [shureBtu addTarget:self action:@selector(shureAction) forControlEvents:UIControlEventTouchUpInside];
        [_chooseView addSubview:shureBtu];
        
        _datePick = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 50, kScreenWidth, 200)];
        //:--设置日期选择器的地区--
        [_datePick setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
        [_datePick setDatePickerMode:UIDatePickerModeDateAndTime];
        [_datePick setMaximumDate:[NSDate dateWithTimeIntervalSinceNow:360*24*60*60]];
        [_datePick setMinimumDate:[NSDate dateWithTimeIntervalSinceNow:0]];
        [_datePick setDatePickerMode:UIDatePickerModeDateAndTime];
        [_datePick addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
        [_chooseView addSubview:_datePick];
    }
    return _chooseView;
}
- (void)dateChange:(UIDatePicker *)sender{
    NSTimeZone *timeZone=[NSTimeZone systemTimeZone];
    NSInteger seconds=[timeZone secondsFromGMTForDate:sender.date];
    NSDate *newDate=[sender.date dateByAddingTimeInterval:seconds];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    [formatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    _chooseTimeStr=[formatter stringFromDate:newDate];
}
- (void)cancelAction{
    self.chooseView.hidden = YES;
}
- (void)shureAction{
    self.chooseView.hidden = YES;
    if (_chooseTimeStr == nil) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *nowDate = [NSDate date];
        _chooseTimeStr = [formatter stringFromDate:nowDate];
    }
    if (_isStar == YES) {
        [_dic setObject:_chooseTimeStr forKey:@"btime"];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        [_taskView reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationAutomatic];
    }else{
        [_dic setObject:_chooseTimeStr forKey:@"otime"];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
        [_taskView reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}
// MARK: --任务发布城市--
- (MusicChooseCityView *)cityView{
    if (!_cityView) {
        _cityView = [[MusicChooseCityView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,ViewHeight(self))];
        __weak typeof(self) weakSelf = self;
        _cityView.titleStr = @"发布任务";
        _cityView.sendProvinceNameAndCityName = ^(NSString *provinceName, NSString *cityName) {
            [weakSelf.dic setObject:cityName forKey:@"city"];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:4 inSection:0];
            [weakSelf.taskView reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationAutomatic];
            
        };
        [self addSubview:_cityView];
    }
    return _cityView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
