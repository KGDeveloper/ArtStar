//
//  MineCollentionVC.m
//  ArtStar
//
//  Created by abc on 2018/6/14.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineCollentionVC.h"
#import "MineCollectionHeaderScrollView.h"
#import "MineCollectionInstitutionView.h"
#import "MineCollectionThemeView.h"
#import "MineCollectionExhibitionView.h"
#import "MineCollectionStarcircleView.h"
#import "MineControllerArticleView.h"
#import "MineCollectionBookView.h"

@interface MineCollentionVC ()

@property (nonatomic,strong) MineCollectionInstitutionView *institutionView;
@property (nonatomic,strong) MineCollectionThemeView *themeView;
@property (nonatomic,strong) MineCollectionExhibitionView *exhibitionView;
@property (nonatomic,strong) MineCollectionStarcircleView *starCircleView;
@property (nonatomic,strong) MineControllerArticleView *articleView;
@property (nonatomic,strong) MineCollectionBookView *bookView;

@end

@implementation MineCollentionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBtuWithFrame:CGRectMake(0, 0, 150, 30) title:@"收藏" image:Image(@"back")];
    [self setRightBtuWithFrame:CGRectMake(0, 0, 50, 30) title:nil image:Image(@"搜索")];
    self.view.backgroundColor = [UIColor whiteColor];
    
    MineCollectionHeaderScrollView *topScrollView = [[MineCollectionHeaderScrollView alloc]initWithFrame:CGRectMake(0, NavTopHeight, kScreenWidth, 50)];
    topScrollView.btuArr = @[@"机构",@"展览",@"星圈",@"话题",@"文章",@"图书"];
    __weak typeof(self) mySelf = self;
    topScrollView.touchBtuShowDiffentView = ^(NSString *title) {
        if ([title isEqualToString:@"机构"]) {
            [mySelf.view bringSubviewToFront:mySelf.institutionView];
        }else if ([title isEqualToString:@"展览"]){
            [mySelf.view bringSubviewToFront:mySelf.exhibitionView];
        }else if ([title isEqualToString:@"星圈"]){
            [mySelf.view bringSubviewToFront:mySelf.starCircleView];
        }else if ([title isEqualToString:@"话题"]){
            [mySelf.view bringSubviewToFront:mySelf.themeView];
        }else if ([title isEqualToString:@"文章"]){
            [mySelf.view bringSubviewToFront:mySelf.articleView];
        }else{
            [mySelf.view bringSubviewToFront:mySelf.bookView];
        }
    };
    [self.view addSubview:topScrollView];
    
    self.institutionView.hidden = NO;
    
}
// MARK: --机构--
- (MineCollectionInstitutionView *)institutionView{
    if (!_institutionView) {
        _institutionView = [[MineCollectionInstitutionView alloc]initWithFrame:CGRectMake(0, NavTopHeight + 50, kScreenWidth,kScreenHeight - NavTopHeight - 50)];
        [self.view addSubview:_institutionView];
    }
    return _institutionView;
}
// MARK: --话题--
- (MineCollectionThemeView *)themeView{
    if (!_themeView) {
        _themeView = [[MineCollectionThemeView alloc]initWithFrame:CGRectMake(0, NavTopHeight + 50, kScreenWidth,kScreenHeight - NavTopHeight - 50)];
        [self.view addSubview:_themeView];
    }
    return _themeView;
}
// MARK: --展览--
- (MineCollectionExhibitionView *)exhibitionView{
    if (!_exhibitionView) {
        _exhibitionView = [[MineCollectionExhibitionView alloc]initWithFrame:CGRectMake(0, NavTopHeight + 50, kScreenWidth,kScreenHeight - NavTopHeight - 50)];
        [self.view addSubview:_exhibitionView];
    }
    return _exhibitionView;
}
// MARK: --星圈--
- (MineCollectionStarcircleView *)starCircleView{
    if (!_starCircleView) {
        _starCircleView = [[MineCollectionStarcircleView alloc]initWithFrame:CGRectMake(0, NavTopHeight + 50, kScreenWidth,kScreenHeight - NavTopHeight - 50)];
        [self.view addSubview:_starCircleView];
    }
    return _starCircleView;
}
// MARK: --文章--
- (MineControllerArticleView *)articleView{
    if (!_articleView) {
        _articleView = [[MineControllerArticleView alloc]initWithFrame:CGRectMake(0, NavTopHeight + 50, kScreenWidth,kScreenHeight - NavTopHeight - 50)];
        [self.view addSubview:_articleView];
    }
    return _articleView;
}
// MARK: --图书--
- (MineCollectionBookView *)bookView{
    if (!_bookView) {
        _bookView = [[MineCollectionBookView alloc]initWithFrame:CGRectMake(0, NavTopHeight + 50, kScreenWidth,kScreenHeight - NavTopHeight - 50)];
        [self.view addSubview:_bookView];
    }
    return _bookView;
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
