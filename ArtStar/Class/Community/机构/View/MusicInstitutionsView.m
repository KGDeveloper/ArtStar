//
//  MusicInstitutionsView.m
//  ArtStar
//
//  Created by abc on 5/29/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "MusicInstitutionsView.h"
#import "HotMoviesView.h"
#import "InstittutionsCell.h"


@interface MusicInstitutionsView ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic,strong) HotMoviesView *hotView;
@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,assign) BOOL isChoose;
@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation MusicInstitutionsView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = Color_fafafa;
        _isChoose = NO;
        _dataArr = [NSMutableArray array];
        [self setView];
    }
    return self;
}

- (void)setView{
    
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth(self), ViewHeight(self))];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.emptyDataSetSource = self;
    _listView.emptyDataSetDelegate = self;
    _listView.rowHeight = 140;
    _listView.tableFooterView = TabLeViewFootView;
    _listView.tableHeaderView = [self setTbaleViewHeader];
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_listView];
    
    [_listView registerClass:[InstittutionsCell class] forCellReuseIdentifier:@"InstittutionsCell"];
}

- (UIView *)setTbaleViewHeader{
    
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth(self), 185)];
    _headerView.backgroundColor = Color_fafafa;
    _hotView = [[HotMoviesView alloc]initWithFrame:CGRectMake(0, 10, ViewWidth(self), 165)];
    _hotView.moviesArr = @[@{@"image":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527581342598&di=b03a7d968568e8a41237af66a702bf09&imgtype=0&src=http%3A%2F%2Fv.vnet.mobi%2Fportal%2F480%2Fimage%2F10%2F863%2F188.jpg",@"name":@"武侠剧"},@{@"image":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527581342597&di=3d31e7aca54ead09c211ef1a60799ade&imgtype=0&src=http%3A%2F%2Fphotocdn.sohu.com%2F20060727%2FImg244477487.jpg",@"name":@"东方不败"},@{@"image":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527581342597&di=62f676b9d912295068f677c55bf3bf28&imgtype=0&src=http%3A%2F%2Fwenwen.soso.com%2Fp%2F20090713%2F20090713141554-1060107609.jpg",@"name":@"金范中"},@{@"iamge":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527581342596&di=39bd5ab73afa273eda5d5c76a8b0f38c&imgtype=0&src=http%3A%2F%2Fpic.k73.com%2Fup%2Fimage%2F2014%2F1219%2F171749_34007363.jpg",@"name":@"我靠超人"},@{@"image":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527581342596&di=5490496c791a95a099e3e680783a3ad3&imgtype=0&src=http%3A%2F%2Fimg1.gtimg.com%2Fent%2Fpics%2Fhv1%2F132%2F215%2F849%2F55261182.jpg",@"name":@"俩基友"}];
    __weak typeof(self) mySelf = self;
    _hotView.pushViewController = ^{
        if ([mySelf.delegate respondsToSelector:@selector(loadHotMovies)]) {
            [mySelf.delegate loadHotMovies];
        }
    };
    [_headerView addSubview:_hotView];
    
    return _headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    InstittutionsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InstittutionsCell"];
    cell.isChageUI = _isChoose;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.pushViewController) {
        self.pushViewController();
    }
}

- (void)setChooseStyle:(NSString *)chooseStyle{
    _chooseStyle = chooseStyle;
    if ([chooseStyle isEqualToString:@"电影"]) {
        _headerView.frame = CGRectMake(0, 0, ViewWidth(self), 185);
        _hotView.hidden = NO;
        _isChoose = NO;
    }else{
        _headerView.frame = CGRectMake(0, 0, ViewWidth(self), 10);
        _hotView.hidden = YES;
        _isChoose = YES;
    }
    
    [_listView reloadData];
}

- (void)setUrlName:(NSString *)urlName{
    _urlName = urlName;
    if ([urlName isEqualToString:@"全部"]) {
        urlName = @"";
    }
    __weak typeof(self) weakSelf = self;
    [KGRequestNetWorking postWothUrl:selectPlistByTid parameters:@{@"query":@{@"page":@"1",@"rows":@"15"},@"navigation":@"距离最近",@"userlatitude":[[NSUserDefaults standardUserDefaults] objectForKey:@"YourLocationLatitude"],@"userLongitude":[[NSUserDefaults standardUserDefaults] objectForKey:@"YourLocationLongitude"],@"typename":urlName,@"city":[[NSUserDefaults standardUserDefaults] objectForKey:@"yourLocationCity"]} succ:^(id result) {
        if ([result[@"code"] integerValue] == 200) {
            NSArray *tmp = result[@"data"];
            if (tmp.count > 0) {
                [weakSelf.dataArr addObjectsFromArray:tmp];
            }
            [weakSelf.listView reloadData];
        }
    } fail:^(NSError *error) {
        
    }];
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
