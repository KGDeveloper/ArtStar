//
//  MineMySelfWordVC.m
//  ArtStar
//
//  Created by abc on 2018/6/13.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineMySelfWordVC.h"
#import "MineMyselfWordAddLabelVC.h"
#import "MineMyWordsModel.h"

@interface MineMySelfWordVC ()

@property (nonatomic,strong) UIScrollView *backScrollView;
@property (nonatomic,strong) UIView *foodView;
@property (nonatomic,strong) UIView *sportView;
@property (nonatomic,strong) UIView *leisureView;
@property (nonatomic,strong) UIView *footprintView;
//MARK:-----------------------------------用户刚选择的-----------------------------------------------------
@property (nonatomic,strong) NSMutableArray *chooseFood;
@property (nonatomic,strong) NSMutableArray *chooseSport;
@property (nonatomic,strong) NSMutableArray *chooseLeisure;
@property (nonatomic,strong) NSMutableArray *chooseFootprint;
//MARK:-------------------------------------提供选择---------------------------------------------------
@property (nonatomic,copy) NSArray *foodArr;
@property (nonatomic,copy) NSArray *sportArr;
@property (nonatomic,copy) NSArray *leisureArr;
@property (nonatomic,copy) NSArray *footprintArr;
//MARK:------------------------------------请求下来已经选择的----------------------------------------------------
@property (nonatomic,strong) NSMutableArray *oldfoodArr;
@property (nonatomic,strong) NSMutableArray *oldsportArr;
@property (nonatomic,strong) NSMutableArray *oldleisureArr;
@property (nonatomic,strong) NSMutableArray *oldfootprintArr;

@end

@implementation MineMySelfWordVC

- (void)rightNavBtuAction:(UIButton *)sender{
    if (self.sendChooseWords) {
        self.sendChooseWords(_chooseFood.copy, _chooseSport.copy, _chooseLeisure.copy, _chooseFootprint.copy);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBtuWithFrame:CGRectMake(0, 0, 150, 30) title:@"我的世界" image:Image(@"back")];
    [self setRightBtuWithFrame:CGRectMake(0, 0, 50, 30) title:@"保存" image:nil];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createOldData];
    [self create];
}

- (void)createOldData{
    __weak typeof(self) mySelf = self;
    mySelf.oldsportArr = [NSMutableArray array];
    mySelf.oldleisureArr = [NSMutableArray array];
    mySelf.oldfoodArr = [NSMutableArray array];
    mySelf.oldfootprintArr = [NSMutableArray array];
    [_myWords enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dic = obj;
        if ([dic[@"pid"] integerValue] == 4) {
            [mySelf.oldfoodArr addObject:dic];
        }else if ([dic[@"pid"] integerValue] == 5){
            [mySelf.oldsportArr addObject:dic];
        }else if ([dic[@"pid"] integerValue] == 6){
            [mySelf.oldleisureArr addObject:dic];
        }else if ([dic[@"pid"] integerValue] == 7){
            [mySelf.oldfootprintArr addObject:dic];
        }
    }];
}

- (void)create{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak typeof(self) mySelf = self;
    [KGRequestNetWorking postWothUrl:getMyWordByPid parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"id":@"0"} succ:^(id result) {
        if ([result[@"code"] integerValue] == 200) {
            NSArray *arr = result[@"data"];
            NSDictionary *dic = [arr firstObject];
            mySelf.foodArr = [MineMyWordsModel mj_objectArrayWithKeyValuesArray:dic[@"favoriteFood"]];
            mySelf.sportArr = [MineMyWordsModel mj_objectArrayWithKeyValuesArray:dic[@"favoriteSports"]];
            mySelf.leisureArr = [MineMyWordsModel mj_objectArrayWithKeyValuesArray:dic[@"favoriteWayLeisure"]];
            mySelf.footprintArr = [MineMyWordsModel mj_objectArrayWithKeyValuesArray:dic[@"footprint"]];
        }
        [MBProgressHUD hideHUDForView:mySelf.view animated:YES];
        [mySelf setViewAndBackView];
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUDForView:mySelf.view animated:YES];
    }];
}

- (void)setViewAndBackView{
    
    _backScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, NavTopHeight, kScreenWidth, kScreenHeight - NavTopHeight)];
    [self.view addSubview:_backScrollView];
    
    _chooseFood = [NSMutableArray array];
    _chooseSport = [NSMutableArray array];
    _chooseLeisure = [NSMutableArray array];
    _chooseFootprint = [NSMutableArray array];
    
    [self setFood];
    [self setSport];
    [self setLeisure];
    [self setFootprint];
    
}

