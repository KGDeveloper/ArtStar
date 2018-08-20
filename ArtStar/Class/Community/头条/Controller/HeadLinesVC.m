//
//  HeadLinesVC.m
//  ArtStar
//
//  Created by abc on 5/28/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "HeadLinesVC.h"
#import "HeadLinesNewsDetailAndCommentVC.h"
#import <objc/runtime.h>

@interface HeadLinesVC ()<UITextFieldDelegate>

@property (nonatomic,strong) HeadlinesView *headLinesView;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,copy) NSString *typeName;
@property (nonatomic,strong) KGSearchBarTF *searchTF;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,strong) KGSearchBarAndSearchView *searchView;

@property (nonatomic,strong) NSMutableArray *hotArr;
@property (nonatomic,strong) NSMutableArray *hoistryArr;

@end

@implementation HeadLinesVC
// MARK: --搜索框--
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
    [self setNavTitleView:_searchTF];
}
// MARK: --导航栏右侧按钮--
- (void)rightNavBtuAction:(UIButton *)sender{
    [self pushNoTabBarViewController:[[MIneMessageVC alloc]init] animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBtuWithFrame:CGRectMake(0, 0, 50, 30) title:nil image:Image(@"back")];
    [self setRightBtuWithFrame:CGRectMake(0, 0, 50, 30) title:nil image:Image(@"more popup message")];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //:--初始化--
    _page = 1;
    _typeName = @"";
    _hotArr = [NSMutableArray array];
    _hoistryArr = [NSMutableArray array];
    _dataArr = [NSMutableArray array];
    [self createHeaderData];
    //:--设置搜索框--
    [self setSearchBar];
    //:--搜索记录数据--
    [self craeteSeachArr];
    //:--搭建界面--
    [self setViewUI];
    //:--顶部滚动条--
    [self setTopView];
}
// MARK: --创建顶部滚动视图--
- (void)setTopView{
    __weak typeof(self) mySelf = self;
    CommunityHeaderScrollView *scrollerView = [[CommunityHeaderScrollView alloc]initWithFrame:CGRectMake(0, NavTopHeight, kScreenWidth, 40)];
    scrollerView.itemArr = @[@"全部",@"美术",@"音乐",@"戏剧",@"电影",@"书籍",@"美食",@"摄影",@"文学",@"设计"];
    // !!!: --右侧筛选按钮点击事件--
    scrollerView.rightAction = ^(NSString *title) {
        
    };
    // !!!: --标题按钮点击事件--
    scrollerView.titleAction = ^(NSString *title) {
        if ([title isEqualToString:@"全部"]) {
            mySelf.typeName = @"";
            [mySelf.headLinesView showHeaderView];
            
        }else{
            mySelf.typeName = title;
            [mySelf.headLinesView hideHeaderView];
        }
        [mySelf.dataArr removeAllObjects];
        [mySelf.headLinesView starRefrash];
    };
    [self.view addSubview:scrollerView];
}
// MARK: --创建数据加载界面--
- (void)setViewUI{
    _headLinesView = [[HeadlinesView alloc]initWithFrame:CGRectMake(0, NavTopHeight + 40, kScreenWidth, kScreenHeight - NavTopHeight - 40)];
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
            [mySelf createDataArr];
        }else{
            mySelf.page++;
            [mySelf createDataArr];
        }
    };
    // !!!: --关闭新闻--
    _headLinesView.closeNewsWithReson = ^(NSArray *resonArr,NSString *ID) {
        [mySelf requestCloseNews:resonArr nid:ID];
    };
    [self.view addSubview:_headLinesView];
}
//MARK:-------------------------------------请求关闭新闻---------------------------------------------------
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
// !!!: --在这里最好是在view中传入一个关键词然后进行数据拉去，后期待优化--
//MARK:-------------------------------------------拉首页数据---------------------------------------------
- (void)createDataArr{
    dispatch_async(dispatch_get_main_queue(), ^{
        __weak typeof(self) mySelf = self;
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [KGRequestNetWorking postWothUrl:communityServer parameters:@{@"uid":@([KGUserInfo shareInterace].userID.integerValue),@"typename":mySelf.typeName,@"page":[NSString stringWithFormat:@"%ld",(long)self.page],@"rows":@"15"} succ:^(id result) {
            [MBProgressHUD hideAllHUDsForView:mySelf.view animated:YES];
            if ([result[@"code"] integerValue] == 200) {
                NSArray *dataArray = result[@"data"];
                for (int i = 0; i < dataArray.count; i++) {
                    NSDictionary *dic = dataArray[i];
                    [mySelf.dataArr addObject:dic];
                }
                mySelf.headLinesView.dataArr = mySelf.dataArr;
            }
        } fail:^(NSError *error) {
            [MBProgressHUD hideAllHUDsForView:mySelf.view animated:YES];
        }];
    });
}
// MARK: --拉取顶部5条滚动新闻--
- (void)createHeaderData{
    __weak typeof(self) weakSelf = self;
    [KGRequestNetWorking postWothUrl:hotnews parameters:@{@"uid":[KGUserInfo shareInterace].userID} succ:^(id result) {
        if ([result[@"code"] integerValue] == 200) {
            weakSelf.headLinesView.headerArr = result[@"data"];
        }
    } fail:^(NSError *error) {
        
    }];
}
// MARK: --改变textfield的键盘监听事件，弹出搜索页面--
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == _searchTF) {
        [_searchTF resignFirstResponder];
        self.searchView.hidden = NO;
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
//MARK:-----------------------------------搜索新闻-----------------------------------------------------
- (void)createNewsData:(NSString *)searchStr{
    [_dataArr removeAllObjects];
    __weak typeof(self) mySelf = self;
    [KGRequestNetWorking postWothUrl:newsSearch parameters:@{@"uid":[KGUserInfo shareInterace].userID,@"mohu":searchStr,@"page":[NSString stringWithFormat:@"%ld",(long)_page],@"rows":@"15",@"typename":@""} succ:^(id result) {
        if ([result[@"code"] integerValue] == 200) {
            NSArray *dataArray = result[@"data"];
            for (int i = 0; i < dataArray.count; i++) {
                NSDictionary *dic = dataArray[i];
                [mySelf.dataArr addObject:dic];
            }
            mySelf.headLinesView.dataArr = mySelf.dataArr;
            mySelf.searchView.hidden = YES;
        }
    } fail:^(NSError *error) {
        
    }];
}
//MARK:----------------------------------------热词以及搜索历史------------------------------------------------
- (void)craeteSeachArr{
    __weak typeof(self) mySelf = self;
    [KGRequestNetWorking postWothUrl:hotSearch parameters:@{} succ:^(id result) {
        if ([result[@"code"] integerValue] == 200) {
            NSArray *arr = result[@"data"];
            for (int i = 0; i < arr.count; i++) {
                NSDictionary *dic = arr[i];
                [mySelf.hotArr addObject:dic];
            }
        }
    } fail:^(NSError *error) {
        
    }];
    
    [KGRequestNetWorking postWothUrl:oldSearch parameters:@{@"uid":[KGUserInfo shareInterace].userID,@"page":@"1",@"rows":@"20"} succ:^(id result) {
        if ([result[@"code"] integerValue] == 200) {
            NSArray *arr = result[@"data"];
            for (int i = 0; i < arr.count; i++) {
                NSDictionary *dic = arr[i];
                [mySelf.hoistryArr addObject:dic];
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
