//
//  CommunityExhibitionDetailVC.m
//  ArtStar
//
//  Created by 文艺星球 on 2018/7/31.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "CommunityExhibitionDetailVC.h"
#import "CommunityExhibitionModel.h"
#import "CommunityExhibitionDetailTimeAndAddressCell.h"
#import "CommunityExhibitionIntrouceCell.h"
#import "CommunityExhibitionProductionCell.h"
#import "CommunityExhibitionWorkerCell.h"

@interface CommunityExhibitionDetailVC ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

/**
 详情页面数据加载视图
 */
@property (nonatomic,strong) UITableView *detaiView;
/**
 头视图
 */
@property (nonatomic,strong) UIView *headerScrollView;
/**
 展览介绍图
 */
@property (nonatomic,strong) UIScrollView *scrollView;
/**
 展览介绍图上的页码
 */
@property (nonatomic,strong) UIPageControl *pageControl;
/**
 详情页数据
 */
@property (nonatomic,strong) CommunityExhibitionModel *model;

@end

@implementation CommunityExhibitionDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLeftBtuWithFrame:CGRectMake(0, 0, 250, 30) title:@"2018北京艺术展览博览会" image:Image(@"back")];
    [self setRightBtuWithFrame:CGRectMake(0, 0, 30, 30) title:nil image:Image(@"more popup share")];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createData];
}
// FIXME: --数据请求--
- (void)createData{
    __weak typeof(self) weakSelf = self;
    [MBProgressHUD bwm_showHUDAddedTo:self.view title:@"正在加载中..." animated:YES];
    [KGRequestNetWorking postWothUrl:selectShowBySid parameters:@{@"uid":[KGUserInfo shareInterace].userID,@"id":_ID,@"query":@{@"page":@"0",@"rows":@"5"}} succ:^(id result) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        [weakSelf setDetailView];
        weakSelf.model = [CommunityExhibitionModel mj_objectWithKeyValues:result];
        [weakSelf createScrollViewImageAndButtonWithArray:weakSelf.model.imgList];
        [weakSelf setLeftBtuWithFrame:CGRectMake(0, 0, 250, 30) title:weakSelf.model.showname image:Image(@"back")];
        [weakSelf.detaiView reloadData];
    } fail:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        [MBProgressHUD bwm_showTitle:@"加载失败，请退出重新请求！" toView:weakSelf.view hideAfter:2];
    }];
}
// FIXME: --详情页加载数据视图--
- (void)setDetailView{
    _detaiView = [[UITableView alloc]initWithFrame:CGRectMake(0, NavTopHeight, kScreenWidth, kScreenHeight - NavTopHeight)];
    [_detaiView registerNib:[UINib nibWithNibName:@"CommunityExhibitionDetailTimeAndAddressCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"CommunityExhibitionDetailTimeAndAddressCell"];
    [_detaiView registerNib:[UINib nibWithNibName:@"CommunityExhibitionIntrouceCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"CommunityExhibitionIntrouceCell"];
    [_detaiView registerNib:[UINib nibWithNibName:@"CommunityExhibitionProductionCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"CommunityExhibitionProductionCell"];
    [_detaiView registerNib:[UINib nibWithNibName:@"CommunityExhibitionWorkerCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"CommunityExhibitionWorkerCell"];
    _detaiView.delegate = self;
    _detaiView.dataSource = self;
    _detaiView.bounces = NO;
    _detaiView.showsVerticalScrollIndicator = NO;
    _detaiView.showsHorizontalScrollIndicator = NO;
    _detaiView.tableHeaderView = [self headerViewAddScrollView];
    _detaiView.tableFooterView = TabLeViewFootView;
    _detaiView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_detaiView];
}
// MARK: --UITableViewDelegate--
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return [TransformChineseToPinying heightWithText:_model.showtime font:SYFont(12) width:kScreenWidth-90 height:kScreenHeight] + 210;
    }else if (indexPath.row == 1){
        return 165;
    }else if (indexPath.row == 2){
        return 185;
    }else if (indexPath.row == 3){
        return 246;
    }
    return 10;
}
// MARK :--UITableViewDataSource--
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 9;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        CommunityExhibitionDetailTimeAndAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommunityExhibitionDetailTimeAndAddressCell" forIndexPath:indexPath];
        cell.titleLab.text = _model.showname;
        if ([_model.avgpingfen doubleValue] == 0.0) {
            [cell changeImageWithScoreNumber:0.0];
        }else{
            [cell changeImageWithScoreNumber:[_model.avgpingfen doubleValue]];
        }
        cell.scoreLab.text = [NSString stringWithFormat:@"%.1f",[_model.avgpingfen doubleValue]];
        NSData *timeData = [_model.showtime dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error = nil;
        NSArray *timeArr = [NSJSONSerialization JSONObjectWithData:timeData options:NSJSONReadingMutableContainers error:&error];
        NSString *timeStr = [timeArr firstObject];
        for (int i = 1; i < timeArr.count; i++) {
            timeStr = [NSString stringWithFormat:@"%@\n%@",timeStr,timeArr[i]];
        }
        cell.timeViewHeight.constant = [TransformChineseToPinying heightWithText:_model.showtime font:SYFont(12) width:kScreenWidth-90 height:kScreenHeight];
        cell.timeLab.text = timeStr;
        cell.orgzanizationLab.text = _model.showplace;
        cell.addressLab.text = _model.showaddress;
        cell.hostUnitLab.text = _model.hostunit;
        if (_model.showprice == nil) {
            cell.priceLab.text = @"暂无价格";
        }else{
            cell.priceLab.text = _model.showprice;
        }
        return cell;
    }else if (indexPath.row == 1){
        CommunityExhibitionIntrouceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommunityExhibitionIntrouceCell" forIndexPath:indexPath];
        cell.detailLab.attributedText = [TransformChineseToPinying string:[NSString stringWithFormat:@"%@%@",@"简介：",_model.recommend] font:SYFont(13) space:10];
        return cell;
    }else if (indexPath.row == 2){
        CommunityExhibitionProductionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommunityExhibitionProductionCell" forIndexPath:indexPath];
        if (_model.worksList.count > 0) {
            cell.productionLab.text = [NSString stringWithFormat:@"作品介绍（%lu）",(unsigned long)_model.worksList.count];
            [cell addProductionToScrollViewWithArray:_model.worksList];
        }else{
            cell.productionLab.text = @"作品介绍（0）";
        }
        return cell;
    }else if (indexPath.row == 3){
        CommunityExhibitionWorkerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommunityExhibitionWorkerCell" forIndexPath:indexPath];
        [cell changeScrollViewWithArray:_model.artistList];
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
        }
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
// MARK: --头视图中加载的滚动视图--
- (UIView *)headerViewAddScrollView{
    _headerScrollView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth/750*500)];
    //:--在这里调用--
    [self setHeaderScrollView];
    [self setHeaderPageControl];
    return _headerScrollView;
}
// MARK: --加载展览介绍图--
- (void)setHeaderScrollView{
    _scrollView = [[UIScrollView alloc]initWithFrame:_headerScrollView.bounds];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [_headerScrollView addSubview:_scrollView];
}
// MARK: --展览介绍图页码--
- (void)setHeaderPageControl{
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, ViewHeight(_scrollView) - 15, kScreenWidth, 15)];
    _pageControl.tintColor = [UIColor blackColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    [_headerScrollView addSubview:_pageControl];
}
// MARK: --根据请求下来的数据，创建展览介绍图--
- (void)createScrollViewImageAndButtonWithArray:(NSArray *)arr{
    _pageControl.numberOfPages = arr.count;
    _scrollView.contentSize = CGSizeMake(kScreenWidth * arr.count, ViewHeight(_scrollView));
    for (int i = 0; i < arr.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth*i, 0, kScreenWidth, ViewHeight(_scrollView))];
        NSDictionary *dic = arr[i];
        [imageView sd_setImageWithURL:[NSURL URLWithString:dic[@"worksimg"]]];
        [_scrollView addSubview:imageView];
        if (i == 0) {
            [_scrollView insertSubview:[self createButtonWithFrame:CGRectMake(15, ViewHeight(_scrollView) - 55, 45, 40) title:@"AR展示" image:Image(@"AR")] atIndex:99];
            [_scrollView insertSubview:[self createButtonWithFrame:CGRectMake(kScreenWidth/2 - 20, ViewHeight(_scrollView) - 68, 50, 53) title:@"3D展示" image:Image(@"3d")] atIndex:99];
        }
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _pageControl.currentPage = scrollView.contentOffset.x/kScreenWidth;
}
// MARK: --3D演示以及AR展示按钮--
- (UIButton *)createButtonWithFrame:(CGRect)frame title:(NSString *)title image:(UIImage *)image{
    UIButton *actionBtu = [[UIButton alloc]initWithFrame:frame];
    [actionBtu setTitle:title forState:UIControlStateNormal];
    [actionBtu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    actionBtu.titleLabel.font = SYFont(12);
    [actionBtu setImage:image forState:UIControlStateNormal];
    actionBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    actionBtu.titleEdgeInsets = UIEdgeInsetsMake(actionBtu.imageView.frame.size.height,-actionBtu.imageView.frame.size.width, 0, 0);
    actionBtu.imageEdgeInsets = UIEdgeInsetsMake(-actionBtu.titleLabel.frame.size.height, 0,0, -actionBtu.titleLabel.frame.size.width);
    [actionBtu addTarget:self action:@selector(actionClick:) forControlEvents:UIControlEventTouchUpInside];
    return actionBtu;
}
// MARK: --3D演示以及AR展示按钮点击事件--
- (void)actionClick:(UIButton *)sender{
    if ([sender.currentTitle isEqualToString:@"AR展示"]) {
        
    }else{
        
    }
}
// FIXME: --还没有处理详情页的相关文章，评论，以及推荐--
// FIXME: --还没有处理详情页的相关文章，评论，以及推荐--
// FIXME: --还没有处理详情页的相关文章，评论，以及推荐--
// FIXME: --还没有处理详情页的相关文章，评论，以及推荐--
// TODO: --还没有处理详情页的相关文章，评论，以及推荐--
// TODO: --还没有处理详情页的相关文章，评论，以及推荐--
// TODO: --还没有处理详情页的相关文章，评论，以及推荐--
// TODO: --还没有处理详情页的相关文章，评论，以及推荐--






































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
