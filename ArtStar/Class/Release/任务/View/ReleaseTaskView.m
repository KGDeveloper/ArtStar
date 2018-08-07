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

@end

@implementation ReleaseTaskView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _dataArr = @[@{@"name":@"任务名称",@"title":@"请填写任务名称"},@{@"name":@"开始时间",@"title":@"请选择任务开始时间"},@{@"name":@"结束时间",@"title":@"请选择任务结束时间"},@{@"name":@"任务地点",@"title":@"请填写任务地点"},@{@"name":@"任务薪酬",@"title":@"请填写任务薪酬"},@{@"name":@"联系方式",@"title":@"请填写联系方式"},@{@"name":@"任务类型",@"title":@"请填写任务类型"}];
        _dic = [NSMutableDictionary dictionary];
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
    if (indexPath.row < 7) {
        return 50;
    }else{
        return 200;
    }
}
// MARK :--UITableViewDataSource--
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 8;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < 7) {
        ReleaseTaskWriteCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReleaseTaskWriteCell" forIndexPath:indexPath];
        NSDictionary *dic = _dataArr[indexPath.row];
        cell.nameLab.text = dic[@"name"];
        cell.titleText.placeholder = dic[@"title"];
        cell.delegate = self;
        return cell;
    }else{
        ReleaseTaskIntrduiceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReleaseTaskIntrduiceCell" forIndexPath:indexPath];
        cell.delegate = self;
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
// MARK: --ReleaseTaskWriteCellDelegate--
- (void)changeTextFieldEditStyleWithString:(NSString *)text{
    if ([text isEqualToString:@"请选择任务开始时间"]) {
        
    }else{
        
    }
}
- (void)whenTextFieldEndEditSendContentTextToTheUIView:(NSString *)text placeholder:(NSString *)placeholder{
    if ([placeholder isEqualToString:@"请填写任务名称"]) {
        [_dic setObject:text forKey:@""];
    }else if ([placeholder isEqualToString:@"请填写任务地点"]){
        [_dic setObject:text forKey:@""];
    }else if ([placeholder isEqualToString:@"请填写任务薪酬"]){
        [_dic setObject:text forKey:@""];
    }else if ([placeholder isEqualToString:@"请填写联系方式"]){
        [_dic setObject:text forKey:@""];
    }else if ([placeholder isEqualToString:@"请填写任务类型"]){
        [_dic setObject:text forKey:@""];
    }
}
// MARK: --ReleaseTaskIntrduiceCellDelegate--
- (void)sendTaskDescribe:(NSString *)describe{
    [_dic setObject:describe forKey:@""];
}
- (void)releaseTask{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
