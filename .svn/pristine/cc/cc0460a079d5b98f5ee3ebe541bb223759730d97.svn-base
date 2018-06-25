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

@interface MyselfWordVC ()

@property (nonatomic,strong) MyselfWordHomeView *homeView;
@property (nonatomic,strong) MyselfWordInfoView *infoView;
@property (nonatomic,strong) MySelfWordPerformanView *performanView;
@property (nonatomic,strong) MyselfWordWorksView *worksView;
@property (nonatomic,strong) MyselfWordArticleView *articleView;

@end

@implementation MyselfWordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLeftBtuWithTitle:@"姚新月" image:Image(@"back")];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setTopView];
    
}

- (void)setTopView{
    MyselfWordTopButtonView *topView = [[MyselfWordTopButtonView alloc]initWithFrame:CGRectMake(0, NavTopHeight, kScreenWidth, 50) btuArr:@[@"主页",@"履历",@"演出",@"作品",@"文章"]];
    __weak typeof(self) mySelf = self;
    topView.showDiffentView = ^(NSString *title) {
        if ([title isEqualToString:@"主页"]) {
            [mySelf.view bringSubviewToFront:mySelf.homeView];
        }else if ([title isEqualToString:@"履历"]){
            [mySelf.view bringSubviewToFront:mySelf.infoView];
        }else if ([title isEqualToString:@"演出"]){
            [mySelf.view bringSubviewToFront:mySelf.performanView];
        }else if ([title isEqualToString:@"作品"]){
            [mySelf.view bringSubviewToFront:mySelf.worksView];
        }else{
            [mySelf.view bringSubviewToFront:mySelf.articleView];
        }
    };
    [self.view addSubview:topView];
    self.homeView.hidden = NO;
}
//MARK:-----------------------------------------homeView-----------------------------------------------
- (MyselfWordHomeView *)homeView{
    if (!_homeView) {
        _homeView = [[MyselfWordHomeView alloc]initWithFrame:CGRectMake(0, NavTopHeight + 50, kScreenWidth, kScreenHeight - NavTopHeight - 50)];
        [self.view addSubview:_homeView];
    }
    return _homeView;
}
//MARK:------------------------------------------infoView----------------------------------------------
- (MyselfWordInfoView *)infoView{
    if (!_infoView) {
        _infoView = [[MyselfWordInfoView alloc]initWithFrame:CGRectMake(0, NavTopHeight + 50, kScreenWidth, kScreenHeight - NavTopHeight - 50)];
        [self.view addSubview:_infoView];
    }
    return _infoView;
}
//MARK:-------------------------------------------performanView---------------------------------------------
- (MySelfWordPerformanView *)performanView{
    if (!_performanView) {
        _performanView = [[MySelfWordPerformanView alloc]initWithFrame:CGRectMake(0, NavTopHeight + 50, kScreenWidth, kScreenHeight - NavTopHeight - 50)];
        [self.view addSubview:_performanView];
    }
    return _performanView;
}
//MARK:--------------------------------------------worksView--------------------------------------------
- (MyselfWordWorksView *)worksView{
    if (!_worksView) {
        _worksView = [[MyselfWordWorksView alloc]initWithFrame:CGRectMake(0, NavTopHeight + 50, kScreenWidth, kScreenHeight - NavTopHeight - 50)];
        __weak typeof(self) mySelf = self;
        _worksView.pushUploadingVC = ^{
            [mySelf pushNoTabBarViewController:[[MyselfWordUploadingVC alloc]init] animated:YES];
        };
        [self.view addSubview:_worksView];
    }
    return _worksView;
}
//MARK:--------------------------------------------articlView--------------------------------------------
- (MyselfWordArticleView *)articleView{
    if (!_articleView) {
        _articleView = [[MyselfWordArticleView alloc]initWithFrame:CGRectMake(0, NavTopHeight + 50, kScreenWidth, kScreenHeight - NavTopHeight - 50)];
        [self.view addSubview:_articleView];
    }
    return _articleView;
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