- (void)setFood{
    _foodView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 170)];
    [_backScrollView addSubview:_foodView];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, ViewHeight(_foodView) - 30, 15)];
    titleLab.text = @"美食";
    titleLab.textColor = Color_333333;
    titleLab.font = SYFont(13);
    [_foodView addSubview:titleLab];
    
    CGFloat width = 15;
    CGFloat height = 50;
    for (int i = 0; i <= _foodArr.count; i++) {
        if (i == _foodArr.count) {
            if (width + 90 > kScreenWidth) {
                width = 15;
                height = height + 30;
                [_foodView addSubview:[self createButtonframe:CGRectMake(width,height,75,20) title:@"+" tag:150 + i titleColor:[UIColor colorWithHexString:@"#4d4d4d"] backColor:[UIColor whiteColor]]];
            }
        }else{
            __block MineMyWordsModel *model = _foodArr[i];
            __block UIColor *titleColor = [UIColor colorWithHexString:@"#4d4d4d"];
            __block UIColor *backColor = [UIColor whiteColor];
            [_oldfoodArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSDictionary *dic = obj;
                MineMyWordsModel *tmpModel = [MineMyWordsModel mj_objectWithKeyValues:dic];
                if ([tmpModel.name isEqualToString:model.name] && [tmpModel.ID isEqual:model.ID]) {
                    titleColor = [UIColor whiteColor];
                    backColor = [UIColor colorWithHexString:@"#4d4d4d"];
                    *stop = YES;
                }
            }];
            if (width + [TransformChineseToPinying stringWidthFromString:model.name font:SYFont(12) width:kScreenWidth - 30] + 30 > kScreenWidth) {
                width = 15;
                height = height + 30;
            }
            [_foodView addSubview:[self createButtonframe:CGRectMake(width,height,[TransformChineseToPinying stringWidthFromString:model.name font:SYFont(12) width:kScreenWidth] + 15,20) title:model.name tag:model.ID.integerValue titleColor:titleColor backColor:backColor]];
            
            width = width + [TransformChineseToPinying stringWidthFromString:model.name font:SYFont(12) width:kScreenWidth] + 35;
        }
    }
    
    _foodView.frame = CGRectMake(0, 0, kScreenWidth, height + 20);//130
    _backScrollView.contentSize = CGSizeMake(kScreenWidth,ViewHeight(_foodView) + ViewHeight(_sportView) + ViewHeight(_leisureView) + ViewHeight(_footprintView));
}

- (void)setSport{
    _sportView = [[UIView alloc]initWithFrame:CGRectMake(0,ViewHeight(_foodView), kScreenWidth, 170)];
    [_backScrollView addSubview:_sportView];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, ViewHeight(_sportView) - 30, 15)];
    titleLab.text = @"运动";
    titleLab.textColor = Color_333333;
    titleLab.font = SYFont(13);
    [_sportView addSubview:titleLab];
    
    CGFloat width = 15;
    CGFloat height = 50;
    for (int i = 0; i <= _sportArr.count; i++) {
        if (i == _sportArr.count) {
            if (width + 90 > kScreenWidth) {
                width = 15;
                height = height + 30;
                [_sportView addSubview:[self createButtonframe:CGRectMake(width,height,75,20) title:@"+" tag:250 + i titleColor:[UIColor colorWithHexString:@"#4d4d4d"] backColor:[UIColor whiteColor]]];
            }
        }else{
            __block MineMyWordsModel *model = _sportArr[i];
            __block UIColor *titleColor = [UIColor colorWithHexString:@"#4d4d4d"];
            __block UIColor *backColor = [UIColor whiteColor];
            [_oldsportArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSDictionary *dic = obj;
                MineMyWordsModel *tmpModel = [MineMyWordsModel mj_objectWithKeyValues:dic];
                if ([tmpModel.name isEqualToString:model.name] && [tmpModel.ID isEqual:model.ID]) {
                    titleColor = [UIColor whiteColor];
                    backColor = [UIColor colorWithHexString:@"#4d4d4d"];
                    *stop = YES;
                }
            }];
            if (width + [TransformChineseToPinying stringWidthFromString:model.name font:SYFont(12) width:kScreenWidth] + 30 > kScreenWidth) {
                width = 15;
                height = height + 30;
            }
            [_sportView addSubview:[self createButtonframe:CGRectMake(width,height,[TransformChineseToPinying stringWidthFromString:model.name font:SYFont(12) width:kScreenWidth] + 15,20) title:model.name tag:model.ID.integerValue titleColor:titleColor backColor:backColor]];
            
            width = width + [TransformChineseToPinying stringWidthFromString:model.name font:SYFont(12) width:kScreenWidth] + 35;
        }
    }
    _sportView.frame = CGRectMake(0,ViewHeight(_foodView), kScreenWidth, height + 20);//220
    _backScrollView.contentSize = CGSizeMake(kScreenWidth,ViewHeight(_foodView) + ViewHeight(_sportView) + ViewHeight(_leisureView) + ViewHeight(_footprintView));
}

