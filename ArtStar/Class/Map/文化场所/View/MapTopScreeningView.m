//
//  MapTopScreeningView.m
//  ArtStar
//
//  Created by abc on 2018/6/22.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MapTopScreeningView.h"
#import "MapAllCityScreeningView.h"
#import "MapSpaceToYourView.h"
#import "MapTypeChooseView.h"
#import "MapFeaturesView.h"

@interface MapTopScreeningView ()

@property (nonatomic,strong) UIView *titleView;
@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) MapAllCityScreeningView *cityScreeningView;
@property (nonatomic,strong) MapSpaceToYourView *distanceView;
@property (nonatomic,strong) MapTypeChooseView *chooseType;
@property (nonatomic,strong) MapFeaturesView *featureView;
@property (nonatomic,copy) NSString *locationCityName;
//
//@property (nonatomic,copy) NSString *district;
//@property (nonatomic,copy) NSString *typeID;
//@property (nonatomic,copy) NSString *space;
//@property (nonatomic,copy) NSString *chooseStr;

@end

@implementation MapTopScreeningView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self cllLocation];
        [self setNavCenterView];
    }
    return self;
}
- (void)cllLocation{
    KGLocationCityManager *manager = [KGLocationCityManager shareManager];
    [manager obtainYourLocation];
    __weak typeof(self) mySelf = self;
    manager.ToObtainYourLocation = ^(NSString *city, double latitude, double longitude) {
        mySelf.locationCityName = city;
    };
}
- (void)setNavCenterView{
    
    _titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, NavTopHeight)];
    _titleView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_titleView];
    
    NSArray *titleArr = @[@"全城",@"类型",@"离我最近",@"特色"];
    
    for (int i = 0; i < 4; i++) {
        [_titleView addSubview:[self createButtonWithFram:CGRectMake(kScreenWidth/5*i, NavTopHeight - 40, kScreenWidth/5, 35) title:titleArr[i] color:Color_999999 font:SYFont(14)]];
    }
    
    [_titleView addSubview:[self createButtonWithFram:CGRectMake(kScreenWidth - kScreenWidth/5,NavTopHeight - 40, kScreenWidth/5, 35) title:@"确定" color:Color_333333 font:SYFont(15)]];
    
    _line = [[UIView alloc]initWithFrame:CGRectMake(0,NavTopHeight - 2, 30, 2)];
    _line.backgroundColor = Color_333333;
    _line.centerX = kScreenWidth/10;
    [_titleView addSubview:_line];
    
}
//MARK:--创建公共按钮--
- (UIButton *)createButtonWithFram:(CGRect)frame title:(NSString *)title color:(UIColor *)color font:(UIFont *)font{
    UIButton *norBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    norBtu.frame = frame;
    [norBtu setTitle:title forState:UIControlStateNormal];
    norBtu.titleLabel.font = font;
    [norBtu setTitleColor:color forState:UIControlStateNormal];
    [norBtu addTarget:self action:@selector(norClick:) forControlEvents:UIControlEventTouchUpInside];
    return norBtu;
}
- (void)norClick:(UIButton *)sender{
    if ([sender.currentTitle isEqualToString:@"确定"]) {
        self.hidden = YES;
    }else{
        for (id obj in _titleView.subviews) {
            if ([obj isKindOfClass:[UIButton class]]) {
                UIButton *nor = obj;
                if ([nor.currentTitle isEqualToString:@"确定"]) {
                    
                }else{
                    [nor setTitleColor:Color_999999 forState:UIControlStateNormal];
                    nor.titleLabel.font = SYFont(14);
                }
            }
        }
        [sender setTitleColor:Color_333333 forState:UIControlStateNormal];
        sender.titleLabel.font = SYFont(15);
        [UIView animateWithDuration:0.2 animations:^{
            self.line.centerX = sender.centerX;
        }];
    }
    if ([sender.currentTitle isEqualToString:@"全城"]) {
        self.cityScreeningView.cityName = _locationCityName;
        self.cityScreeningView.hidden = NO;
        self.distanceView.hidden = YES;
        self.chooseType.hidden = YES;
        self.featureView.hidden = YES;
    }else if ([sender.currentTitle isEqualToString:@"类型"]){
        self.chooseType.mytype = _mapType;
        self.chooseType.hidden = NO;
        self.cityScreeningView.hidden = YES;
        self.distanceView.hidden = YES;
        self.featureView.hidden = YES;
    }else if ([sender.currentTitle isEqualToString:@"离我最近"]){
        self.distanceView.hidden = NO;
        self.cityScreeningView.hidden = YES;
        self.chooseType.hidden = YES;
        self.featureView.hidden = YES;
    }else if ([sender.currentTitle isEqualToString:@"特色"]){
        self.featureView.hidden = NO;
        self.cityScreeningView.hidden = YES;
        self.distanceView.hidden = YES;
        self.chooseType.hidden = YES;
    }
}
// MARK: --选择地区--
- (MapAllCityScreeningView *)cityScreeningView{
    if (!_cityScreeningView) {
        _cityScreeningView = [[MapAllCityScreeningView alloc]initWithFrame:CGRectMake(0, NavTopHeight, kScreenWidth, kScreenHeight/3*2)];
        __weak typeof(self) weakSelf = self;
        _cityScreeningView.sendCityDis = ^(NSString *cityName) {
            //:--在这里获取选择地区--
            if ([weakSelf.delegate respondsToSelector:@selector(sendChooseToVCType:chooseStr:)]) {
                [weakSelf.delegate sendChooseToVCType:@"地区" chooseStr:cityName];
            }
        };
        [self addSubview:_cityScreeningView];
    }
    return _cityScreeningView;
}
// MARK: --选择的距离--
- (MapSpaceToYourView *)distanceView{
    if (!_distanceView) {
        _distanceView = [[MapSpaceToYourView alloc]initWithFrame:CGRectMake(0, NavTopHeight, kScreenWidth, kScreenHeight/3*2)];
        __weak typeof(self) weakSelf = self;
        _distanceView.sendSpace = ^(NSString *space) {
            //:--在这里获取距离--
            if ([weakSelf.delegate respondsToSelector:@selector(sendChooseToVCType:chooseStr:)]) {
                [weakSelf.delegate sendChooseToVCType:@"距离" chooseStr:space];
            }
        };
        [self addSubview:_distanceView];
    }
    return _distanceView;
}
// MARK: --选择的类型--
- (MapTypeChooseView *)chooseType{
    if (!_chooseType) {
        _chooseType = [[MapTypeChooseView alloc]initWithFrame:CGRectMake(0, NavTopHeight, kScreenWidth, kScreenHeight/3*2) type:MapTypeInstitutions];
        __weak typeof(self) weakSelf = self;
        _chooseType.sendChooseTypeID = ^(NSString *typeID) {
            //:--在这里获取选择的类型--
            if ([weakSelf.delegate respondsToSelector:@selector(sendChooseToVCType:chooseStr:)]) {
                [weakSelf.delegate sendChooseToVCType:@"类型" chooseStr:typeID];
            }
        };
        [self addSubview:_chooseType];
    }
    return _chooseType;
}
// MARK: --特色--
- (MapFeaturesView *)featureView{
    if (!_featureView) {
        _featureView = [[MapFeaturesView alloc]initWithFrame:CGRectMake(0, NavTopHeight, kScreenWidth, 75)];
        __weak typeof(self) weakSelf = self;
        _featureView.sendChoose = ^(NSString *chooseStr) {
            //:--在这里获取选择的特色--
            if ([weakSelf.delegate respondsToSelector:@selector(sendChooseToVCType:chooseStr:)]) {
                [weakSelf.delegate sendChooseToVCType:@"特色" chooseStr:chooseStr];
            }
        };
        [self addSubview:_featureView];
    }
    return _featureView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
