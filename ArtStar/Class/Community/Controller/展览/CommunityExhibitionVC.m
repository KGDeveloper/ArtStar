//
//  CommunityExhibitionVC.m
//  ArtStar
//
//  Created by abc on 6/5/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "CommunityExhibitionVC.h"
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

@interface CommunityExhibitionVC ()<MusicInstitutionsViewDelegate>

@property (nonatomic,strong) MusicPerformanceView *performanceView;//:--演出--

@end

@implementation CommunityExhibitionVC


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
    scrollerView.itemArr = @[@"全部",@"美术",@"摄影",@"设计"];
    //MARK:---------------------------------------------滚动条按钮点击事件-------------------------------------------
    scrollerView.titleAction = ^(NSString *title) {
        if ([title isEqualToString:@"全部"]) {
            
        }else if([title isEqualToString:@"美术"]){
            
        }else if ([title isEqualToString:@"摄影"]){
            
        }else{
            
        }
    };
    [self.view addSubview:scrollerView];
    [self.view insertSubview:self.performanceView atIndex:99];
}

//MARK:----------------------------------------------------------展览--------------------------------------------------------------
- (MusicPerformanceView *)performanceView{
    __weak typeof(self) mySelf = self;
    if (!_performanceView) {
        _performanceView = [[MusicPerformanceView alloc]initWithFrame:CGRectMake(0, NavTopHeight + 40, kScreenWidth, kScreenHeight - NavTopHeight - 40)];
        _performanceView.pushToDetaialVC = ^{
            [mySelf pushNoTabBarViewController:[[PerformanceDetailVC alloc]init] animated:YES];
        };
        [self.view addSubview:_performanceView];
    }
    return _performanceView;
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
