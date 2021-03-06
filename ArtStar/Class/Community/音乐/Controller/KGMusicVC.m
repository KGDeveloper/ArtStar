//
//  KGMusicVC.m
//  ArtStar
//
//  Created by abc on 5/25/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "KGMusicVC.h"
#import "HeadLinesDetailVC.h"
#import "MusicPerformanceView.h"
#import "PerformanceDetailVC.h"
#import "MusicInstitutionsView.h"
#import "InstitutionsVC.h"
#import "HotMoviesVC.h"
#import "MusicThemeView.h"
#import "MusicManagementMyThemeVC.h"
#import "MusicMusiciansView.h"
#import "MusicScreeningView.h"
#import "MyselfCenterVC.h"
#import "MusicFoundFriendsView.h"
#import "FoundFriendsScreeningView.h"
#import "HeadLinesNewsDetailAndCommentVC.h"

@interface KGMusicVC ()<MusicInstitutionsViewDelegate,UITextFieldDelegate>

@property (nonatomic,strong) HeadlinesView *headLinesView;//:--头条--
@property (nonatomic,strong) MusicPerformanceView *performanceView;//:--演出--
@property (nonatomic,strong) MusicInstitutionsView *institutionsView;//:--机构--
@property (nonatomic,strong) CommunitySmartView *smartView;//:--机构筛选--
@property (nonatomic,strong) MusicThemeView *themeView;//:--话题--
@property (nonatomic,strong) MusicMusiciansView *musiciansView;//:--音乐人--
@property (nonatomic,strong) MusicScreeningView *screeningView;//:--音乐人筛选--
@property (nonatomic,strong) MusicFoundFriendsView *foundFriendsView;//:--交友--
@property (nonatomic,strong) FoundFriendsScreeningView *foundFriendsScreening;//:--交友筛选--
@property (nonatomic,strong) KGSearchBarTF *searchTF;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,assign) NSInteger page;

// MARK: --交友模块请求数据--
@property (nonatomic,assign) NSInteger friendsPage;//:--交友分页--
@property (nonatomic,assign) NSInteger friendsAge;//:--交友年龄筛选--
@property (nonatomic,assign) NSInteger friendsSex;//:--交友性别筛选--
@property (nonatomic,assign) NSInteger friendsDistance;//:--交友距离筛选--
@property (nonatomic,assign) NSInteger friendActive;//:--交友活跃天数--

@end

