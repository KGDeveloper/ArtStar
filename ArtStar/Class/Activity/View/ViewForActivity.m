//
//  ViewForActivity.m
//  ArtStar
//
//  Created by 文艺星球 on 2018/8/30.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "ViewForActivity.h"
#import "ActivityCellTableViewCell.h"

@interface ViewForActivity ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic,strong) UIView *centerView;
@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation ViewForActivity

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    }
    return self;
}
// MARK: --活动弹窗--
- (void)setActivityView:(UIImage *)addImage{
    _centerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth - 60, (kScreenWidth - 60)/addImage.size.width*addImage.size.height)];
    _centerView.center = self.center;
    [self addSubview:_centerView];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:_centerView.bounds];
    imageView.image = addImage;
    [_centerView addSubview:imageView];
}
// MARK: --关闭按钮点击事件--
- (void)cancelAction{
    self.hidden = YES;
}
// MARK: --根据类型创建按钮--
- (void)setAlertType:(NSInteger)alertType{
    _alertType = alertType;
    // MARK: --判断如果是APP进入首页加载活动入口，显示关闭按钮--
    if (alertType == ActivityTypeMapShow) {
        UIButton *cancelBtu = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtu.frame = CGRectMake(ViewX(_centerView) + ViewWidth(_centerView) - 26, ViewY(_centerView) - 36, 26, 26);
        [cancelBtu setImage:Image(@"组19拷贝") forState:UIControlStateNormal];
        [cancelBtu addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelBtu];
    }else if (alertType == ActivityTypeClick){
        _page = 1;
        _dataArr = [NSMutableArray array];
        [self requestData];
        [self setUpListView];
    }
}

- (void)setUpListView{
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(32, 65, ViewWidth(_centerView) - 64, ViewHeight(_centerView) - 140)];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.emptyDataSetSource = self;
    _listView.emptyDataSetDelegate = self;
    _listView.rowHeight = 50;
    _listView.backgroundColor = [UIColor clearColor];
    _listView.tableFooterView = TabLeViewFootView;
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    __weak typeof(self) weakSelf = self;
    _listView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.dataArr = [NSMutableArray array];
        weakSelf.page = 1;
        [weakSelf  requestData];
        [weakSelf.listView.mj_header beginRefreshing];
    }];
    _listView.mj_footer =[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page++;
        [weakSelf requestData];
        [weakSelf.listView.mj_footer beginRefreshing];
    }];
    [_centerView insertSubview:_listView atIndex:99];
    
    [_listView registerNib:[UINib nibWithNibName:@"ActivityCellTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ActivityCellTableViewCell"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ActivityCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActivityCellTableViewCell"];
    if (_dataArr.count > 0) {
        NSDictionary *dic = _dataArr[indexPath.row];
        cell.timeLab.text = [[dic[@"time"] componentsSeparatedByString:@" "] firstObject];
        cell.nameLab.text = dic[@"mName"];
    }
    return cell;
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return Image(@"空空如也");
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *str = @"木有内容哦~";
    NSDictionary *attributes = @{NSFontAttributeName:SYFont(15),NSForegroundColorAttributeName:Color_999999};
    return [[NSAttributedString alloc]initWithString:str attributes:attributes];
}
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView{
    return 25.0;
}
// MARK: --根据传入的图片创建自适应的视图--
- (void)setShowImage:(UIImage *)showImage{
    _showImage = showImage;
    [self removeAllSubviews];
    [self setActivityView:showImage];
}
// MARK: --点击视图--
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    // MARK: --如果是APP启动进入首页展示的活动入口，点击即可进入活动页面，否则判断点击区域关闭页面--
    if (_alertType == ActivityTypeMapShow) {
        if (self.mapShowPushActivityController) {
            self.mapShowPushActivityController();
            self.hidden = YES;
        }
    }else{
        if (CGRectContainsPoint(CGRectMake(ViewX(_centerView) + ViewWidth(_centerView) - 60, ViewY(_centerView), 60, 60), [[touches anyObject] locationInView:self])) {
            self.hidden = YES;
        }
    }
}

- (void)requestData{
    [MBProgressHUD showHUDAddedTo:self animated:YES];
    __weak typeof(self) weakSelf = self;
    [KGRequestNetWorking postWothUrl:selectPunchRecordListByUidAndMid parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"uid":[KGUserInfo shareInterace].userID,@"page":@(_page),@"rows":@"15"} succ:^(id result) {
        [MBProgressHUD hideAllHUDsForView:weakSelf animated:YES];
        if ([result[@"code"] integerValue] == 200) {
            NSArray *tmp = result[@"data"];
            if (tmp.count > 0) {
                [weakSelf.dataArr addObjectsFromArray:tmp];
            }
        }
        [weakSelf.listView.mj_header endRefreshing];
        [weakSelf.listView.mj_footer endRefreshing];
        [weakSelf.listView reloadData];
    } fail:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:weakSelf animated:YES];
        [weakSelf.listView.mj_header endRefreshing];
        [weakSelf.listView.mj_footer endRefreshing];
        [weakSelf.listView reloadData];
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
