//
//  MyselfWordVC.m
//  ArtStar
//
//  Created by abc on 6/1/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "MyselfWordVC.h"
#import "MyselfWordTopButtonView.h"
#import "MyselfWordHomeView.h"
#import "MyselfWordInfoView.h"
#import "MySelfWordPerformanView.h"
#import "MyselfWordWorksView.h"
#import "MyselfWordUploadingVC.h"
#import "MyselfWordArticleView.h"
#import "MyselfWorksDetaialVC.h"

@interface MyselfWordVC ()<UIScrollViewDelegate>

@property (nonatomic,strong) MyselfWordHomeView *homeView;
@property (nonatomic,strong) MyselfWordInfoView *infoView;
@property (nonatomic,strong) MySelfWordPerformanView *performanView;
@property (nonatomic,strong) MyselfWordWorksView *worksView;
@property (nonatomic,strong) MyselfWordArticleView *articleView;
@property (nonatomic,strong) UIScrollView *backScroView;
@property (nonatomic,strong) MyselfWordTopButtonView *topView;

@end

@implementation MyselfWordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLeftBtuWithFrame:CGRectMake(0, 0, 150, 30) title:@"姚新月" image:Image(@"back")];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setTopView];
    [self setBackView];
    
}

- (void)setBackView{
    _backScroView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, NavTopHeight + 50, kScreenWidth, kScreenHeight - NavTopHeight - 50)];
    _backScroView.contentSize = CGSizeMake(kScreenWidth *5, kScreenHeight - NavTopHeight - 50);
    _backScroView.bounces = NO;
    _backScroView.showsVerticalScrollIndicator = NO;
    _backScroView.showsHorizontalScrollIndicator = NO;
    _backScroView.delegate = self;
    _backScroView.pagingEnabled = YES;
    [self.view addSubview:_backScroView];
    
    [self.backScroView addSubview:self.homeView];
    [self.backScroView addSubview:self.infoView];
    [self.backScroView addSubview:self.performanView];
    [self.backScroView addSubview:self.worksView];
    [self.backScroView addSubview:self.articleView];
}

- (void)setTopView{
    _topView = [[MyselfWordTopButtonView alloc]initWithFrame:CGRectMake(0, NavTopHeight, kScreenWidth, 50) btuArr:@[@"主页",@"履历",@"演出",@"作品",@"文章"]];
    __weak typeof(self) mySelf = self;
    _topView.showDiffentView = ^(NSString *title) {
        if ([title isEqualToString:@"主页"]) {
            mySelf.backScroView.contentOffset = CGPointMake(0, 0);
        }else if ([title isEqualToString:@"履历"]){
            mySelf.backScroView.contentOffset = CGPointMake(kScreenWidth, 0);
        }else if ([title isEqualToString:@"演出"]){
            mySelf.backScroView.contentOffset = CGPointMake(kScreenWidth*2, 0);
        }else if ([title isEqualToString:@"作品"]){
            mySelf.backScroView.contentOffset = CGPointMake(kScreenWidth*3, 0);
        }else{
            mySelf.backScroView.contentOffset = CGPointMake(kScreenWidth*4, 0);
        }
    };
    [self.view addSubview:_topView];
}
//MARK:-----------------------------------------homeView-----------------------------------------------
- (MyselfWordHomeView *)homeView{
    if (!_homeView) {
        _homeView = [[MyselfWordHomeView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, ViewHeight(self.backScroView))];
    }
    return _homeView;
}
//MARK:------------------------------------------infoView----------------------------------------------
- (MyselfWordInfoView *)infoView{
    if (!_infoView) {
        _infoView = [[MyselfWordInfoView alloc]initWithFrame:CGRectMake(kScreenWidth,0, kScreenWidth, ViewHeight(self.backScroView))];
    }
    return _infoView;
}
//MARK:-------------------------------------------performanView---------------------------------------------
- (MySelfWordPerformanView *)performanView{
    if (!_performanView) {
        _performanView = [[MySelfWordPerformanView alloc]initWithFrame:CGRectMake(kScreenWidth*2, 0, kScreenWidth, ViewHeight(self.backScroView))];
    }
    return _performanView;
}
//MARK:--------------------------------------------worksView--------------------------------------------
- (MyselfWordWorksView *)worksView{
    if (!_worksView) {
        _worksView = [[MyselfWordWorksView alloc]initWithFrame:CGRectMake(kScreenWidth*3,0, kScreenWidth, ViewHeight(self.backScroView))];
        __weak typeof(self) mySelf = self;
        _worksView.pushUploadingVC = ^{
            [mySelf pushNoTabBarViewController:[[MyselfWordUploadingVC alloc]init] animated:YES];
        };
        _worksView.pushDetaialVIewController = ^{
            [mySelf pushNoTabBarViewController:[[MyselfWorksDetaialVC alloc]init] animated:YES];
        };
    }
    return _worksView;
}
//MARK:--------------------------------------------articlView--------------------------------------------
- (MyselfWordArticleView *)articleView{
    if (!_articleView) {
        _articleView = [[MyselfWordArticleView alloc]initWithFrame:CGRectMake(kScreenWidth*4,0, kScreenWidth, ViewHeight(self.backScroView))];
    }
    return _articleView;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _topView.btu = scrollView.contentOffset.x/kScreenWidth;
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
