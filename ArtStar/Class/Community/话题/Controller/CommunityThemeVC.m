//
//  CommunityThemeVC.m
//  ArtStar
//
//  Created by abc on 6/5/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "CommunityThemeVC.h"
#import "MusicThemeView.h"
#import "MusicManagementMyThemeVC.h"

@interface CommunityThemeVC ()<UITextFieldDelegate>

@property (nonatomic,strong) MusicThemeView *themeView;//:--话题--
@property (nonatomic,strong) KGSearchBarTF *searchTF;
/**
 搜索话题页面
 */
@property (nonatomic,strong) KGSearchBarAndSearchView *searchView;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) NSMutableArray *hotArr;
@property (nonatomic,strong) NSMutableArray *hoistryArr;
@property (nonatomic,copy) NSString *titleStr;

@end

@implementation CommunityThemeVC

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
    _titleStr = @"音乐";
    self.themeView.titleName = @"音乐";
    _dataArr = [NSMutableArray array];
    _hotArr = [NSMutableArray array];
    _hoistryArr = [NSMutableArray array];
    [self createHotAndHoistryData];
    [self setSearchBar];
    [self setTopView];
    
}
- (void)setTopView{
    __weak typeof(self) mySelf = self;
    //MARK:-------------------------------------------顶部滚动条---------------------------------------------
    CommunityHeaderScrollView *scrollerView = [[CommunityHeaderScrollView alloc]initWithFrame:CGRectMake(0, NavTopHeight, kScreenWidth, 40)];
    scrollerView.itemArr = @[@"音乐",@"美术",@"戏剧",@"电影",@"摄影",@"书籍",@"设计",@"美食",@"文学"];
    //MARK:---------------------------------------------滚动条按钮点击事件-------------------------------------------
    scrollerView.titleAction = ^(NSString *title) {
        mySelf.themeView.titleName = title;
        mySelf.titleStr = title;
    };
    [self.view addSubview:scrollerView];
    [self.view insertSubview:self.themeView atIndex:99];
}
//MARK:----------------------------------------------------------话题--------------------------------------------------------------
- (MusicThemeView *)themeView{
    if (!_themeView) {
        _themeView = [[MusicThemeView alloc]initWithFrame:CGRectMake(0, NavTopHeight + 40, kScreenWidth, kScreenHeight - NavTopHeight - 40)];
        __weak typeof(self) mySelf = self;
        _themeView.pushViewController = ^{
            [mySelf pushNoTabBarViewController:[[MusicManagementMyThemeVC alloc]init] animated:YES];
        };
        [self.view addSubview:_themeView];
    }
    return _themeView;
}
// MARK: --改变textfield的键盘监听事件，弹出搜索页面--
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == _searchTF) {
        [_searchTF resignFirstResponder];
        self.searchView.hidden = NO;
        self.searchView.searchUrl = topicSearch;
        self.searchView.hotArr = _hotArr;
        self.searchView.historyArr = _hoistryArr;
    }
}
// MARK: --搜索页面--
- (KGSearchBarAndSearchView *)searchView{
    if (!_searchView) {
        _searchView = [[KGSearchBarAndSearchView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        __weak typeof(self) mySelf = self;
        // !!!: --搜索新闻--
        _searchView.searchResult = ^(NSString *result) {
            [mySelf createNewsData:result];
        };
        // !!!: --点击搜索历史，直接快速搜索--
        _searchView.clickSearchTitle = ^(NSString *title) {
            [mySelf createNewsData:title];
        };
        [self.navigationController.view addSubview:_searchView];
    }
    return _searchView;
}
//MARK:--搜索话题--
- (void)createNewsData:(NSString *)searchStr{
    [_dataArr removeAllObjects];
    __weak typeof(self) mySelf = self;
    [KGRequestNetWorking postWothUrl:topicSearch parameters:@{@"uid":[KGUserInfo shareInterace].userID,@"mohu":searchStr,@"page":@"1",@"rows":@"15",@"typename":_titleStr} succ:^(id result) {
        if ([result[@"code"] integerValue] == 200) {
            NSArray *dataArray = result[@"data"];
            for (int i = 0; i < dataArray.count; i++) {
                NSDictionary *dic = dataArray[i];
                [mySelf.dataArr addObject:dic];
            }
            mySelf.themeView.sendArr = mySelf.dataArr.copy;
            mySelf.searchView.hidden = YES;
        }
    } fail:^(NSError *error) {
        
    }];
}
// MARK: --请求搜索历史以及热词--
- (void)createHotAndHoistryData{
    __weak typeof(self) weakSelf = self;
    [KGRequestNetWorking postWothUrl:oldSearchTopic parameters:@{@"uid":[KGUserInfo shareInterace].userID,@"query":@{@"page":@"0",@"rows":@"15"}} succ:^(id result) {
        if ([result[@"code"] integerValue] == 200) {
            NSArray *tmp = result[@"data"];
            if (tmp.count > 0) {
                weakSelf.hoistryArr = [NSMutableArray arrayWithArray:tmp];
            }
        }
    } fail:^(NSError *error) {
        
    }];
    
    [KGRequestNetWorking postWothUrl:hotSearchTopic parameters:@{} succ:^(id result) {
        if ([result[@"code"] integerValue] == 200) {
            NSArray *tmp = result[@"data"];
            if (tmp.count > 0) {
                weakSelf.hotArr = [NSMutableArray arrayWithArray:tmp];
            }
        }
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
