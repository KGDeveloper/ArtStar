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

@interface CommunityBooksVC ()

@property (nonatomic,strong) HeadlinesView *headLinesView;//:--头条--
@property (nonatomic,strong) CommunitySmartView *smartView;//:--机构筛选--
@property (nonatomic,strong) MusicThemeView *themeView;//:--话题--
@property (nonatomic,strong) MusicFoundFriendsView *foundFriendsView;//:--交友--
@property (nonatomic,strong) FoundFriendsScreeningView *foundFriendsScreening;//:--交友筛选--
@property (nonatomic,strong) ActivityView *activityView;
@property (nonatomic,strong) ReadBooksView *readBookView;

@end

@implementation CommunityBooksVC

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
    scrollerView.itemArr = @[@"头条",@"活动",@"读书",@"话题",@"交友"];
    //MARK:--------------------------------------------滚动条右侧按钮点击事件--------------------------------------------
    scrollerView.rightAction = ^(NSString *title) {
        mySelf.foundFriendsScreening.hidden = NO;
    };
    //MARK:---------------------------------------------滚动条按钮点击事件-------------------------------------------
    scrollerView.titleAction = ^(NSString *title) {
        if ([title isEqualToString:@"活动"]) {
            [mySelf.view bringSubviewToFront:mySelf.activityView];
        }else if([title isEqualToString:@"头条"]){
            [mySelf.view bringSubviewToFront:mySelf.headLinesView];
        }else if ([title isEqualToString:@"读书"]){
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
//MARK:---------------------------------------------活动-------------------------------------------
- (ActivityView *)activityView{
    if (!_activityView) {
        _activityView = [[ActivityView alloc]initWithFrame:CGRectMake(0, NavTopHeight + 40, kScreenWidth, kScreenHeight - NavTopHeight - 40)];
        [self.view addSubview:_activityView];
    }
    return _activityView;
}
//MARK:----------------------------------------------------------头条--------------------------------------------------------------
- (HeadlinesView *)headLinesView{
    __weak typeof(self) mySelf = self;
    if (!_headLinesView) {
        _headLinesView = [[HeadlinesView alloc]initWithFrame:CGRectMake(0, NavTopHeight + 40, kScreenWidth, kScreenHeight - NavTopHeight - 40)];
        _headLinesView.pushViewController = ^(NSString *type) {
            if ([type isEqualToString:@"视频"]) {
                [mySelf pushNoTabBarViewController:[[HeadLinesDetailVC alloc]init] animated:YES];
            }else{
                [mySelf pushNoTabBarViewController:[[HeadLinesDetailVC alloc]init] animated:YES];
            }
        };
        [self.view addSubview:_headLinesView];
    }
    return _headLinesView;
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
//MARK:----------------------------------------------读书------------------------------------------
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
