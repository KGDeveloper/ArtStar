//
//  CommunityBooksVC.m
//  ArtStar
//
//  Created by abc on 6/5/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "CommunityBooksVC.h"
#import "HeadLinesDetailVC.h"
#import "MusicThemeView.h"
#import "MusicManagementMyThemeVC.h"
#import "MusicFoundFriendsView.h"
#import "FoundFriendsScreeningView.h"
#import "ActivityView.h"
#import "ReadBooksView.h"
#import "ReadBooksHotVC.h"
#import "ReadBooksDetailVC.h"
#import "HeadLinesNewsDetailAndCommentVC.h"

@interface CommunityBooksVC ()<UITextFieldDelegate>

@property (nonatomic,strong) HeadlinesView *headLinesView;//:--头条--
@property (nonatomic,strong) CommunitySmartView *smartView;//:--机构筛选--
@property (nonatomic,strong) MusicThemeView *themeView;//:--话题--
@property (nonatomic,strong) MusicFoundFriendsView *foundFriendsView;//:--交友--
@property (nonatomic,strong) FoundFriendsScreeningView *foundFriendsScreening;//:--交友筛选--
@property (nonatomic,strong) ActivityView *activityView;
@property (nonatomic,strong) ReadBooksView *readBookView;
@property (nonatomic,strong) KGSearchBarTF *searchTF;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,assign) NSInteger page;

@end

@implementation CommunityBooksVC

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
    //:--顶部滚动条--
    CommunityHeaderScrollView *scrollerView = [[CommunityHeaderScrollView alloc]initWithFrame:CGRectMake(0, NavTopHeight, kScreenWidth, 40)];
    scrollerView.itemArr = @[@"头条",@"活动",@"读书",@"话题",@"交友"];
    //:--右侧筛选按钮点击事件--
    scrollerView.rightAction = ^(NSString *title) {
        mySelf.foundFriendsScreening.hidden = NO;
    };
    //:--滚动条按钮点击事件--
    scrollerView.titleAction = ^(NSString *title) {
        if ([title isEqualToString:@"活动"]) {
            [mySelf.view bringSubviewToFront:mySelf.activityView];
            [mySelf requestActivitionData];
        }else if([title isEqualToString:@"头条"]){
            [mySelf.view bringSubviewToFront:mySelf.headLinesView];
        }else if ([title isEqualToString:@"读书"]){
            [mySelf requestHotBooksData];
            [mySelf.view bringSubviewToFront:mySelf.readBookView];
        }else if ([title isEqualToString:@"话题"]){
            [mySelf.view bringSubviewToFront:self.themeView];
        }else{
            [mySelf.view bringSubviewToFront:mySelf.foundFriendsView];
        }
    };
    [self.view addSubview:scrollerView];
    [self.view insertSubview:self.headLinesView atIndex:99];
}
//MARK:--活动--
- (ActivityView *)activityView{
    if (!_activityView) {
        _activityView = [[ActivityView alloc]initWithFrame:CGRectMake(0, NavTopHeight + 40, kScreenWidth, kScreenHeight - NavTopHeight - 40)];
        [self.view addSubview:_activityView];
    }
    return _activityView;
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
//MARK:--读书--
- (ReadBooksView *)readBookView{
    if (!_readBookView) {
        _readBookView = [[ReadBooksView alloc]initWithFrame:CGRectMake(0,NavTopHeight + 40, kScreenWidth, kScreenHeight - NavTopHeight - 40)];
        __weak typeof(self) mySelf = self;
        _readBookView.pushVC = ^{
            [mySelf pushNoTabBarViewController:[[ReadBooksHotVC alloc]init] animated:YES];
        };
        _readBookView.reloadBookDetaial = ^{
            [mySelf pushNoTabBarViewController:[[ReadBooksDetailVC alloc]init] animated:YES];
        };
        [self.view addSubview:_readBookView];
    }
    return _readBookView;
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
        [KGRequestNetWorking postWothUrl:communityServer parameters:@{@"uid":[KGUserInfo shareInterace].userID,@"typename":@"书籍",@"query":@{@"page":@"1",@"rows":@"15"}} succ:^(id result) {
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
// MARK: --请求活动数据--
- (void)requestActivitionData{
    [KGRequestNetWorking postWothUrl:selectActivityListByTypename parameters:@{@"typename":@"书籍",@"query":@{@"page":@"0",@"rows":@"15"}} succ:^(id result) {
        
    } fail:^(NSError *error) {
        
    }];
}
// MARK: --请求今日畅销以及推荐感兴趣书籍数据--
- (void)requestHotBooksData{
    [KGRequestNetWorking postWothUrl:selectBookListByCondition parameters:@{@"uid":[KGUserInfo shareInterace].userID,@"query":@{@"rows":@"15",@"page":@"0"}} succ:^(id result) {
        
    } fail:^(NSError *error) {
        
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
