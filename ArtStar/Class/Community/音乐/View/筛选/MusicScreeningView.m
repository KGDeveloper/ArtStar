//
//  MusicScreeningView.m
//  ArtStar
//
//  Created by abc on 5/31/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "MusicScreeningView.h"
#import "MusicChooseCityView.h"
#import "MusicChooseSexView.h"
#import "MusicChooseTypeView.h"

@interface MusicScreeningView ()

@property (nonatomic,strong) UIView *topView;
@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) MusicChooseCityView *chooseCity;
@property (nonatomic,strong) MusicChooseSexView *sexView;
@property (nonatomic,strong) MusicChooseTypeView *typeView;

@property (nonatomic,copy) NSString *provinceName;
@property (nonatomic,copy) NSString *cityName;
@property (nonatomic,copy) NSString *sexStr;
@property (nonatomic,copy) NSString *typeStr;

@end

@implementation MusicScreeningView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self setTopBtu];
        self.chooseCity.hidden = NO;
    }
    return self;
}
//MARK:------------------------------------------顶部按钮----------------------------------------------
- (void)setTopBtu{
    UIView *backView = [[UIView alloc]initWithFrame:self.bounds];
    backView.backgroundColor = [UIColor blackColor];
    backView.alpha = 0.2;
    [self addSubview:backView];
    _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, NavTopHeight)];
    _topView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_topView];
    NSArray *titleArr = @[@"地区",@"性别",@"类型"];
    for (int i = 0; i < titleArr.count; i++) {
        if (i == 0) {
            [_topView addSubview:[self createButton:CGRectMake(0, ViewHeight(_topView) - 30, (kScreenWidth - 75)/3, 15) title:titleArr[i] color:Color_333333 font:SYFont(15) tag:105]];
        }else{
            [_topView addSubview:[self createButton:CGRectMake((kScreenWidth - 75)/3*i, ViewHeight(_topView) - 30, (kScreenWidth - 75)/3, 15) title:titleArr[i] color:Color_999999 font:SYFont(13) tag:105+i]];
        }
    }
    
    [_topView addSubview:[self createButton:CGRectMake(ViewWidth(_topView) - 75, ViewHeight(_topView) - 30, 60, 15) title:@"确定" color:Color_333333 font:SYFont(13) tag:101]];
    
    UIView *backline = [[UIView alloc]initWithFrame:CGRectMake(0, ViewHeight(_topView)-1, ViewWidth(_topView), 1)];
    backline.backgroundColor = Color_ededed;
    [_topView addSubview:backline];
    
    _line = [[UIView alloc]initWithFrame:CGRectMake((kScreenWidth - 75)/3/2 - 15, ViewHeight(_topView) - 2, 30, 2)];
    _line.backgroundColor = Color_333333;
    [_topView addSubview:_line];
}
//MARK:----------------------------------------创建按钮------------------------------------------------
- (UIButton *)createButton:(CGRect)frmae title:(NSString *)title color:(UIColor *)color font:(UIFont *)font tag:(NSInteger)tag{
    UIButton *srcollBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    srcollBtu.frame = frmae;
    srcollBtu.tag = tag;
    srcollBtu.backgroundColor = [UIColor whiteColor];
    [srcollBtu setTitle:title forState:UIControlStateNormal];
    [srcollBtu setTitleColor:color forState:UIControlStateNormal];
    srcollBtu.titleLabel.font = font;
    [srcollBtu addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    return srcollBtu;
}
//MARK:--------------------------------------按钮点击事件--------------------------------------------------
- (void)selectAction:(UIButton *)sender{
    if (sender.tag >= 105) {
        for (id obj in _topView.subviews) {
            if ([obj isKindOfClass:[UIButton class]]) {
                UIButton *normalBtu = obj;
                if (normalBtu.tag >= 105 ) {
                    [normalBtu setTitleColor:Color_999999 forState:UIControlStateNormal];
                    normalBtu.titleLabel.font = SYFont(13);
                }
            }
        }
        [sender setTitleColor:Color_333333 forState:UIControlStateNormal];
        sender.titleLabel.font = SYFont(15);
        [UIView animateWithDuration:0.1 animations:^{
            self.line.centerX = sender.centerX;
        }];
        if ([sender.currentTitle isEqualToString:@"地区"]) {
            self.chooseCity.hidden = NO;
            self.sexView.hidden = YES;
            self.typeView.hidden = YES;
        }else if ([sender.currentTitle isEqualToString:@"性别"]){
            self.sexView.hidden = NO;
            self.chooseCity.hidden = YES;
            self.typeView.hidden = YES;
        }else{
            self.typeView.hidden = NO;
            self.chooseCity.hidden = YES;
            self.sexView.hidden = YES;
        }
    }else{
        if (_cityName != nil || _cityName != NULL) {
            if (self.sendProvinceNameAndCityName) {
                self.sendProvinceNameAndCityName(_provinceName,_cityName);
            }
        }
        if (_sexStr != nil || _sexStr != NULL) {
            if (self.sendSexStr) {
                self.sendSexStr(_sexStr);
            }
        }
        if (_typeStr != nil || _typeStr != NULL) {
            if (self.sendTypeStr) {
                self.sendTypeStr(_typeStr);
            }
        }
        self.hidden = YES;
    }
}
//MARK:--------------------------------------------创建显示地区的view--------------------------------------------
- (MusicChooseCityView *)chooseCity{
    if (!_chooseCity) {
        _chooseCity = [[MusicChooseCityView alloc]initWithFrame:CGRectMake(0, NavTopHeight,ViewWidth(self), ViewHeight(self) - NavTopHeight - 110 - NavButtomHeight)];
        __weak typeof(self) mySelf = self;
        _chooseCity.sendProvinceNameAndCityName = ^(NSString *provinceName, NSString *cityName) {
            mySelf.provinceName = provinceName;
            mySelf.cityName = cityName;
        };
        [self insertSubview:_chooseCity atIndex:99];
    }
    return _chooseCity;
}
//MARK:-----------------------------------------------创建选择性别view-----------------------------------------
- (MusicChooseSexView *)sexView{
    if (!_sexView) {
        _sexView = [[MusicChooseSexView alloc]initWithFrame:CGRectMake(0, NavTopHeight, ViewWidth(self), 180)];
        __weak typeof(self) mySelf = self;
        _sexView.chooseSexStr = ^(NSString *sex) {
            mySelf.sexStr = sex;
        };
        [self insertSubview:_sexView atIndex:99];
    }
    return _sexView;
}
//MARK:------------------------------------------------创建typeView----------------------------------------
- (MusicChooseTypeView *)typeView{
    if (!_typeView) {
        _typeView = [[MusicChooseTypeView alloc]initWithFrame:CGRectMake(0, NavTopHeight, ViewWidth(self), ViewHeight(self) - NavTopHeight)];
        __weak typeof(self) mySelf = self;
        _typeView.sendType = ^(NSString *type) {
            mySelf.typeStr = type;
        };
        [self insertSubview:_typeView atIndex:99];
    }
    return _typeView;
}
//MARK:----------------------------------------------------------------------------------------
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    self.hidden = YES;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
