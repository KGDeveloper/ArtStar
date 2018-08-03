//
//  HeadlinesView.m
//  ArtStar
//
//  Created by abc on 5/24/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "HeadlinesView.h"
#import "HeadLinesTableViewCell.h"
#import "CommenityModel.h"
#import "CommenityNewsDetailModel.h"

@interface HeadlinesView ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,HeadLinesTableViewCellDelagate,CommunityShieldingViewDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

/**
 新闻加载列表
 */
@property (nonatomic,strong) UITableView *listView;
/**
 顶部新闻滚动视图以及页码
 */
@property (nonatomic,strong) HeaderScrollAndPageView *pageView;
/**
 新闻加载列表头视图
 */
@property (nonatomic,strong) UIView *headerView;
/**
 新闻屏蔽页
 */
@property (nonatomic,strong) CommunityShieldingView *shieldingView;

@end

@implementation HeadlinesView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUI];
        [_listView.mj_header beginRefreshing];
    }
    return self;
}
//MARK:--创建筛选view--
- (CommunityShieldingView *)shieldingView{
    if (!_shieldingView) {
        _shieldingView = [[CommunityShieldingView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _shieldingView.delegate = self;
        [[self rootViewCintroller].navigationController.view addSubview:_shieldingView];
    }
    return _shieldingView;
}
//MARK:--创建列表视图--
- (void)setUI{
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth(self), ViewHeight(self))];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.emptyDataSetSource = self;
    _listView.emptyDataSetDelegate = self;
    _listView.tableHeaderView = [self tableViewHeaderView];
    _listView.tableFooterView = TabLeViewFootView;
    _listView.rowHeight = (kScreenWidth-30)/690*400 + 120;
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    __weak typeof(self) mySelf = self;
    _listView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            if (mySelf.requestNewData) {
                mySelf.requestNewData(@"下拉");
            }
        });
    }];
    [self addSubview:_listView];
    
    [_listView registerClass:[HeadLinesTableViewCell class] forCellReuseIdentifier:@"HeadLinesTableViewCell"];
}
//MARK:--创建头视图--
- (UIView *)tableViewHeaderView{
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth(self),ViewWidth(self)/750*500 + 50)];
    _headerView.backgroundColor = Color_fafafa;
    _pageView = [[HeaderScrollAndPageView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth(_headerView), ViewHeight(_headerView) - 10) style:HeaderStyleHeadLines];
    // !!!: --点击新闻轮播图，查看详情--
    __weak typeof(self) weakSelf = self;
    _pageView.selectImageLoadNewsDetailWithID = ^(NSString *ID) {
        if (weakSelf.pushViewController) {
            weakSelf.pushViewController(ID);
        }
    };
    [_headerView addSubview:_pageView];
    
    return _headerView;
}
//MARK:--dataSoucre--
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}
//MARK:--dataSoucre--
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HeadLinesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeadLinesTableViewCell"];
    CommenityModel *model = _dataArr[indexPath.row];
    cell.model = model;
    cell.cellIndex = indexPath.row;
    cell.delegate = self;
    return cell;
}
//MARK:----------------------------------------------------------------------------------------
- (void)starRefrash{
    [_listView.mj_header beginRefreshing];
    if (_dataArr.count == 0) {
        _listView.mj_footer = nil;
    }
    [_listView reloadData];
}
- (void)setDataArr:(NSArray *)dataArr{
    _dataArr = dataArr;
    if (dataArr.count > 15) {
        __weak typeof(self) mySelf = self;
        _listView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [mySelf.listView.mj_footer beginRefreshing];
            if (mySelf.requestNewData) {
                mySelf.requestNewData(@"上拉");
            }
        }];
    }
    [_listView reloadData];
    [_listView.mj_header endRefreshing];
    [_listView.mj_footer endRefreshing];
}
//MARK:---------------------------------------delegate------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CommenityModel *model = _dataArr[indexPath.row];
    if (self.pushViewController) {
        self.pushViewController([NSString stringWithFormat:@"%ld",(long)model.ID.integerValue]);
    }
}
//MARK:---------------------------------------显示头视图------------------------------------------
- (void)showHeaderView{
    _headerView.frame = CGRectMake(0, 0, ViewWidth(self),ViewWidth(self)/750*500 + 40);
    _pageView.hidden = NO;
    [_listView reloadData];
}
//MARK:---------------------------------------隐藏头视图------------------------------------------
- (void)hideHeaderView{
    _headerView.frame = CGRectMake(0, 0, ViewWidth(self),10);
    _headerView.backgroundColor = Color_fafafa;
    _pageView.hidden = YES;
    [_listView reloadData];
}
//MARK:--------------------------HeadLinesTableViewCellDelagate----------------------------------
- (void)deleteNewsWithIndex:(HeadLinesTableViewCell *)cell buttonOriginY:(CGFloat)y index:(NSInteger)index{
    self.shieldingView.hidden = NO;
    self.shieldingView.index = index;
    self.shieldingView.shieldingOrigin = [self convertRect:[_listView rectForRowAtIndexPath:[_listView indexPathForCell:cell]] toView:self].origin.y - _listView.contentOffset.y + 20 + NavTopHeight + 40;
}
- (void)touchCellButtonWithTitle:(NSString *)title cellIndex:(NSInteger)cellIndex{
    __weak typeof(self) weakSelf = self;
    CommenityModel *model = _dataArr[cellIndex];
    if ([title isEqualToString:@"分享"]) {
        
    }else if ([title isEqualToString:@"点赞"]){
        [MBProgressHUD showHUDAddedTo:self animated:YES];
        [KGRequestNetWorking postWothUrl:diannews parameters:@{@"uid":[KGUserInfo shareInterace].userID,@"nid":model.ID,@"zantype":model.zantype} succ:^(id result) {
            [MBProgressHUD hideAllHUDsForView:weakSelf animated:YES];
        } fail:^(NSError *error) {
            [MBProgressHUD hideAllHUDsForView:weakSelf animated:YES];
        }];
    }else if ([title isEqualToString:@"评论"]){
        
    }
}
//MARK:--------------------------CommunityShieldingViewDelegate----------------------------------
- (void)sendTitleArrToView:(NSArray *)selectArr index:(NSInteger)index{
    if (self.closeNewsWithReson) {
        self.closeNewsWithReson(selectArr,[NSString stringWithFormat:@"%ld",(long)index]);
    }
}

- (UIViewController *)rootViewCintroller{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}
- (void)setHeaderArr:(NSArray *)headerArr{
    _headerArr = headerArr;
    _pageView.imageArr = headerArr;
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
