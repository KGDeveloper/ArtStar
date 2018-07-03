//
//  MovieNewsDetaialVC.m
//  ArtStar
//
//  Created by abc on 2018/6/27.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MovieNewsDetaialVC.h"
#import "HeadLineHaveTitleNewsTableViewCell.h"
#import "HeadLineNotTitleNewsTableViewCell.h"
#import "HeadLineImageNewsTableViewCell.h"

@interface MovieNewsDetaialVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) CommunitySmartView *smartView;
@property (nonatomic,strong) UITableView *listView;

@end

@implementation MovieNewsDetaialVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLeftBtuWithFrame:CGRectMake(0, 0, 50, 30) title:nil image:Image(@"back")];
    [self setRightBtuWithFrame:CGRectMake(0, 0, 50, 30) title:nil image:Image(@"more")];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setTableView];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.smartView.hidden = YES;
}
//MARK:----------------------------------------导航栏右侧按钮点击事件------------------------------------------------
- (void)rightNavBtuAction:(UIButton *)sender{
    if (self.smartView.hidden == NO) {
        self.smartView.hidden = YES;
    }else{
        self.smartView.hidden = NO;
    }
}
//MARK:--------------------------------------右侧筛选按钮--------------------------------------------------
- (CommunitySmartView *)smartView{
    if (!_smartView) {
        _smartView = [[CommunitySmartView alloc]initWithFrame:CGRectMake(ViewWidth(self.view) - 100, NavTopHeight - 5, 100, 135) titleArr:@[@"消息",@"收藏",@"举报"] iconArr:@[@"more popup message",@"more popup collection",@"more popup report"]];
        _smartView.hidden = YES;
        [self.navigationController.view addSubview:_smartView];
    }
    return _smartView;
}
//MARK:-----------------------------------------新闻详情页-----------------------------------------------
- (void)setTableView{
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0, NavTopHeight, kScreenWidth, kScreenHeight - NavTopHeight)];
    _listView.showsVerticalScrollIndicator = NO;
    _listView.showsHorizontalScrollIndicator = NO;
    _listView.bounces = NO;
    _listView.tableFooterView = TabLeViewFootView;
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_listView];
    
    [_listView registerClass:[HeadLineHaveTitleNewsTableViewCell class] forCellReuseIdentifier:@"HeadLineHaveTitleNewsTableViewCell"];
    [_listView registerClass:[HeadLineNotTitleNewsTableViewCell class] forCellReuseIdentifier:@"HeadLineNotTitleNewsTableViewCell"];
    [_listView registerNib:[UINib nibWithNibName:@"HeadLineImageNewsTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HeadLineImageNewsTableViewCell"];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0 || indexPath.row == 3) {
        return [XHWebImageAutoSize imageHeightForURL:[NSURL URLWithString:@"http://tougao.duowan.com/pic/2013/10/143/1381729007458.jpg"] layoutWidth:kScreenWidth - 30 estimateHeight:300];
    }else if(indexPath.row == 1 || indexPath.row == 4){
        HeadLineNotTitleNewsTableViewCell *cell = [HeadLineNotTitleNewsTableViewCell new];
        return [cell tableViewCellRowHeight:@"在讲话中，习近平强调，从党的十九大到党的二十大，是实现“两个一百年”奋斗目标的历史交汇期，在中华民族伟大复兴历史进程中具有特殊重大意义。习近平再次提到历史交汇期。之前在十九大报告中，习近平指出，从十九大到二十大，是“两个一百年”奋斗目标的历史交汇期。我们既要全面建成小康社会、实现第一个百年奋斗目标，又要乘势而上开启全面建设社会主义现代化国家新征程，向第二个百年奋斗目标进军。由此可见，当下我国正处在历史交汇期，而在习近平看来，这个时间节点在中华民族伟大复兴历史进程中具有特殊重大意义。"];
    }else{
        HeadLineHaveTitleNewsTableViewCell *cell = [HeadLineHaveTitleNewsTableViewCell new];
        return [cell tableViewCellRowHeight:@"2015年7月24日，全国青联十二届全委会和全国学联二十六大在京举行。习近平在向大会发来的贺信中提出，当代中国青年要在感悟时代、紧跟时代中珍惜韶华，自觉按照党和人民的要求锤炼自己、提高自己，做到志存高远、德才并重、情理兼修、勇于开拓，在火热的青春中放飞人生梦想，在拼搏的青春中成就事业华章。"];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0 || indexPath.row == 3) {
        HeadLineImageNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeadLineImageNewsTableViewCell"];
        [cell.topImage sd_setImageWithURL:[NSURL URLWithString:@"http://tougao.duowan.com/pic/2013/10/143/1381729007458.jpg"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            [XHWebImageAutoSize storeImageSize:image forURL:imageURL completed:^(BOOL result) {
                if (result) {
                    [tableView xh_reloadDataForURL:imageURL];
                }
            }];
        }];
        return cell;
    }else if (indexPath.row == 1 || indexPath.row == 4){
        HeadLineNotTitleNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeadLineNotTitleNewsTableViewCell"];
        cell.detailStr = @"在讲话中，习近平强调，从党的十九大到党的二十大，是实现“两个一百年”奋斗目标的历史交汇期，在中华民族伟大复兴历史进程中具有特殊重大意义。习近平再次提到历史交汇期。之前在十九大报告中，习近平指出，从十九大到二十大，是“两个一百年”奋斗目标的历史交汇期。我们既要全面建成小康社会、实现第一个百年奋斗目标，又要乘势而上开启全面建设社会主义现代化国家新征程，向第二个百年奋斗目标进军。由此可见，当下我国正处在历史交汇期，而在习近平看来，这个时间节点在中华民族伟大复兴历史进程中具有特殊重大意义。";
        return cell;
    }else{
        HeadLineHaveTitleNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeadLineHaveTitleNewsTableViewCell"];
        cell.titleStr = @"字字珠玑 习近平为青年传“经”授“诀”";
        cell.detailStr = @"2015年7月24日，全国青联十二届全委会和全国学联二十六大在京举行。习近平在向大会发来的贺信中提出，当代中国青年要在感悟时代、紧跟时代中珍惜韶华，自觉按照党和人民的要求锤炼自己、提高自己，做到志存高远、德才并重、情理兼修、勇于开拓，在火热的青春中放飞人生梦想，在拼搏的青春中成就事业华章。";
        return cell;
    }
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
