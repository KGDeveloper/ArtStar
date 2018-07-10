//
//  HeadLinesVC.m
//  ArtStar
//
//  Created by abc on 5/28/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "HeadLinesVC.h"
#import "CommenityModel.h"
#import "MovieNewsDetaialVC.h"
#import "CommenityHotSearchModel.h"
#import "CommenityHoistorySearchModel.h"
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

- (void)rightNavBtuAction:(UIButton *)sender{
    [self pushNoTabBarViewController:[[MIneMessageVC alloc]init] animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBtuWithFrame:CGRectMake(0, 0, 50, 30) title:nil image:Image(@"back")];
    [self setRightBtuWithFrame:CGRectMake(0, 0, 50, 30) title:nil image:Image(@"more popup message")];
    self.view.backgroundColor = [UIColor whiteColor];
    //:--设置搜索框--
    [self setSearchBar];
    //:--初始化--
    _page = 0;
    _typeName = @"";
    _dataArr = [NSMutableArray array];
    _hotArr = [NSMutableArray array];
    _hoistryArr = [NSMutableArray array];
    //:--搜索记录数据--
    [self craeteSeachArr];
    //:--搭建界面--
    [self setViewUI];
    //:--顶部滚动条--
    [self setTopView];
}

- (void)setTopView{
    __weak typeof(self) mySelf = self;
    CommunityHeaderScrollView *scrollerView = [[CommunityHeaderScrollView alloc]initWithFrame:CGRectMake(0, NavTopHeight, kScreenWidth, 40)];
    scrollerView.itemArr = @[@"全部",@"美术",@"音乐",@"戏剧",@"电影",@"图书",@"餐饮",@"摄影",@"文学"];
    scrollerView.rightAction = ^(NSString *title) {
        
    };
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

- (void)setViewUI{
    _headLinesView = [[HeadlinesView alloc]initWithFrame:CGRectMake(0, NavTopHeight + 40, kScreenWidth, kScreenHeight - NavTopHeight - 40)];
    __weak typeof(self) mySelf = self;
    _headLinesView.pushViewController = ^(NSString *ID) {
        MovieNewsDetaialVC *vc = [[MovieNewsDetaialVC alloc]init];
        vc.ID = ID;
        [mySelf pushNoTabBarViewController:vc animated:YES];
    };
    _headLinesView.requestNewData = ^(NSString *type) {
        if ([type isEqualToString:@"下拉"]) {
            mySelf.page = 0;
            [mySelf.dataArr removeAllObjects];
            [mySelf createDataArr];
        }else{
            mySelf.page++;
            [mySelf createDataArr];
        }
    };
    _headLinesView.closeNewsWithReson = ^(NSArray *resonArr,NSString *ID) {
        [mySelf requestCloseNews:resonArr nid:ID];
    };
    [self.view addSubview:_headLinesView];
}
//MARK:-------------------------------------请求关闭新闻---------------------------------------------------
- (void)requestCloseNews:(NSArray *)arr nid:(NSString *)ID{
    NSString *backname = @"";
    CommenityModel *model = _dataArr[ID.integerValue];
    for (int i = 0; i < arr.count; i++) {
        backname = [[backname stringByAppendingString:arr[0]] stringByAppendingString:@","];
    }
    __weak typeof(self) mySelf = self;
    [KGRequestNetWorking postWothUrl:closeNewsByNid parameters:@{@"uid":[KGUserInfo shareInterace].userID,@"nid":model.ID,@"backname":backname} succ:^(id result) {
        if ([result[@"code"] integerValue] == 200) {
            mySelf.page = 0;
            [mySelf.dataArr removeAllObjects];
            [mySelf.headLinesView starRefrash];
        }
    } fail:^(NSString *error) {
        
    }];
}
//MARK:-------------------------------------------拉首页数据---------------------------------------------
- (void)createDataArr{
    __weak typeof(self) mySelf = self;
    [KGRequestNetWorking postWothUrl:communityServer parameters:@{@"uid":@([KGUserInfo shareInterace].userID.integerValue),@"typename":_typeName,@"query":@{@"page":[NSString stringWithFormat:@"%ld",(long)self.page],@"rows":@"15"}} succ:^(id result) {
        if ([result[@"code"] integerValue] == 200) {
            NSArray *dataArray = result[@"data"];
            for (int i = 0; i < dataArray.count; i++) {
                NSDictionary *dic = dataArray[i];
                CommenityModel *model = [CommenityModel mj_objectWithKeyValues:dic];
                [mySelf.dataArr addObject:model];
            }
            mySelf.headLinesView.dataArr = mySelf.dataArr;
        }
    } fail:^(NSString *error) {
        
    }];
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == _searchTF) {
        [_searchTF resignFirstResponder];
        self.searchView.hidden = NO;
        self.searchView.hotArr = _hotArr;
        self.searchView.historyArr = _hoistryArr;
    }
}

- (KGSearchBarAndSearchView *)searchView{
    if (!_searchView) {
        _searchView = [[KGSearchBarAndSearchView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        __weak typeof(self) mySelf = self;
        _searchView.searchResult = ^(NSString *result) {
            [mySelf createNewsData:result];
        };
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
    [KGRequestNetWorking postWothUrl:newsSearch parameters:@{@"uid":[KGUserInfo shareInterace].userID,@"mohu":searchStr,@"query":@{@"page":[NSString stringWithFormat:@"%ld",(long)_page],@"rows":@"15"},@"typename":@""} succ:^(id result) {
        if ([result[@"code"] integerValue] == 200) {
            NSArray *dataArray = result[@"data"];
            for (int i = 0; i < dataArray.count; i++) {
                NSDictionary *dic = dataArray[i];
                CommenityModel *model = [CommenityModel mj_objectWithKeyValues:dic];
                [mySelf.dataArr addObject:model];
            }
            mySelf.headLinesView.dataArr = mySelf.dataArr;
            mySelf.searchView.hidden = YES;
        }
    } fail:^(NSString *error) {
        
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
                CommenityHotSearchModel *model = [CommenityHotSearchModel mj_objectWithKeyValues:dic];
                [mySelf.hotArr addObject:model];
            }
        }
    } fail:^(NSString *error) {
        
    }];
    
    [KGRequestNetWorking postWothUrl:oldSearch parameters:@{@"uid":[KGUserInfo shareInterace].userID,@"query":@{@"page":@"0",@"rows":@"20"}} succ:^(id result) {
        if ([result[@"code"] integerValue] == 200) {
            NSArray *arr = result[@"data"];
            for (int i = 0; i < arr.count; i++) {
                NSDictionary *dic = arr[i];
                CommenityHoistorySearchModel *model = [CommenityHoistorySearchModel mj_objectWithKeyValues:dic];
                [mySelf.hoistryArr addObject:model];
            }
        }
    } fail:^(NSString *error) {
        
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
