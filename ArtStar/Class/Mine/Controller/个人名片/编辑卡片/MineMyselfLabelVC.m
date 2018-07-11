//
//  MineMyselfLabelVC.m
//  ArtStar
//
//  Created by abc on 2018/6/14.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineMyselfLabelVC.h"
#import "MineSelfMyLabelsModel.h"
#import "MineMyselfWordAddLabelVC.h"
#import "MineSelfMyLabelsDetailModel.h"

@interface MineMyselfLabelVC ()

@property (nonatomic,strong) UIScrollView *backScrollView;
@property (nonatomic,strong) UIView *chooseView;
@property (nonatomic,strong) UIView *moviesView;
@property (nonatomic,strong) UIView *literatureView;
@property (nonatomic,strong) UIView *artView;
@property (nonatomic,strong) UIView *designView;
@property (nonatomic,strong) UIView *musicView;
@property (nonatomic,strong) UIView *performanceView;
@property (nonatomic,strong) UIView *customView;

@property (nonatomic,strong) UILabel *countLab;
@property (nonatomic,strong) UIView *line;

@property (nonatomic,strong) NSMutableArray *musicArr;
@property (nonatomic,strong) NSMutableArray *movieArr;
@property (nonatomic,strong) NSMutableArray *artArr;
@property (nonatomic,strong) NSMutableArray *literArr;
@property (nonatomic,strong) NSMutableArray *designArr;
@property (nonatomic,strong) NSMutableArray *perfArr;
@property (nonatomic,strong) NSMutableArray *customArr;
@property (nonatomic,strong) NSMutableArray *chooseArr;

@property (nonatomic,strong) MineSelfMyLabelsModel *model;


@end

@implementation MineMyselfLabelVC