- (void)setLeisure{
    _leisureView = [[UIView alloc]initWithFrame:CGRectMake(0,ViewHeight(_foodView) + ViewHeight(_sportView), kScreenWidth, 170)];
    [_backScrollView addSubview:_leisureView];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, ViewHeight(_leisureView) - 30, 15)];
    titleLab.text = @"休闲方式";
    titleLab.textColor = Color_333333;
    titleLab.font = SYFont(13);
    [_leisureView addSubview:titleLab];
    
    CGFloat width = 15;
    CGFloat height = 50;
    for (int i = 0; i <= _leisureArr.count; i++) {
        if (i == _leisureArr.count) {
            if (width + 90 > kScreenWidth) {
                width = 15;
                height = height + 30;
                [_leisureView addSubview:[self createButtonframe:CGRectMake(width,height,75,20) title:@"+" tag:350 + i titleColor:[UIColor colorWithHexString:@"#4d4d4d"] backColor:[UIColor whiteColor]]];
            }
        }else{
            __block MineMyWordsModel *model = _leisureArr[i];
            __block UIColor *titleColor = [UIColor colorWithHexString:@"#4d4d4d"];
            __block UIColor *backColor = [UIColor whiteColor];
            [_oldleisureArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSDictionary *dic = obj;
                MineMyWordsModel *tmpModel = [MineMyWordsModel mj_objectWithKeyValues:dic];
                if ([tmpModel.name isEqualToString:model.name] && [tmpModel.ID isEqual:model.ID]) {
                    titleColor = [UIColor whiteColor];
                    backColor = [UIColor colorWithHexString:@"#4d4d4d"];
                    *stop = YES;
                }
            }];
            if (width + [TransformChineseToPinying stringWidthFromString:model.name font:SYFont(12) width:kScreenWidth] + 30 > kScreenWidth) {
                width = 15;
                height = height + 30;
            }
            [_leisureView addSubview:[self createButtonframe:CGRectMake(width,height,[TransformChineseToPinying stringWidthFromString:model.name font:SYFont(12) width:kScreenWidth] + 15,20) title:model.name tag:model.ID.integerValue titleColor:titleColor backColor:backColor]];
            
            width = width + [TransformChineseToPinying stringWidthFromString:model.name font:SYFont(12) width:kScreenWidth] + 35;
        }
    }
    _leisureView.frame = CGRectMake(0,ViewHeight(_foodView) + ViewHeight(_sportView), kScreenWidth, height + 20);//520
    _backScrollView.contentSize = CGSizeMake(kScreenWidth,ViewHeight(_foodView) + ViewHeight(_sportView) + ViewHeight(_leisureView) + ViewHeight(_footprintView));
}

