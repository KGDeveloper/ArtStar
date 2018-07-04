//
//  MineTheAddressBookVC.m
//  ArtStar
//
//  Created by abc on 2018/6/14.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineTheAddressBookVC.h"
#import "MineBookButtonView.h"
#import "MineBooksFriendsView.h"
#import "MineBooksFansView.h"
#import "MineBooksFocusView.h"

@interface MineTheAddressBookVC ()

@property (nonatomic,strong) UIView *topView;
@property (nonatomic,strong) MineBookButtonView *leftBtu;
@property (nonatomic,strong) MineBookButtonView *centerBtu;
@property (nonatomic,strong) MineBookButtonView *rightBtu;
@property (nonatomic,strong) UIView *line;

@property (nonatomic,strong) MineBooksFriendsView *friendsView;
@property (nonatomic,strong) MineBooksFansView *fansView;
@property (nonatomic,strong) MineBooksFocusView *foucsView;


@end

@implementation MineTheAddressBookVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBtuWithFrame:CGRectMake(0, 0, 150, 30) title:@"通讯录" image:Image(@"back")];
    [self setRightBtuWithFrame:CGRectMake(0, 0, 50, 30) title:nil image:Image(@"搜索")];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setTopTouchView];
}

- (void)setTopTouchView{
    _topView = [[UIView alloc]initWithFrame:CGRectMake(0, NavTopHeight, kScreenWidth, 60)];
    [self.view addSubview:_topView];
    
    _leftBtu = [[MineBookButtonView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth/3, 60)];
    _leftBtu.name = @"好友";
    _leftBtu.count = @"1";
    _leftBtu.btuColor = Color_333333;
    __weak typeof(self) mySelf = self;
    _leftBtu.touchUpInside = ^{
        mySelf.centerBtu.btuColor = Color_999999;
        mySelf.rightBtu.btuColor = Color_999999;
        mySelf.leftBtu.btuColor = Color_333333;
        [mySelf changeLineOriginX:mySelf.leftBtu];
        [mySelf.view bringSubviewToFront:mySelf.friendsView];
    };
    [_topView addSubview:_leftBtu];
    
    _centerBtu = [[MineBookButtonView alloc]initWithFrame:CGRectMake(kScreenWidth/3, 0,kScreenWidth/3, 60)];
    _centerBtu.name = @"关注";
    _centerBtu.count = @"1";
    _centerBtu.btuColor = Color_999999;
    _centerBtu.touchUpInside = ^{
        mySelf.centerBtu.btuColor = Color_333333;
        mySelf.leftBtu.btuColor = Color_999999;
        mySelf.rightBtu.btuColor = Color_999999;
        [mySelf changeLineOriginX:mySelf.centerBtu];
        [mySelf.view bringSubviewToFront:mySelf.foucsView];
    };
    [_topView addSubview:_centerBtu];
    
    _rightBtu = [[MineBookButtonView alloc]initWithFrame:CGRectMake(kScreenWidth/3*2, 0,kScreenWidth/3, 60)];
    _rightBtu.name = @"粉丝";
    _rightBtu.count = @"1";
    _rightBtu.btuColor = Color_999999;
    _rightBtu.touchUpInside = ^{
        mySelf.rightBtu.btuColor = Color_333333;
        mySelf.centerBtu.btuColor = Color_999999;
        mySelf.leftBtu.btuColor = Color_999999;
        [mySelf changeLineOriginX:mySelf.rightBtu];
        [mySelf.view bringSubviewToFront:mySelf.fansView];
    };
    [_topView addSubview:_rightBtu];
    
    _line = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth/6 - 15, 58, 30, 2)];
    _line.backgroundColor = Color_333333;
    [_topView addSubview:_line];
    
    UIView *lowLine = [[UIView alloc]initWithFrame:CGRectMake(0, 59, kScreenWidth, 1)];
    lowLine.backgroundColor = Color_ededed;
    [_topView addSubview:lowLine];
    
    self.friendsView.hidden = NO;
    
}

- (MineBooksFriendsView *)friendsView{
    if (!_friendsView) {
        _friendsView = [[MineBooksFriendsView alloc]initWithFrame:CGRectMake(0, NavTopHeight + 60, kScreenWidth, kScreenHeight - NavTopHeight - 60)];
        [self.view addSubview:_friendsView];
    }
    return _friendsView;
}
- (MineBooksFansView *)fansView{
    if (!_fansView) {
        _fansView = [[MineBooksFansView alloc]initWithFrame:CGRectMake(0, NavTopHeight + 60, kScreenWidth, kScreenHeight - NavTopHeight - 60)];
        [self.view addSubview:_fansView];
    }
    return _fansView;
}
- (MineBooksFocusView *)foucsView{
    if (!_foucsView) {
        _foucsView = [[MineBooksFocusView alloc]initWithFrame:CGRectMake(0, NavTopHeight + 60, kScreenWidth, kScreenHeight - NavTopHeight - 60)];
        [self.view addSubview:_foucsView];
    }
    return _foucsView;
}

- (void)changeLineOriginX:(MineBookButtonView *)sender{
    [UIView animateWithDuration:0.2 animations:^{
        self.line.centerX = sender.centerX;
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
