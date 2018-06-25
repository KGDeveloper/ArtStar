//
//  CommunityInstitutionsVC.m
//  ArtStar
//
//  Created by abc on 6/5/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "CommunityInstitutionsVC.h"
#import "MusicInstitutionsView.h"
#import "InstitutionsVC.h"


@interface CommunityInstitutionsVC ()<MusicInstitutionsViewDelegate>

@property (nonatomic,strong) MusicInstitutionsView *institutionsView;//:--机构--
@property (nonatomic,strong) CommunitySmartView *smartView;//:--机构筛选--

@end

@implementation CommunityInstitutionsVC


- (void)rightNavBtuAction:(UIButton *)sender{
    [self pushNoTabBarViewController:[[MIneMessageVC alloc]init] animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setLeftBtuWithTitle:nil image:Image(@"back")];
    [self setRightBtuWithTitle:nil image:Image(@"more popup message")];
    
    __weak typeof(self) mySelf = self;
    //MARK:-------------------------------------------顶部滚动条---------------------------------------------
    CommunityHeaderScrollView *scrollerView = [[CommunityHeaderScrollView alloc]initWithFrame:CGRectMake(0, NavTopHeight, kScreenWidth, 40)];
    scrollerView.itemArr = @[@"全部",@"美术",@"音乐",@"戏剧",@"电影",@"美食",@"书籍",@"设计",@"摄影"];
    //MARK:--------------------------------------------滚动条右侧按钮点击事件--------------------------------------------
    scrollerView.rightAction = ^(NSString *title) {
        mySelf.smartView.hidden = NO;
    };
    //MARK:---------------------------------------------滚动条按钮点击事件-------------------------------------------
    scrollerView.titleAction = ^(NSString *title) {
        if ([title isEqualToString:@"全部"]) {
            [mySelf.view bringSubviewToFront:mySelf.institutionsView];
        }else if([title isEqualToString:@"美术"]){
            [mySelf.view bringSubviewToFront:mySelf.institutionsView];
        }else if ([title isEqualToString:@"音乐"]){
            [mySelf.view bringSubviewToFront:mySelf.institutionsView];
        }else if ([title isEqualToString:@"戏剧"]){
            [mySelf.view bringSubviewToFront:mySelf.institutionsView];
        }else if ([title isEqualToString:@"电影"]){
            [mySelf.view bringSubviewToFront:mySelf.institutionsView];
        }else if ([title isEqualToString:@"美食"]){
            [mySelf.view bringSubviewToFront:mySelf.institutionsView];
        }else if ([title isEqualToString:@"书籍"]){
            [mySelf.view bringSubviewToFront:mySelf.institutionsView];
        }else if ([title isEqualToString:@"设计"]){
            [mySelf.view bringSubviewToFront:mySelf.institutionsView];
        }else{
            [mySelf.view bringSubviewToFront:mySelf.institutionsView];
        }
    };
    [self.view addSubview:scrollerView];
    [self.view insertSubview:self.institutionsView atIndex:99];
}
//MARK:----------------------------------------------------------机构--------------------------------------------------------------
- (MusicInstitutionsView *)institutionsView{
    __weak typeof(self) mySelf = self;
    if (!_institutionsView) {
        _institutionsView = [[MusicInstitutionsView alloc]initWithFrame:CGRectMake(0, NavTopHeight + 40, kScreenWidth, kScreenHeight - NavTopHeight - 40)];
        _institutionsView.delegate = self;
        _institutionsView.pushViewController = ^{
            [mySelf pushNoTabBarViewController:[[InstitutionsVC alloc]init] animated:YES];
        };
        [self.view addSubview:_institutionsView];
    }
    return _institutionsView;
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
