//
//  CommunityFriendsVC.m
//  ArtStar
//
//  Created by abc on 6/5/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "CommunityFriendsVC.h"
#import "MusicFoundFriendsView.h"
#import "FoundFriendsScreeningView.h"

@interface CommunityFriendsVC ()<UITextFieldDelegate>

@property (nonatomic,strong) MusicFoundFriendsView *foundFriendsView;//:--交友--
@property (nonatomic,strong) FoundFriendsScreeningView *foundFriendsScreening;//:--交友筛选--
@property (nonatomic,strong) KGSearchBarTF *searchTF;

@end

@implementation CommunityFriendsVC

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
    scrollerView.itemArr = @[@"全部",@"美术",@"音乐",@"戏剧",@"电影",@"摄影",@"美食",@"设计",@"书籍"];
    //MARK:--------------------------------------------滚动条右侧按钮点击事件--------------------------------------------
    scrollerView.rightAction = ^(NSString *title) {
        mySelf.foundFriendsScreening.hidden = NO;
    };
    //MARK:---------------------------------------------滚动条按钮点击事件-------------------------------------------
    scrollerView.titleAction = ^(NSString *title) {
        if ([title isEqualToString:@"全部"]) {
            [mySelf.view bringSubviewToFront:mySelf.foundFriendsView];
        }else if([title isEqualToString:@"美术"]){
            [mySelf.view bringSubviewToFront:mySelf.foundFriendsView];
        }else if ([title isEqualToString:@"音乐"]){
            [mySelf.view bringSubviewToFront:mySelf.foundFriendsView];
        }else if ([title isEqualToString:@"戏剧"]){
            [mySelf.view bringSubviewToFront:mySelf.foundFriendsView];
        }else if ([title isEqualToString:@"电影"]){
            [mySelf.view bringSubviewToFront:mySelf.foundFriendsView];
        }else if ([title isEqualToString:@"摄影"]){
            [mySelf.view bringSubviewToFront:mySelf.foundFriendsView];
        }else if ([title isEqualToString:@"美食"]){
            [mySelf.view bringSubviewToFront:mySelf.foundFriendsView];
        }else if ([title isEqualToString:@"设计"]){
            [mySelf.view bringSubviewToFront:mySelf.foundFriendsView];
        }else{
            [mySelf.view bringSubviewToFront:mySelf.foundFriendsView];
        }
    };
    [self.view addSubview:scrollerView];
    [self.view insertSubview:self.foundFriendsView atIndex:99];
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
