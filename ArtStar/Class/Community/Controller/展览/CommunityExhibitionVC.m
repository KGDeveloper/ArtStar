//
//  CommunityExhibitionVC.m
//  ArtStar
//
//  Created by abc on 6/5/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "CommunityExhibitionVC.h"
#import "HeadLinesDetailVC.h"
#import "MusicPerformanceView.h"
#import "PerformanceDetailVC.h"
#import "CommunityExhibitionModel.h"

@interface CommunityExhibitionVC ()<UITextFieldDelegate>

@property (nonatomic,strong) MusicPerformanceView *performanceView;//:--演出--
@property (nonatomic,strong) KGSearchBarTF *searchTF;
@property (nonatomic,copy) NSString *currtitleStr;//:--当前顶部标题--
@property (nonatomic,copy) NSString *currClassStr;//:--当前中间分类--
@property (nonatomic,strong) NSMutableArray *dataArr;//:--保存数据--
@property (nonatomic,assign) NSInteger page;//:--页数--

@end

@implementation CommunityExhibitionVC

- (void)setSearchBar{
    _searchTF = [[KGSearchBarTF alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth - 75, 30)];
    _searchTF.placeholder = @"搜索";
    _searchTF.leftView = [[UIImageView alloc]initWithImage:Image(@"search")];
    _searchTF.leftViewMode = UITextFieldViewModeAlways;
    _searchTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _searchTF.delegate = self;
    _searchTF.font = SYFont(12);
    _searchTF.layer.cornerRadius = 5;
    _searchTF.layer.masksToBounds = YES;
    _searchTF.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
    _searchTF.returnKeyType = UIReturnKeySearch;
    [self setNavTitleView:_searchTF];
}

- (void)rightNavBtuAction:(UIButton *)sender{
    [self pushNoTabBarViewController:[[MIneMessageVC alloc]init] animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBtuWithFrame:CGRectMake(0, 0, 50, 30) title:nil image:Image(@"back")];
    [self setRightBtuWithFrame:CGRectMake(0, 0, 50, 30) title:nil image:Image(@"more popup message")];
    self.view.backgroundColor = [UIColor whiteColor];
    // TODO: --在这里初始化以及给定默认值--
    _currtitleStr = @"美术";
    _currClassStr = @"近期热门";
    _page = 0;
    _dataArr = [NSMutableArray array];
    // TODO: --先请求数据，然后加载页面，但是因为网速问题，可能页面加载出来，但是数据还没有显示，所以记得刷新--
    [self createHeadLineData];
    [self setSearchBar];
    [self setTopView];
}
- (void)setTopView{
    __weak typeof(self) mySelf = self;
    //MARK:---------------------------顶部滚动条--------------------
    CommunityHeaderScrollView *scrollerView = [[CommunityHeaderScrollView alloc]initWithFrame:CGRectMake(0, NavTopHeight, kScreenWidth, 40)];
    scrollerView.itemArr = @[@"美术",@"摄影",@"设计"];
    //MARK:---------------------------------滚动条按钮点击事件-----------------------
    scrollerView.titleAction = ^(NSString *title) {
        mySelf.currtitleStr = title;
        mySelf.dataArr = [NSMutableArray array];
        [mySelf createHeadLineData];
    };
    [self.view addSubview:scrollerView];
    [self.view insertSubview:self.performanceView atIndex:99];
}
//MARK:-------------------------------------展览-------------------------------
- (MusicPerformanceView *)performanceView{
    __weak typeof(self) mySelf = self;
    if (!_performanceView) {
        _performanceView = [[MusicPerformanceView alloc]initWithFrame:CGRectMake(0, NavTopHeight + 40, kScreenWidth, kScreenHeight - NavTopHeight - 40)];
        // TODO: --点击cell进行页面跳转--
        _performanceView.pushToDetaialVC = ^(NSString *ID) {
            PerformanceDetailVC *vc = [[PerformanceDetailVC alloc]init];
            vc.ID = ID;
            [mySelf pushNoTabBarViewController:vc animated:YES];
        };
        // TODO: --点击近期热门，即将开始，即将结束的数据请求--
        _performanceView.classTypeAction = ^(NSString *classStr) {
            mySelf.currClassStr = classStr;
            mySelf.dataArr = [NSMutableArray array];
            [mySelf createHeadLineData];
        };
        // TODO: --下拉刷新列表--
        _performanceView.refreshHeader = ^{
            mySelf.page = 0;
            mySelf.dataArr = [NSMutableArray array];
            [mySelf createHeadLineData];
        };
        // TODO: --上拉加载更多--
        _performanceView.reloadFoot = ^(NSInteger page) {
            mySelf.page = page;
            [mySelf createHeadLineData];
        };
        [self.view addSubview:_performanceView];
    }
    return _performanceView;
}
/**
 监听导航栏的输入框，替换事件

 @param textField 监听导航栏的输入框，替换事件
 */
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == _searchTF) {
        [_searchTF resignFirstResponder];
        KGSearchBarAndSearchView *searchView = nil;
        // TODO: --代替textfield的编辑事件，直接弹出搜索页面--
        if (!searchView) {
            searchView = [[KGSearchBarAndSearchView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
            [self.navigationController.view addSubview:searchView];
        }
        
    }
}
/**
 数据请求
 */
- (void)createHeadLineData{
    [MBProgressHUD bwm_showHUDAddedTo:self.view title:@"正在努力加载中..."];
    __weak typeof(self) weakSelf = self;
    [KGRequestNetWorking postWothUrl:selectSlistByTypename parameters:@{@"typename":_currtitleStr,@"navigation":_currClassStr,@"query":@{@"page":@(_page),@"rows":@"15"}} succ:^(id result) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        if ([result[@"code"] integerValue] == 200) {
            NSArray *arr = result[@"data"];
            NSArray *tmpArr = [CommunityExhibitionModel mj_objectArrayWithKeyValuesArray:arr];
            // TODO: --在这里不是直接copy而是遍历add的原因是，可能点击上拉加载更多的话数据一直是15条，而且开始的数据就会消失--
            for (int i = 0; i < tmpArr.count; i++) {
                [weakSelf.dataArr addObject:tmpArr[i]];
            }
            weakSelf.performanceView.dataArr = weakSelf.dataArr.copy;
        }
    } fail:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
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
