//
//  HeadLinesVC.m
//  ArtStar
//
//  Created by abc on 5/28/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "HeadLinesVC.h"
#import "HeadLinesDetailVC.h"
#import "CommenityModel.h"

@interface HeadLinesVC ()<UITextFieldDelegate>

@property (nonatomic,strong) HeadlinesView *headLinesView;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,copy) NSString *typeName;
@property (nonatomic,strong) KGSearchBarTF *searchTF;

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
    [self setSearchBar];
    _typeName = @"";
    [self createDataArr];
    [self setViewUI];
    
    __weak typeof(self) mySelf = self;
    CommunityHeaderScrollView *scrollerView = [[CommunityHeaderScrollView alloc]initWithFrame:CGRectMake(0, NavTopHeight, kScreenWidth, 40)];
    scrollerView.itemArr = @[@"全部",@"美术",@"音乐",@"戏剧",@"电影",@"图书",@"餐饮",@"摄影",@"文学",@"机构",@"展览",@"交友"];
    scrollerView.rightAction = ^(NSString *title) {
        
    };
    scrollerView.titleAction = ^(NSString *title) {
        mySelf.typeName = title;
    };
    [self.view addSubview:scrollerView];
}

- (void)setViewUI{
    _headLinesView = [[HeadlinesView alloc]initWithFrame:CGRectMake(0, NavTopHeight + 40, kScreenWidth, kScreenHeight - NavTopHeight - 40)];
    __weak typeof(self) mySelf = self;
    _headLinesView.pushViewController = ^(NSString *type) {
        if ([type isEqualToString:@"视频"]) {
            [mySelf pushNoTabBarViewController:[[HeadLinesDetailVC alloc]init] animated:YES];
        }else{
            [mySelf pushNoTabBarViewController:[[HeadLinesDetailVC alloc]init] animated:YES];
        }
    };
    [self.view addSubview:_headLinesView];
}

- (void)createDataArr{
    _dataArr = [NSMutableArray array];
    __weak typeof(self) mySelf = self;
    [KGRequestNetWorking postWothUrl:communityServer parameters:@{@"uid":@([KGUserInfo shareInterace].userID.integerValue),@"typename":_typeName,@"query":@{@"page":@"0",@"rows":@"15"}} succ:^(id result) {
        NSArray *dataArray = result[@"data"];
        mySelf.dataArr = [CommenityModel mj_keyValuesArrayWithObjectArray:dataArray];
        mySelf.headLinesView.dataArr = mySelf.dataArr;
    } fail:^(NSString *error) {
        
    }];
    
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