@implementation KGMusicVC

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
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setLeftBtuWithFrame:CGRectMake(0, 0, 50, 30) title:nil image:Image(@"back")];
    [self setRightBtuWithFrame:CGRectMake(0, 0, 50, 30) title:nil image:Image(@"more popup message")];
    
    _dataArr = [NSMutableArray array];
    _page = 1;
    [self createHeadLineData];
    [self setSearchBar];
    [self setTopView];
}
- (void)setTopView{
    __weak typeof(self) mySelf = self;
    //MARK:--顶部滚动条--
    CommunityHeaderScrollView *scrollerView = [[CommunityHeaderScrollView alloc]initWithFrame:CGRectMake(0, NavTopHeight, kScreenWidth, 40)];
    scrollerView.itemArr = @[@"头条",@"音乐人",@"演出",@"机构",@"话题",@"交友"];
    //MARK:--滚动条右侧按钮点击事件--
    scrollerView.rightAction = ^(NSString *title) {
        if ([title isEqualToString:@"机构"]) {
            mySelf.smartView.hidden = NO;
        }else if ([title isEqualToString:@"音乐人"]){
            mySelf.screeningView.hidden = NO;
        }else if ([title isEqualToString:@"交友"]){
            mySelf.foundFriendsScreening.hidden = NO;
        }
    };
    //MARK:--滚动条按钮点击事件--
    scrollerView.titleAction = ^(NSString *title) {
        if ([title isEqualToString:@"演出"]) {
            [mySelf questPerformList];
            [mySelf.view bringSubviewToFront:mySelf.performanceView];
            mySelf.smartView.hidden = YES;
        }else if([title isEqualToString:@"头条"]){
            [mySelf.view bringSubviewToFront:mySelf.headLinesView];
            mySelf.smartView.hidden = YES;
        }else if ([title isEqualToString:@"机构"]){
            [mySelf.view bringSubviewToFront:mySelf.institutionsView];
        }else if ([title isEqualToString:@"话题"]){
            [mySelf.view bringSubviewToFront:self.themeView];
            mySelf.smartView.hidden = YES;
        }else if ([title isEqualToString:@"音乐人"]){
            [mySelf.view bringSubviewToFront:mySelf.musiciansView];
            mySelf.smartView.hidden = YES;
        }else{
            [mySelf requestFriendData];
            [mySelf.view bringSubviewToFront:mySelf.foundFriendsView];
            mySelf.smartView.hidden = YES;
        }
    };
    [self.view addSubview:scrollerView];
    [self.view insertSubview:self.headLinesView atIndex:99];
}
//MARK:--头条--
- (HeadlinesView *)headLinesView{
    if (!_headLinesView) {
        _headLinesView = [[HeadlinesView alloc]initWithFrame:CGRectMake(0, NavTopHeight + 40, kScreenWidth, kScreenHeight - NavTopHeight - 40)];
        [_headLinesView hideHeaderView];
        __weak typeof(self) mySelf = self;
        // !!!: --点击新闻跳转详情页--
        _headLinesView.pushViewController = ^(NSString *ID) {
            HeadLinesNewsDetailAndCommentVC *vc = [[HeadLinesNewsDetailAndCommentVC alloc]init];
            vc.ID = ID;
            [mySelf pushNoTabBarViewController:vc animated:YES];
        };
        // !!!: --下拉刷新以及上拉加载更多--
        _headLinesView.requestNewData = ^(NSString *type) {
            if ([type isEqualToString:@"下拉"]) {
                mySelf.page = 1;
                [mySelf.dataArr removeAllObjects];
                [mySelf createHeadLineData];
            }else{
                mySelf.page++;
                [mySelf createHeadLineData];
            }
        };
        // !!!: --关闭新闻--
        _headLinesView.closeNewsWithReson = ^(NSArray *resonArr,NSString *ID) {
            [mySelf requestCloseNews:resonArr nid:ID];
        };
        [self.view addSubview:_headLinesView];
    }
    return _headLinesView;
}
//MARK:--展览--
- (MusicPerformanceView *)performanceView{
    __weak typeof(self) mySelf = self;
    if (!_performanceView) {
        _performanceView = [[MusicPerformanceView alloc]initWithFrame:CGRectMake(0, NavTopHeight + 40, kScreenWidth, kScreenHeight - NavTopHeight - 40)];
        _performanceView.pushToDetaialVC = ^(NSString *ID) {
            [mySelf pushNoTabBarViewController:[[PerformanceDetailVC alloc]init] animated:YES];
        };
        [self.view addSubview:_performanceView];
    }
    return _performanceView;
}
//MARK:--机构--
- (MusicInstitutionsView *)institutionsView{
    __weak typeof(self) mySelf = self;
    if (!_institutionsView) {
        _institutionsView = [[MusicInstitutionsView alloc]initWithFrame:CGRectMake(0, NavTopHeight + 40, kScreenWidth, kScreenHeight - NavTopHeight - 40)];
        _institutionsView.delegate = self;
        _institutionsView.chooseStyle = @"音乐";
        _institutionsView.pushViewController = ^{
            [mySelf pushNoTabBarViewController:[[InstitutionsVC alloc]init] animated:YES];
        };
        [self.view addSubview:_institutionsView];
    }
    return _institutionsView;
}
//MARK:--话题--
- (MusicThemeView *)themeView{
    __weak typeof(self) mySelf = self;
    if (!_themeView) {
        _themeView = [[MusicThemeView alloc]initWithFrame:CGRectMake(0, NavTopHeight + 40, kScreenWidth, kScreenHeight - NavTopHeight - 40)];
        _themeView.pushViewController = ^{
            [mySelf pushNoTabBarViewController:[[MusicManagementMyThemeVC alloc]init] animated:YES];
        };
        [self.view addSubview:_themeView];
    }
    return _themeView;
}
//MARK:--音乐人--
- (MusicMusiciansView *)musiciansView{
    if (!_musiciansView) {
        _musiciansView = [[MusicMusiciansView alloc]initWithFrame:CGRectMake(0, NavTopHeight + 40, kScreenWidth, kScreenHeight - NavTopHeight - 40)];
        __weak typeof(self) mySelf = self;
        _musiciansView.pushViewController = ^{
            [mySelf pushNoTabBarViewController:[[MyselfCenterVC alloc]init] animated:YES];
        };
        [self.view addSubview:_musiciansView];
    }
    return _musiciansView;
}
//MARK:--音乐人筛选框--
- (MusicScreeningView *)screeningView{
    if (!_screeningView) {
        _screeningView = [[MusicScreeningView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _screeningView.sendProvinceNameAndCityName = ^(NSString *provinceName, NSString *cityName) {
            
        };
        _screeningView.sendSexStr = ^(NSString *sex) {
            
        };
        _screeningView.sendTypeStr = ^(NSString *type) {
            
        };
        [self.navigationController.view addSubview:_screeningView];
    }
    return _screeningView;
}
//MARK:--机构筛选框--
- (CommunitySmartView *)smartView{
    if (!_smartView) {
        _smartView = [[CommunitySmartView alloc]initWithFrame:CGRectMake(ViewWidth(self.view) - 120, NavTopHeight + 40, 120, 135) titleArr:@[@"智能筛选",@"销量最高",@"距离最近"] iconArr:@[@"screen popup screen",@"screen popup hot",@"screen popup location"]];
        __weak typeof(self) mySelf = self;
        _smartView.action = ^(NSString *title) {
            mySelf.institutionsView.chooseStyle = title;
        };
        [self.navigationController.view addSubview:_smartView];
        
    }
    return _smartView;
}
//MARK:--MusicInstitutionsViewDelegate--
- (void)loadHotMovies{
    [self pushNoTabBarViewController:[[HotMoviesVC alloc]init] animated:YES];
}
//MARK:--交友--
- (MusicFoundFriendsView *)foundFriendsView{
    if (!_foundFriendsView) {
        _foundFriendsView = [[MusicFoundFriendsView alloc]initWithFrame:CGRectMake(0, NavTopHeight + 40, kScreenWidth, kScreenHeight - NavTopHeight - 40)];
        [self.view addSubview:_foundFriendsView];
    }
    return _foundFriendsView;
}
//MARK:--交友筛选--
- (FoundFriendsScreeningView *)foundFriendsScreening{
    if (!_foundFriendsScreening) {
        _foundFriendsScreening = [[FoundFriendsScreeningView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        [self.navigationController.view addSubview:_foundFriendsScreening];
    }
    return _foundFriendsScreening;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == _searchTF) {
        [_searchTF resignFirstResponder];
        KGSearchBarAndSearchView *searchView = nil;
        if (!searchView) {
            searchView = [[KGSearchBarAndSearchView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
            [self.navigationController.view addSubview:searchView];
        }
        
    }
}
// MARK: --请求头条数据--
- (void)createHeadLineData{
    dispatch_async(dispatch_get_main_queue(), ^{
        __weak typeof(self) weakSelf = self;
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [KGRequestNetWorking postWothUrl:communityServer parameters:@{@"uid":[KGUserInfo shareInterace].userID,@"typename":@"音乐",@"query":@{@"page":@"1",@"rows":@"15"}} succ:^(id result) {
            [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
            if ([result[@"code"] integerValue] == 200) {
                NSArray *dataArray = result[@"data"];
                for (int i = 0; i < dataArray.count; i++) {
                    NSDictionary *dic = dataArray[i];
                    [weakSelf.dataArr addObject:dic];
                }
                weakSelf.headLinesView.dataArr = weakSelf.dataArr;
            }
        } fail:^(NSError *error) {
            [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        }];
    });
}
//MARK:--请求关闭新闻--
- (void)requestCloseNews:(NSArray *)arr nid:(NSString *)ID{
    NSString *backname = @"";
    NSDictionary *dic = _dataArr[ID.integerValue];
    for (int i = 0; i < arr.count; i++) {
        backname = [[backname stringByAppendingString:arr[0]] stringByAppendingString:@","];
    }
    __weak typeof(self) mySelf = self;
    [KGRequestNetWorking postWothUrl:closeNewsByNid parameters:@{@"uid":[KGUserInfo shareInterace].userID,@"nid":dic[@"id"],@"backname":backname} succ:^(id result) {
        if ([result[@"code"] integerValue] == 200) {
            mySelf.page = 1;
            [mySelf.headLinesView starRefrash];
        }
    } fail:^(NSError *error) {
        
    }];
}
// MARK: --请求演出数据--
- (void)questPerformList{
    [KGRequestNetWorking postWothUrl:selectPerformListByTypename parameters:@{@"typename":@"音乐",@"query":@{@"page":@"1",@"rows":@"15"},@"navigation":@"近期热门"} succ:^(id result) {
        
    } fail:^(NSError *error) {
        
    }];
}
// MARK: --请求交友数据--
- (void)requestFriendData{
    [KGRequestNetWorking postWothUrl:selectUserBytypename parameters:@{@"query":@{@"page":@"0",@"rows":@"15"},@"typename":@"音乐",@"uid":[KGUserInfo shareInterace].userID,@"age":@(_friendsAge),@"sex":@(_friendsSex),@"distance":@(_friendsDistance),@"active":@(_friendActive)} succ:^(id result) {
        
    } fail:^(NSError *error) {
        
    }];
}
- (void)friendsSearchConditions{
    
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
