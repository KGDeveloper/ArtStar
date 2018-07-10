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
    [self createHeadLineData];
    [self setSearchBar];
    [self setTopView];
    
}
- (void)setTopView{
    __weak typeof(self) mySelf = self;
    //MARK:-------------------------------------------顶部滚动条---------------------------------------------
    CommunityHeaderScrollView *scrollerView = [[CommunityHeaderScrollView alloc]initWithFrame:CGRectMake(0, NavTopHeight, kScreenWidth, 40)];
    scrollerView.itemArr = @[@"全部",@"美术",@"音乐",@"戏剧",@"电影"];
    //MARK:---------------------------------------------滚动条按钮点击事件-------------------------------------------
    scrollerView.titleAction = ^(NSString *title) {
        if ([title isEqualToString:@"全部"]) {
            [mySelf.view bringSubviewToFront:self.themeView];
        }else if([title isEqualToString:@"美术"]){
            [mySelf.view bringSubviewToFront:self.themeView];
        }else if ([title isEqualToString:@"音乐"]){
            [mySelf.view bringSubviewToFront:self.themeView];
        }else if ([title isEqualToString:@"戏剧"]){
            [mySelf.view bringSubviewToFront:self.themeView];
        }else{
            [mySelf.view bringSubviewToFront:self.themeView];
        }
    };
    [self.view addSubview:scrollerView];
    [self.view insertSubview:self.themeView atIndex:99];
}
//MARK:----------------------------------------------------------话题--------------------------------------------------------------
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
