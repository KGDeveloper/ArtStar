//
//  MineMySelfWordVC.m
//  ArtStar
//
//  Created by abc on 2018/6/13.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineMySelfWordVC.h"
#import "MineMyselfWordAddLabelVC.h"

@interface MineMySelfWordVC ()

@property (nonatomic,strong) UIScrollView *backScrollView;
@property (nonatomic,strong) UIView *foodView;
@property (nonatomic,strong) UIView *sportView;
@property (nonatomic,strong) UIView *leisureView;
@property (nonatomic,strong) UIView *footprintView;

@property (nonatomic,strong) NSMutableArray *chooseFood;
@property (nonatomic,strong) NSMutableArray *chooseSport;
@property (nonatomic,strong) NSMutableArray *chooseLeisure;
@property (nonatomic,strong) NSMutableArray *chooseFootprint;

@end

@implementation MineMySelfWordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBtuWithFrame:CGRectMake(0, 0, 150, 30) title:@"我的世界" image:Image(@"back")];
    [self setRightBtuWithFrame:CGRectMake(0, 0, 50, 30) title:@"保存" image:nil];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setViewAndBackView];
    
}

- (void)setViewAndBackView{
    
    _backScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, NavTopHeight, kScreenWidth, kScreenHeight)];
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
    for (int i = 0; i < _foodArr.count + 1; i++) {
        if (i == _foodArr.count) {
            if (width + 90 > kScreenWidth) {
                width = 15;
                height = height + 30;
                [_foodView addSubview:[self createButtonframe:CGRectMake(width,height,75,20) title:@"+" tag:150 + i]];
            }
        }else{
            if (width + [TransformChineseToPinying stringWidthFromString:_foodArr[i] font:SYFont(12) width:kScreenWidth - 30] + 30 > kScreenWidth) {
                width = 15;
                height = height + 30;
            }
            [_foodView addSubview:[self createButtonframe:CGRectMake(width,height,[TransformChineseToPinying stringWidthFromString:_foodArr[i] font:SYFont(12) width:kScreenWidth] + 15,20) title:_foodArr[i] tag:150 + i]];
            
            width = width + [TransformChineseToPinying stringWidthFromString:_foodArr[i] font:SYFont(12) width:kScreenWidth] + 35;
        }
    }
    
    _foodView.frame = CGRectMake(0, 0, kScreenWidth, height + 20);
    _backScrollView.contentSize = CGSizeMake(kScreenWidth,ViewHeight(_foodView) + ViewHeight(_sportView) + ViewHeight(_leisureView) + ViewHeight(_footprintView));
}

- (void)setSport{
    _sportView = [[UIView alloc]initWithFrame:CGRectMake(0,ViewHeight(_foodView), kScreenWidth, 170)];
    [_backScrollView addSubview:_sportView];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 30, ViewHeight(_sportView) - 30, 15)];
    titleLab.text = @"运动";
    titleLab.textColor = Color_333333;
    titleLab.font = SYFont(13);
    [_sportView addSubview:titleLab];
    
    CGFloat width = 15;
    CGFloat height = 50;
    for (int i = 0; i < _sportArr.count + 1; i++) {
        if (i == _sportArr.count) {
            if (width + 90 > kScreenWidth) {
                width = 15;
                height = height + 30;
                [_sportView addSubview:[self createButtonframe:CGRectMake(width,height,75,20) title:@"+" tag:250 + i]];
            }
        }else{
            if (width + [TransformChineseToPinying stringWidthFromString:_sportArr[i] font:SYFont(12) width:kScreenWidth] + 30 > kScreenWidth) {
                width = 15;
                height = height + 30;
            }
            [_sportView addSubview:[self createButtonframe:CGRectMake(width,height,[TransformChineseToPinying stringWidthFromString:_sportArr[i] font:SYFont(12) width:kScreenWidth] + 15,20) title:_sportArr[i] tag:250 + i]];
            
            width = width + [TransformChineseToPinying stringWidthFromString:_sportArr[i] font:SYFont(12) width:kScreenWidth] + 35;
        }
    }
    _sportView.frame = CGRectMake(0,ViewHeight(_foodView), kScreenWidth, height + 20);
    _backScrollView.contentSize = CGSizeMake(kScreenWidth,ViewHeight(_foodView) + ViewHeight(_sportView) + ViewHeight(_leisureView) + ViewHeight(_footprintView));
}

- (void)setLeisure{
    _leisureView = [[UIView alloc]initWithFrame:CGRectMake(0,ViewHeight(_foodView) + ViewHeight(_sportView), kScreenWidth, 170)];
    [_backScrollView addSubview:_leisureView];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 30, ViewHeight(_leisureView) - 30, 15)];
    titleLab.text = @"休闲方式";
    titleLab.textColor = Color_333333;
    titleLab.font = SYFont(13);
    [_leisureView addSubview:titleLab];
    
    CGFloat width = 15;
    CGFloat height = 50;
    for (int i = 0; i < _leisureArr.count + 1; i++) {
        if (i == _leisureArr.count) {
            if (width + 90 > kScreenWidth) {
                width = 15;
                height = height + 30;
                [_leisureView addSubview:[self createButtonframe:CGRectMake(width,height,75,20) title:@"+" tag:350 + i]];
            }
        }else{
            if (width + [TransformChineseToPinying stringWidthFromString:_leisureArr[i] font:SYFont(12) width:kScreenWidth] + 30 > kScreenWidth) {
                width = 15;
                height = height + 30;
            }
            [_leisureView addSubview:[self createButtonframe:CGRectMake(width,height,[TransformChineseToPinying stringWidthFromString:_leisureArr[i] font:SYFont(12) width:kScreenWidth] + 15,20) title:_leisureArr[i] tag:350 + i]];
            
            width = width + [TransformChineseToPinying stringWidthFromString:_leisureArr[i] font:SYFont(12) width:kScreenWidth] + 35;
        }
    }
    _leisureView.frame = CGRectMake(0,ViewHeight(_foodView) + ViewHeight(_sportView), kScreenWidth, height + 20);
    _backScrollView.contentSize = CGSizeMake(kScreenWidth,ViewHeight(_foodView) + ViewHeight(_sportView) + ViewHeight(_leisureView) + ViewHeight(_footprintView));
}

