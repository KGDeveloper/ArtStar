//
//  ReleaseTaskView.m
//  ArtStar
//
//  Created by 文艺星球 on 2018/8/3.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "ReleaseTaskView.h"
#import "ReleaseTaskWriteCell.h"

@interface ReleaseTaskView ()<UITableViewDelegate,UITableViewDataSource>

/**
 发布任务填写表单
 */
@property (nonatomic,strong) UITableView *taskView;
/**
 保存cell标题以及预留字
 */
@property (nonatomic,strong) NSArray *dataArr;

@end

@implementation ReleaseTaskView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _dataArr = @[@{@"name":@"任务名称",@"title":@"请填写任务名称"},@{@"name":@"开始时间",@"title":@"请选择任务开始时间"},@{@"name":@"结束时间",@"title":@"请选择任务结束时间"},@{@"name":@"任务地点",@"title":@"请请选择任务地点"},@{@"name":@"任务薪酬",@"title":@"请填写任务薪酬"},@{@"name":@"联系方式",@"title":@"请填写联系方式"},@{@"name":@"任务类型",@"title":@"请填写任务类型"}];
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
    [self addSubview:_taskView];
    
    [_taskView registerNib:[UINib nibWithNibName:@"ReleaseTaskWriteCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ReleaseTaskWriteCell"];
}
// MARK: --UITableViewDelegate--
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < 7) {
        return 50;
    }else if (indexPath.row == 7){
        return 130;
    }else{
        return 150;
    }
}
// MARK :--UITableViewDataSource--
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 9;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < 7) {
        ReleaseTaskWriteCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReleaseTaskWriteCell" forIndexPath:indexPath];
        NSDictionary *dic = _dataArr[indexPath.row];
        cell.nameLab.text = dic[@"name"];
        cell.titleText.placeholder = dic[@"title"];
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