- (void)setFootprint{
    _footprintView = [[UIView alloc]initWithFrame:CGRectMake(0,ViewHeight(_foodView) + ViewHeight(_sportView) + ViewHeight(_leisureView), kScreenWidth, 170)];
    [_backScrollView addSubview:_footprintView];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, ViewHeight(_footprintView) - 30, 15)];
    titleLab.text = @"足迹";
    titleLab.textColor = Color_333333;
    titleLab.font = SYFont(13);
    [_footprintView addSubview:titleLab];
    
    CGFloat width = 15;
    CGFloat height = 50;
    for (int i = 0; i < _footprintArr.count; i++) {
        if (i == _footprintArr.count) {
            if (width + 90 > kScreenWidth) {
                width = 15;
                height = height + 30;
                [_footprintView addSubview:[self createButtonframe:CGRectMake(width,height,75,20) title:@"+" tag:0 titleColor:[UIColor colorWithHexString:@"#4d4d4d"] backColor:[UIColor whiteColor]]];
            }
        }else{
            __block MineMyWordsModel *model = _footprintArr[i];
            __block UIColor *titleColor = [UIColor colorWithHexString:@"#4d4d4d"];
            __block UIColor *backColor = [UIColor whiteColor];
            [_oldfootprintArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSDictionary *dic = obj;
                MineMyWordsModel *tmpModel = [MineMyWordsModel mj_objectWithKeyValues:dic];
                if ([tmpModel.name isEqualToString:model.name] && [tmpModel.ID isEqual:model.ID]) {
                    titleColor = [UIColor whiteColor];
                    backColor = [UIColor colorWithHexString:@"#4d4d4d"];
                    *stop = YES;
                }
            }];
            if (width + [TransformChineseToPinying stringWidthFromString:model.name font:SYFont(12) width:kScreenWidth] + 30 > kScreenWidth) {
                width = 15;
                height = height + 30;
            }
            [_footprintView addSubview:[self createButtonframe:CGRectMake(width,height,[TransformChineseToPinying stringWidthFromString:model.name font:SYFont(12) width:kScreenWidth] + 15,20) title:model.name tag:model.ID.integerValue titleColor:titleColor backColor:backColor]];
            
            width = width + [TransformChineseToPinying stringWidthFromString:model.name font:SYFont(12) width:kScreenWidth] + 35;
        }
    }
    _footprintView.frame = CGRectMake(0,ViewHeight(_foodView) + ViewHeight(_sportView) + ViewHeight(_leisureView), kScreenWidth, height + 20);//320
    _backScrollView.contentSize = CGSizeMake(kScreenWidth,ViewHeight(_foodView) + ViewHeight(_sportView) + ViewHeight(_leisureView) + ViewHeight(_footprintView));
}

- (UIButton *)createButtonframe:(CGRect)frame title:(NSString *)title tag:(NSInteger)tag titleColor:(UIColor *)titleColor backColor:(UIColor *)backColor{
    UIButton *norBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    norBtu.frame = frame;
    norBtu.tag = tag;
    norBtu.backgroundColor = backColor;
    [norBtu setTitle:title forState:UIControlStateNormal];
    [norBtu setTitleColor:titleColor forState:UIControlStateNormal];
    norBtu.titleLabel.font = SYFont(12);
    [norBtu addTarget:self action:@selector(buttonTouchUpInSide:) forControlEvents:UIControlEventTouchUpInside];
    norBtu.layer.cornerRadius = 10;
    norBtu.layer.borderColor = [UIColor colorWithHexString:@"#4d4d4d"].CGColor;
    norBtu.layer.borderWidth = 1;
    norBtu.layer.masksToBounds = YES;
    return norBtu;
}

