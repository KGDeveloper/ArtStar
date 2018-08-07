//
//  MineChooseCardTypeView.m
//  ArtStar
//
//  Created by abc on 2018/6/15.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineChooseCardTypeView.h"

@interface MineChooseCardTypeView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic,strong) UIPickerView *chooseView;
@property (nonatomic,copy) NSString *status;

@end

@implementation MineChooseCardTypeView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        _status = @"港澳身份证";
        [self setView];
    }
    return self;
}

- (void)setView{
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, ViewHeight(self) - 270, ViewWidth(self),270)];
    backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backView];
    
    UIButton *cancelBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtu.frame = CGRectMake(15, 10, 50, 20);
    cancelBtu.titleLabel.font = SYFont(12);
    [cancelBtu setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtu setTitleColor:Color_999999 forState:UIControlStateNormal];
    cancelBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [cancelBtu addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:cancelBtu];
    
    UIButton *shureBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    shureBtu.frame = CGRectMake(ViewWidth(self) - 65, 10, 50, 20);
    shureBtu.titleLabel.font = SYFont(12);
    [shureBtu setTitle:@"确定" forState:UIControlStateNormal];
    [shureBtu setTitleColor:Color_333333 forState:UIControlStateNormal];
    shureBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [shureBtu addTarget:self action:@selector(shureClick) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:shureBtu];
    
    _chooseView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 50, ViewWidth(self), 150)];
    _chooseView.delegate = self;
    _chooseView.dataSource = self;
    [backView addSubview:_chooseView];
    
}

- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 3;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 55;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *lab = (UILabel *)view;
    if (lab == nil) {
        lab = [[UILabel alloc]init];
        lab.font = SYFont(13);
        lab.textColor = Color_333333;
        [lab setTextAlignment:NSTextAlignmentCenter];
    }
    lab.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return lab;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSArray *arr = @[@"港澳身份证",@"二代身份证",@"台湾身份证"];
    _status = arr[row];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSArray *arr = @[@"港澳身份证",@"二代身份证",@"台湾身份证"];
    return arr[row];
}

- (void)cancelClick{
    self.hidden = YES;
}

- (void)shureClick{
    if (self.sendIDcardType) {
        self.sendIDcardType(_status);
    }
    self.hidden = YES;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/







@end
