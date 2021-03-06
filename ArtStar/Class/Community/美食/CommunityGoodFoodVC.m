//
//  CommunityGoodFoodVC.m
//  ArtStar
//
//  Created by abc on 6/5/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "CommunityGoodFoodVC.h"
#import "HeadLinesDetailVC.h"
#import "PerformanceDetailVC.h"
#import "MusicInstitutionsView.h"
#import "InstitutionsVC.h"
#import "HotMoviesVC.h"
#import "MusicThemeView.h"
#import "MusicManagementMyThemeVC.h"
#import "MyselfCenterVC.h"
#import "MusicFoundFriendsView.h"
#import "FoundFriendsScreeningView.h"

@interface CommunityGoodFoodVC ()<MusicInstitutionsViewDelegate,UITextFieldDelegate>

@property (nonatomic,strong) HeadlinesView *headLinesView;//:--头条--
@property (nonatomic,strong) MusicInstitutionsView *institutionsView;//:--机构--
@property (nonatomic,strong) CommunitySmartView *smartView;//:--机构筛选--
@property (nonatomic,strong) MusicThemeView *themeView;//:--话题--
@property (nonatomic,strong) MusicFoundFriendsView *foundFriendsView;//:--交友--
@property (nonatomic,strong) FoundFriendsScreeningView *foundFriendsScreening;//:--交友筛选--
@property (nonatomic,strong) KGSearchBarTF *searchTF;

@end

@implementation CommunityGoodFoodVC

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
    
    [self createHeadLineData];
    [self setSearchBar];
    [self setTopView];
}
- (void)setTopView{
    __weak typeof(self) mySelf = self;
    //MARK:-------------------------------------------顶部滚动条---------------------------------------------
    CommunityHeaderScrollView *scrollerView = [[CommunityHeaderScrollView alloc]initWithFrame:CGRectMake(0, NavTopHeight, kScreenWidth, 40)];
    scrollerView.itemArr = @[@"头条",@"机构",@"话题",@"交友"];
    //MARK:--------------------------------------------滚动条右侧按钮点击事件--------------------------------------------
    scrollerView.rightAction = ^(NSString *title) {
        if ([title isEqualToString:@"机构"]) {
            mySelf.smartView.hidden = NO;
        }else if ([title isEqualToString:@"交友"]){
            mySelf.foundFriendsScreening.hidden = NO;
        }
    };
    //MARK:---------------------------------------------滚动条按钮点击事件-------------------------------------------
    scrollerView.titleAction = ^(NSString *title) {
        if([title isEqualToString:@"头条"]){
            [mySelf.view bringSubviewToFront:mySelf.headLinesView];
        }else if ([title isEqualToString:@"机构"]){
            [mySelf.view bringSubviewToFront:mySelf.institutionsView];
        }else if ([title isEqualToString:@"话题"]){
            [mySelf.view bringSubviewToFront:self.themeView];
        }else{
            [mySelf.view bringSubviewToFront:mySelf.foundFriendsView];
        }
    };
    [self.view addSubview:scrollerView];
    [self.view insertSubview:self.headLinesView atIndex:99];
}
//MARK:----------------------------------------------------------头条--------------------------------------------------------------
- (HeadlinesView *)headLinesView{
    __weak typeof(self) mySelf = self;
    if (!_headLinesView) {
        _headLinesView = [[HeadlinesView alloc]initWithFrame:CGRectMake(0, NavTopHeight + 40, kScreenWidth, kScreenHeight - NavTopHeight - 40)];
        
        [self.view addSubview:_headLinesView];
    }
    return _headLinesView;
}
//MARK:----------------------------------------------------------机构--------------------------------------------------------------
- (MusicInstitutionsView *)institutionsView{
    __weak typeof(self) mySelf = self;
    if (!_institutionsView) {
        _institutionsView = [[MusicInstitutionsView alloc]initWithFrame:CGRectMake(0, NavTopHeight + 40, kScreenWidth, kScreenHeight - NavTopHeight - 40)];
        _institutionsView.delegate = self;
        _institutionsView.chooseStyle = @"美食";
        _institutionsView.pushViewController = ^{
            [mySelf pushNoTabBarViewController:[[InstitutionsVC alloc]init] animated:YES];
        };
        [self.view addSubview:_institutionsView];
    }
    return _institutionsView;
}
//MARK:----------------------------------------------------------机构--------------------------------------------------------------
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
//MARK:-------------------------------------------------------机构筛选框--------------------------------------------------------------
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
//MARK:------------------------------MusicInstitutionsViewDelegate--------------------------------------------------------
- (void)loadHotMovies{
    [self pushNoTabBarViewController:[[HotMoviesVC alloc]init] animated:YES];
}
//MARK:----------------------------------------------交友------------------------------------------
- (MusicFoundFriendsView *)foundFriendsView{
    if (!_foundFriendsView) {
        _foundFriendsView = [[MusicFoundFriendsView alloc]initWithFrame:CGRectMake(0, NavTopHeight + 40, kScreenWidth, kScreenHeight - NavTopHeight - 40)];
        [self.view addSubview:_foundFriendsView];
    }
    return _foundFriendsView;
}
//MARK:---------------------------------------------交友筛选-------------------------------------------
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

- (void)createHeadLineData{
    [KGRequestNetWorking postWothUrl:ntvByTopic parameters:@{@"typename":_titleName,@"query":@{@"page":@"0",@"rows":@"15"}} succ:^(id result) {
        
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