- (void)setFootprint{
    _footprintView = [[UIView alloc]initWithFrame:CGRectMake(0,ViewHeight(_foodView) + ViewHeight(_sportView) + ViewHeight(_leisureView), kScreenWidth, 170)];
    [_backScrollView addSubview:_footprintView];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 30, ViewHeight(_footprintView) - 30, 15)];
    titleLab.text = @"足迹";
    titleLab.textColor = Color_333333;
    titleLab.font = SYFont(13);
    [_footprintView addSubview:titleLab];
    
    CGFloat width = 15;
    CGFloat height = 50;
    for (int i = 0; i < _footprintArr.count + 1; i++) {
        if (i == _footprintArr.count) {
            if (width + 90 > kScreenWidth) {
                width = 15;
                height = height + 30;
                [_footprintView addSubview:[self createButtonframe:CGRectMake(width,height,75,20) title:@"+" tag:450 + i]];
            }
        }else{
            if (width + [TransformChineseToPinying stringWidthFromString:_footprintArr[i] font:SYFont(12) width:kScreenWidth] + 30 > kScreenWidth) {
                width = 15;
                height = height + 30;
            }
            [_footprintView addSubview:[self createButtonframe:CGRectMake(width,height,[TransformChineseToPinying stringWidthFromString:_footprintArr[i] font:SYFont(12) width:kScreenWidth] + 15,20) title:_footprintArr[i] tag:450 + i]];
            
            width = width + [TransformChineseToPinying stringWidthFromString:_footprintArr[i] font:SYFont(12) width:kScreenWidth] + 35;
        }
    }
    _footprintView.frame = CGRectMake(0,ViewHeight(_foodView) + ViewHeight(_sportView) + ViewHeight(_leisureView), kScreenWidth, height + 20);
    _backScrollView.contentSize = CGSizeMake(kScreenWidth,ViewHeight(_foodView) + ViewHeight(_sportView) + ViewHeight(_leisureView) + ViewHeight(_footprintView));
}

- (UIButton *)createButtonframe:(CGRect)frame title:(NSString *)title tag:(NSInteger)tag{
    UIButton *norBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    norBtu.frame = frame;
    norBtu.tag = tag;
    [norBtu setTitle:title forState:UIControlStateNormal];
    [norBtu setTitleColor:Color_333333 forState:UIControlStateNormal];
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
        if ([self firstColor:sender.currentTitleColor secondColor:Color_333333] == YES) {
            if (sender.tag >= 150 && sender.tag < 250) {
                [self removeTitleFromArrayTitle:sender.currentTitle arr:_chooseFood];
            }else if (sender.tag >= 250 && sender.tag < 350){
                [self removeTitleFromArrayTitle:sender.currentTitle arr:_chooseSport];
            }else if (sender.tag >= 350 && sender.tag < 450){
                [self removeTitleFromArrayTitle:sender.currentTitle arr:_chooseLeisure];
            }else{
                [self removeTitleFromArrayTitle:sender.currentTitle arr:_chooseFootprint];
            }
            [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            sender.backgroundColor = [UIColor colorWithHexString:@"#4d4d4d"];
        }else{
            if (sender.tag >= 150 && sender.tag < 250) {
                if ([self arrayCountWithTitle:sender.currentTitle arr:_chooseFood] < 5) {
                    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    sender.backgroundColor = [UIColor colorWithHexString:@"#4d4d4d"];
                }
            }else if (sender.tag >= 250 && sender.tag < 350){
                if ([self arrayCountWithTitle:sender.currentTitle arr:_chooseSport] < 5) {
                    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    sender.backgroundColor = [UIColor colorWithHexString:@"#4d4d4d"];
                }
            }else if (sender.tag >= 350 && sender.tag < 450){
                if ([self arrayCountWithTitle:sender.currentTitle arr:_chooseLeisure] < 5) {
                    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    sender.backgroundColor = [UIColor colorWithHexString:@"#4d4d4d"];
                }
            }else{
                if ([self arrayCountWithTitle:sender.currentTitle arr:_chooseFootprint] < 5) {
                    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    sender.backgroundColor = [UIColor colorWithHexString:@"#4d4d4d"];
                }
            }
        }
    }
}

- (NSInteger)arrayCountWithTitle:(NSString *)title arr:(NSMutableArray *)arr{
    if (arr.count < 5) {
        [arr addObject:title];
    }
    return arr.count;
}
- (void)removeTitleFromArrayTitle:(NSString *)title arr:(NSMutableArray *)arr{
    for (NSString *str in arr) {
        if ([str isEqualToString:title]) {
            [arr removeObject:str];
        }
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