- (void)buttonTouchUpInSide:(UIButton *)sender{
    if ([sender.currentTitle isEqualToString:@"+"]) {
        if (sender.tag >= 150 && sender.tag < 250) {
            MineMyselfWordAddLabelVC *addfood = [[MineMyselfWordAddLabelVC alloc]init];
            addfood.titleStr = @"美食";
            [self pushNoTabBarViewController:addfood animated:YES];
        }else if (sender.tag >= 250 && sender.tag < 350){
            MineMyselfWordAddLabelVC *addfood = [[MineMyselfWordAddLabelVC alloc]init];
            addfood.titleStr = @"运动";
            [self pushNoTabBarViewController:addfood animated:YES];
        }else if (sender.tag >= 350 && sender.tag < 450){
            MineMyselfWordAddLabelVC *addfood = [[MineMyselfWordAddLabelVC alloc]init];
            addfood.titleStr = @"休闲方式";
            [self pushNoTabBarViewController:addfood animated:YES];
        }else{
            MineMyselfWordAddLabelVC *addfood = [[MineMyselfWordAddLabelVC alloc]init];
            addfood.titleStr = @"足迹";
            [self pushNoTabBarViewController:addfood animated:YES];
        }
    }else{
        if ([self firstColor:sender.currentTitleColor secondColor:[UIColor whiteColor]] == YES) {
            if (sender.superview == _foodView) {
                NSDictionary *dic = @{@"name":sender.currentTitle,@"id":@(sender.tag)};
                [self removeTitleFromChooseArrayTitle:dic arr:_chooseFood];
                [self removeTitleFromArrayTitle:dic arr:_oldfoodArr];
            }else if (sender.superview == _sportView){
                NSDictionary *dic = @{@"name":sender.currentTitle,@"id":@(sender.tag)};
                [self removeTitleFromChooseArrayTitle:dic arr:_chooseSport];
                [self removeTitleFromArrayTitle:dic arr:_oldsportArr];
            }else if (sender.superview == _leisureView){
                NSDictionary *dic = @{@"name":sender.currentTitle,@"id":@(sender.tag)};
                [self removeTitleFromChooseArrayTitle:dic arr:_chooseLeisure];
                [self removeTitleFromArrayTitle:dic arr:_oldleisureArr];
            }else if (sender.superview == _footprintView){
                NSDictionary *dic = @{@"name":sender.currentTitle,@"id":@(sender.tag)};
                [self removeTitleFromChooseArrayTitle:dic arr:_chooseFootprint];
                [self removeTitleFromArrayTitle:dic arr:_oldfootprintArr];
            }
            [sender setTitleColor:[UIColor colorWithHexString:@"#4d4d4d"] forState:UIControlStateNormal];
            sender.backgroundColor = [UIColor whiteColor];
        }else{
            if (sender.superview == _foodView) {
                NSDictionary *dic = @{@"name":sender.currentTitle,@"id":@(sender.tag)};
                if ([self arrayCountWithTitle:dic arr:_oldfoodArr] >= 5) {
                    [[MBProgressHUD showHUDAddedTo:self.view animated:YES] bwm_hideWithTitle:@"最多只能选择该类下的五个标签" hideAfter:2];
                }else{
                    [_chooseFood addObject:dic];
                    [_oldfoodArr addObject:dic];
                    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    sender.backgroundColor = [UIColor colorWithHexString:@"#4d4d4d"];
                }
            }else if (sender.superview == _sportView){
                NSDictionary *dic = @{@"name":sender.currentTitle,@"id":@(sender.tag)};
                if ([self arrayCountWithTitle:dic arr:_oldsportArr] >= 5) {
                    [[MBProgressHUD showHUDAddedTo:self.view animated:YES] bwm_hideWithTitle:@"最多只能选择该类下的五个标签" hideAfter:2];
                }else{
                    [_chooseSport addObject:dic];
                    [_oldsportArr addObject:dic];
                    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    sender.backgroundColor = [UIColor colorWithHexString:@"#4d4d4d"];
                }
            }else if (sender.superview == _leisureView){
                NSDictionary *dic = @{@"name":sender.currentTitle,@"id":@(sender.tag)};
                if ([self arrayCountWithTitle:dic arr:_oldleisureArr] >= 5) {
                    [[MBProgressHUD showHUDAddedTo:self.view animated:YES] bwm_hideWithTitle:@"最多只能选择该类下的五个标签" hideAfter:2];
                }else{
                    [_chooseLeisure addObject:dic];
                    [_oldleisureArr addObject:dic];
                    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    sender.backgroundColor = [UIColor colorWithHexString:@"#4d4d4d"];
                }
            }else if (sender.superview == _footprintView){
                NSDictionary *dic = @{@"name":sender.currentTitle,@"id":@(sender.tag)};
                if ([self arrayCountWithTitle:dic arr:_oldfootprintArr] >= 5) {
                    [[MBProgressHUD showHUDAddedTo:self.view animated:YES] bwm_hideWithTitle:@"最多只能选择该类下的五个标签" hideAfter:2];
                }else{
                    [_chooseFootprint addObject:dic];
                    [_oldfootprintArr addObject:dic];
                    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    sender.backgroundColor = [UIColor colorWithHexString:@"#4d4d4d"];
                }
            }
        }
    }
}

- (NSInteger)arrayCountWithTitle:(NSDictionary *)dic arr:(NSMutableArray *)arr{
    return arr.count;
}
- (void)removeTitleFromChooseArrayTitle:(NSDictionary *)dic arr:(NSMutableArray *)arr{
    
    if (arr.count > 0) {
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary *tmpDic = obj;
            if ([dic[@"name"] isEqualToString:tmpDic[@"name"]] && [dic[@"id"] isEqual:tmpDic[@"id"]]) {
                [arr removeObject:obj];
                *stop = YES;
            }
        }];
    }
}
- (void)removeTitleFromArrayTitle:(NSDictionary *)dic arr:(NSMutableArray *)arr{
    if (arr.count > 0) {
        __block NSDictionary *tmpDic = nil;
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            tmpDic = obj;
            if ([dic[@"name"] isEqualToString:tmpDic[@"name"]] && [dic[@"id"] isEqual:tmpDic[@"id"]]) {
                [arr removeObject:tmpDic];
                [KGRequestNetWorking postWothUrl:deleteMyWord parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"id":dic[@"id"],@"name":dic[@"name"]} succ:^(id result) {
                    
                } fail:^(NSError *error) {
                    
                }];
                *stop = YES;
            }
        }];
    }
}

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
