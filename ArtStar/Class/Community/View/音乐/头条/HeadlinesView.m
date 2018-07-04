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

@interface HeadlinesView ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,HeadLinesTableViewCellDelagate,CommunityShieldingViewDelegate>

@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,strong) HeaderScrollAndPageView *pageView;
@property (nonatomic,strong) UIView *headerView;
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
//MARK:---------------------------------------创建筛选view-----------------------------------------
- (CommunityShieldingView *)shieldingView{
    if (!_shieldingView) {
        _shieldingView = [[CommunityShieldingView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _shieldingView.delegate = self;
        [[self rootViewCintroller].navigationController.view addSubview:_shieldingView];
    }
    return _shieldingView;
}
//MARK:---------------------------------------创建列表视图------------------------------------------
- (void)setUI{
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth(self), ViewHeight(self))];
    _listView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    _listView.backgroundView = [[UIImageView alloc]initWithImage:Image(@"空空如也")];
    _listView.delegate = self;
    _listView.dataSource = self;
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
//MARK:---------------------------------------创建头视图------------------------------------------
- (UIView *)tableViewHeaderView{
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth(self),ViewWidth(self)/750*500 + 50)];
    _headerView.backgroundColor = Color_fafafa;
    _pageView = [[HeaderScrollAndPageView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth(_headerView), ViewHeight(_headerView) - 10) style:HeaderStyleHeadLines];
    _pageView.imageArr = @[@"1",@"2",@"3",@"4",@"5"];
    [_headerView addSubview:_pageView];
    
    return _headerView;
}
//MARK:---------------------------------------dataSoucre------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}
//MARK:---------------------------------------dataSoucre------------------------------------------
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
    if (indexPath.row%2==0) {
        if (self.pushViewController) {
            self.pushViewController(@"视频");
        }
    }else{
        if (self.pushViewController) {
            self.pushViewController(@"新闻");
        }
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
- (void)deleteNewsWithIndex:(HeadLinesTableViewCell *)index buttonOriginY:(CGFloat)y{
    
    self.shieldingView.hidden = NO;
    self.shieldingView.shieldingOrigin = [self convertRect:[_listView rectForRowAtIndexPath:[_listView indexPathForCell:index]] toView:self].origin.y - _listView.contentOffset.y + 20 + NavTopHeight + 40;
}
//MARK:--------------------------CommunityShieldingViewDelegate----------------------------------
- (void)sendTitleArrToView:(NSArray *)selectArr{
    
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