- (void)rightNavBtuAction:(UIButton *)sender{
    NSMutableArray *sendArr = [NSMutableArray array];
    for (NSDictionary *dic in _chooseArr) {
        if ([dic[@"id"] integerValue] != 0) {
            [sendArr addObject:dic];
        }
    }
    if (self.sendChooseArr) {
        self.sendChooseArr(sendArr.copy);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBtuWithFrame:CGRectMake(0, 0, 150, 30) title:@"我的标签" image:Image(@"back")];
    [self setRightBtuWithFrame:CGRectMake(0, 0, 50, 30) title:@"保存" image:nil];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createData];
}
- (void)createData{
    __weak typeof(self) mySelf = self;
    [KGRequestNetWorking postWothUrl:showMyLabels parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode} succ:^(id result) {
        if ([result[@"code"] integerValue] == 200) {
            NSArray *arr = result[@"data"];
            mySelf.model = [MineSelfMyLabelsModel mj_objectWithKeyValues:[arr firstObject]];
            mySelf.movieArr = [NSMutableArray arrayWithArray:mySelf.model.movies];
            mySelf.musicArr = [NSMutableArray arrayWithArray:mySelf.model.music];
            mySelf.artArr = [NSMutableArray arrayWithArray:mySelf.model.art];
            mySelf.literArr = [NSMutableArray arrayWithArray:mySelf.model.literature];
            mySelf.designArr = [NSMutableArray arrayWithArray:mySelf.model.design];
            mySelf.perfArr = [NSMutableArray arrayWithArray:mySelf.model.performance];
            mySelf.customArr = [NSMutableArray arrayWithObject:@{@"name":@"+",@"children":@[],@"id":@"10000",@"path":@"",@"pid":@(0)}];
            mySelf.chooseArr = [NSMutableArray array];
            [mySelf setBackView];
        }
    } fail:^(NSString *error) {
        
    }];
}
//MARK:-------------------------------------创建底部加载视图---------------------------------------------------
- (void)setBackView{
    if (_backScrollView) {
        [_backScrollView removeFromSuperview];
    }
    
    _backScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, NavTopHeight, kScreenWidth, kScreenHeight - NavTopHeight)];
    [self.view addSubview:_backScrollView];
    
    [self setMyLabelView];
    [self setMovies];
    [self setLiterature];
    [self setArt];
    [self setdesign];
    [self setMusic];
    [self setPerform];
    [self setCustom];
}
//MARK:-------------------------------------创建加载已选择标签视图---------------------------------------------------
- (void)setMyLabelView{
    _chooseView = [[UIView alloc]init];
    [_backScrollView addSubview:_chooseView];
    
    _countLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, kScreenWidth - 30, 15)];
    _countLab.text = [NSString stringWithFormat:@"已选择的标签（%lu/5）",(unsigned long)_chooseArr.count];
    _countLab.textColor = Color_333333;
    _countLab.font = SYFont(14);
    [_chooseView addSubview:_countLab];
    
    _chooseView.frame = CGRectMake(0, 0, kScreenWidth, [self setCreateButtonWithArr:_chooseArr addView:_chooseView tag:110 color:[UIColor whiteColor]] + 10);
    
    _line = [[UIView alloc]initWithFrame:CGRectMake(0, ViewHeight(_chooseView) - 10, kScreenWidth, 10)];
    _line.backgroundColor = Color_fafafa;
    [_chooseView addSubview:_line];
    
    _backScrollView.contentSize = CGSizeMake(kScreenWidth, ViewHeight(_chooseView));
}
//MARK:-------------------------------------创建影视选择视图---------------------------------------------------
- (void)setMovies{
    _moviesView = [[UIView alloc]initWithFrame:CGRectMake(0, ViewHeight(_chooseView), kScreenWidth, 170)];
    [_backScrollView addSubview:_moviesView];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, kScreenWidth - 30, 15)];
    titleLab.textColor = Color_333333;
    titleLab.text = @"影视";
    titleLab.font = SYFont(13);
    [_moviesView addSubview:titleLab];

    _moviesView.frame = CGRectMake(0,ViewHeight(_chooseView), kScreenWidth,[self setCreateButtonWithArr:_movieArr addView:_moviesView tag:210 color:Color_333333]);
    
    _backScrollView.contentSize = CGSizeMake(kScreenWidth, ViewHeight(_chooseView) + ViewHeight(_moviesView));
}
//MARK:-------------------------------------创建文学选择视图--------------------------------------------------
- (void)setLiterature{
    _literatureView = [[UIView alloc]initWithFrame:CGRectMake(0, ViewHeight(_chooseView) + ViewHeight(_moviesView), kScreenWidth, 170)];
    [_backScrollView addSubview:_literatureView];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, kScreenWidth - 30, 15)];
    titleLab.textColor = Color_333333;
    titleLab.text = @"文学";
    titleLab.font = SYFont(13);
    [_literatureView addSubview:titleLab];
    
    _literatureView.frame = CGRectMake(0,ViewHeight(_chooseView) + ViewHeight(_moviesView), kScreenWidth,[self setCreateButtonWithArr:_literArr addView:_literatureView tag:310 color:Color_333333]);
    
    _backScrollView.contentSize = CGSizeMake(kScreenWidth, ViewHeight(_chooseView) + ViewHeight(_moviesView) + ViewHeight(_literatureView));
}
//MARK:--------------------------------------创建艺术选择视图--------------------------------------------------
- (void)setArt{
    _artView = [[UIView alloc]initWithFrame:CGRectMake(0, ViewHeight(_chooseView) + ViewHeight(_moviesView) + ViewHeight(_literatureView), kScreenWidth, 170)];
    [_backScrollView addSubview:_artView];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, kScreenWidth - 30, 15)];
    titleLab.textColor = Color_333333;
    titleLab.text = @"美术";
    titleLab.font = SYFont(13);
    [_artView addSubview:titleLab];
    
    _artView.frame = CGRectMake(0, ViewHeight(_chooseView) + ViewHeight(_moviesView) + ViewHeight(_literatureView), kScreenWidth, [self setCreateButtonWithArr:_artArr addView:_artView tag:410 color:Color_333333]);
    
    _backScrollView.contentSize = CGSizeMake(kScreenWidth, ViewHeight(_chooseView) + ViewHeight(_moviesView) + ViewHeight(_literatureView) + ViewHeight(_artView));
}
//MARK:--------------------------------------创建设计选择视图--------------------------------------------------
- (void)setdesign{
    _designView = [[UIView alloc]initWithFrame:CGRectMake(0, ViewHeight(_chooseView) + ViewHeight(_moviesView) + ViewHeight(_literatureView) + ViewHeight(_artView), kScreenWidth, 170)];
    [_backScrollView addSubview:_designView];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, kScreenWidth - 30, 15)];
    titleLab.textColor = Color_333333;
    titleLab.text = @"设计";
    titleLab.font = SYFont(13);
    [_designView addSubview:titleLab];
    
    _designView.frame = CGRectMake(0, ViewHeight(_chooseView) + ViewHeight(_moviesView) + ViewHeight(_literatureView) + ViewHeight(_artView), kScreenWidth, [self setCreateButtonWithArr:_designArr addView:_designView tag:510 color:Color_333333]);
    
    _backScrollView.contentSize = CGSizeMake(kScreenWidth, ViewHeight(_chooseView) + ViewHeight(_moviesView) + ViewHeight(_literatureView) + ViewHeight(_artView) + ViewHeight(_designView));
}
//MARK:--------------------------------------创建选择音乐视图--------------------------------------------------
- (void)setMusic{
    _musicView = [[UIView alloc]initWithFrame:CGRectMake(0, ViewHeight(_chooseView) + ViewHeight(_moviesView) + ViewHeight(_literatureView) + ViewHeight(_artView) + ViewHeight(_designView), kScreenWidth, 170)];
    [_backScrollView addSubview:_musicView];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, kScreenWidth - 30, 15)];
    titleLab.textColor = Color_333333;
    titleLab.text = @"音乐";
    titleLab.font = SYFont(13);
    [_musicView addSubview:titleLab];
    
    _musicView.frame = CGRectMake(0, ViewHeight(_chooseView) + ViewHeight(_moviesView) + ViewHeight(_literatureView) + ViewHeight(_artView) + ViewHeight(_designView), kScreenWidth, [self setCreateButtonWithArr:_musicArr addView:_musicView tag:610 color:Color_333333]);
    
    _backScrollView.contentSize = CGSizeMake(kScreenWidth, ViewHeight(_chooseView) + ViewHeight(_moviesView) + ViewHeight(_literatureView) + ViewHeight(_artView) + ViewHeight(_designView) + ViewHeight(_musicView));
}
//MARK:---------------------------------------创建选择表演视图-------------------------------------------------
- (void)setPerform{
    _performanceView = [[UIView alloc]initWithFrame:CGRectMake(0, ViewHeight(_chooseView) + ViewHeight(_moviesView) + ViewHeight(_literatureView) + ViewHeight(_artView) + ViewHeight(_designView) + ViewHeight(_musicView), kScreenWidth, 170)];
    [_backScrollView addSubview:_performanceView];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, kScreenWidth - 30, 15)];
    titleLab.textColor = Color_333333;
    titleLab.text = @"表演";
    titleLab.font = SYFont(13);
    [_performanceView addSubview:titleLab];
    
    _performanceView.frame = CGRectMake(0, ViewHeight(_chooseView) + ViewHeight(_moviesView) + ViewHeight(_literatureView) + ViewHeight(_artView) + ViewHeight(_designView) + ViewHeight(_musicView), kScreenWidth, [self setCreateButtonWithArr:_perfArr addView:_performanceView tag:710 color:Color_333333]);
    [_backScrollView addSubview:_performanceView];
    
    _backScrollView.contentSize = CGSizeMake(kScreenWidth, ViewHeight(_chooseView) + ViewHeight(_moviesView) + ViewHeight(_literatureView) + ViewHeight(_artView) + ViewHeight(_designView) + ViewHeight(_musicView) + ViewHeight(_performanceView));
}
//MARK:---------------------------------------创建自定义标签视图-------------------------------------------------
- (void)setCustom{
    _customView = [[UIView alloc]initWithFrame:CGRectMake(0, ViewHeight(_chooseView) + ViewHeight(_moviesView) + ViewHeight(_literatureView) + ViewHeight(_artView) + ViewHeight(_designView) + ViewHeight(_musicView) + ViewHeight(_performanceView), kScreenWidth, 170)];
    [_backScrollView addSubview:_customView];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, kScreenWidth - 30, 15)];
    titleLab.textColor = Color_333333;
    titleLab.text = @"自定义";
    titleLab.font = SYFont(13);
    [_customView addSubview:titleLab];
    
    _customView.frame = CGRectMake(0, ViewHeight(_chooseView) + ViewHeight(_moviesView) + ViewHeight(_literatureView) + ViewHeight(_artView) + ViewHeight(_designView) + ViewHeight(_musicView) + ViewHeight(_performanceView), kScreenWidth, [self setCreateButtonWithArr:_customArr addView:_customView tag:810 color:Color_333333]);
    
    _backScrollView.contentSize = CGSizeMake(kScreenWidth, ViewHeight(_chooseView) + ViewHeight(_moviesView) + ViewHeight(_literatureView) + ViewHeight(_artView) + ViewHeight(_designView) + ViewHeight(_musicView) + ViewHeight(_performanceView) + ViewHeight(_customView));
}
//MARK:----------------------------------------创建公共按钮方法------------------------------------------------
- (UIButton *)createButtonframe:(CGRect)frame title:(NSString *)title tag:(NSInteger)tag color:(UIColor *)color{
    UIButton *norBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    norBtu.frame = frame;
    norBtu.tag = tag;
    [norBtu setTitle:title forState:UIControlStateNormal];
    [norBtu setTitleColor:color forState:UIControlStateNormal];
    if ([self firstColor:color secondColor:Color_333333] == NO) {
        norBtu.backgroundColor = Color_333333;
    }
    for (NSDictionary *dic in _chooseArr) {
        if ([dic[@"name"] isEqualToString:title] && [dic[@"id"] integerValue] == tag) {
            norBtu.backgroundColor = Color_333333;
            [norBtu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
    }
    norBtu.titleLabel.font = SYFont(12);
    [norBtu addTarget:self action:@selector(buttonTouchUpInSide:) forControlEvents:UIControlEventTouchUpInside];
    norBtu.layer.cornerRadius = 10;
    norBtu.layer.borderColor = [UIColor colorWithHexString:@"#4d4d4d"].CGColor;
    norBtu.layer.borderWidth = 1;
    norBtu.layer.masksToBounds = YES;
    return norBtu;
}
//MARK:---------------------------------------------公共按钮点击事件-------------------------------------------
- (void)buttonTouchUpInSide:(UIButton *)sender{
    if ([sender.currentTitle isEqualToString:@"+"]) {
        MineMyselfWordAddLabelVC *vc = [[MineMyselfWordAddLabelVC alloc]init];
        vc.titleStr = @"标签";
        __weak typeof(self) mySelf = self;
        vc.sendLabelToViewController = ^(NSString *labStr) {
            [mySelf.customArr addObject:@{@"name":labStr,@"id":@(0)}];
            [mySelf setBackView];
        };
        [self pushNoTabBarViewController:vc animated:YES];
    }else{
        if ([self firstColor:sender.currentTitleColor secondColor:Color_333333]) {
            if (_chooseArr.count < 5) {
                [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                sender.backgroundColor = Color_333333;
                NSDictionary *dic = @{@"name":sender.currentTitle,@"id":@(sender.tag)};
                [_chooseArr addObject:dic];
            }else{
                [[MBProgressHUD bwm_showHUDAddedTo:self.view title:@"最多只能选择五个标签"] hide:YES afterDelay:1];
            }
        }else{
            [sender setTitleColor:Color_333333 forState:UIControlStateNormal];
            sender.backgroundColor = [UIColor whiteColor];
            NSDictionary *dic = @{@"name":sender.currentTitle,@"id":@(sender.tag)};
            [_chooseArr removeObject:dic];
        }
        [self setBackView];
    }
}
//MARK:---------------------------------------------循环创建按钮-------------------------------------------
- (CGFloat)setCreateButtonWithArr:(NSMutableArray *)arr addView:(UIView *)addView tag:(NSInteger)tag color:(UIColor *)color{
    
    CGFloat width = 15;
    CGFloat height = 45;
    for (int i = 0; i < arr.count; i++) {
        NSDictionary *dic = arr[i];
        if (width + [TransformChineseToPinying stringWidthFromString:dic[@"name"] font:SYFont(12) width:kScreenWidth] + 30 > kScreenWidth) {
            width = 15;
            height = height + 30;
        }
        [addView addSubview:[self createButtonframe:CGRectMake(width,height,[TransformChineseToPinying stringWidthFromString:dic[@"name"] font:SYFont(12) width:kScreenWidth] + 15,20) title:dic[@"name"] tag:[dic[@"id"] integerValue] color:color]];
        
        width = width + [TransformChineseToPinying stringWidthFromString:dic[@"name"] font:SYFont(12) width:kScreenWidth] + 35;
    }
    return height + 35;
}
//MARK:-----------------------------------------判断两个颜色是否相同-----------------------------------------------
- (BOOL)firstColor:(UIColor *)firstColor secondColor:(UIColor *)secondColor{
    if (CGColorEqualToColor(firstColor.CGColor, secondColor.CGColor)) {
        return YES;
    }else{
        return NO;
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
