//
//  ReportView.m
//  ArtStar
//
//  Created by abc on 6/8/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "ReportView.h"

@interface ReportView ()<UITextFieldDelegate>

@property (nonatomic,strong) UIView *report;
@property (nonatomic,strong) UIButton *cancelBtu;
@property (nonatomic,strong) UIButton *talkBtu;
@property (nonatomic,strong) UIButton *finishBtu;
@property (nonatomic,strong) UILabel *resonLab;
@property (nonatomic,strong) UITextField *resonTV;
@property (nonatomic,strong) UIView *lowline;

@end

@implementation ReportView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        
        [self setViewUI];
    }
    return self;
}

- (void)setViewUI{
    _report = [[UIView alloc]initWithFrame:CGRectMake(0, ViewHeight(self) - 315,ViewWidth(self), 315)];
    _report.backgroundColor = [UIColor whiteColor];
    [self addSubview:_report];
    
    NSArray *titleArr = @[@"违法信息",@"营销广告",@"恶意攻击谩骂"];
    for (int i = 0; i < 3; i++) {
        [_report addSubview:[self createBtuFrame:CGRectMake(25, 90 + 45*i, ViewWidth(self) - 50, 45) title:titleArr[i]]];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(25, 135 + 45 *i, ViewWidth(self) - 50, 1)];
        line.backgroundColor = Color_ededed;
        [_report addSubview:line];
    }
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, ViewWidth(self), 15)];
    titleLab.text = @"举报";
    titleLab.textColor = Color_333333;
    titleLab.font = SYBFont(14);
    titleLab.textAlignment = NSTextAlignmentCenter;
    [_report addSubview:titleLab];
    
    _resonLab = [[UILabel alloc]initWithFrame:CGRectMake(25, 60, ViewWidth(self) - 80, 15)];
    _resonLab.text = @"已举报  淫秽信息";
    _resonLab.textColor = Color_cccccc;
    _resonLab.font = SYFont(14);
    [_report addSubview:_resonLab];
    
    UIView *topline = [[UIView alloc]initWithFrame:CGRectMake(25,90, ViewWidth(self) - 50, 1)];
    topline.backgroundColor = Color_ededed;
    [_report addSubview:topline];
    
    _cancelBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelBtu.frame = CGRectMake(ViewWidth(self) - 80, 45, 65, 45);
    [_cancelBtu setTitle:@"撤销" forState:UIControlStateNormal];
    [_cancelBtu setTitleColor:Color_333333 forState:UIControlStateNormal];
    _cancelBtu.titleLabel.font = SYFont(14);
    _cancelBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [_cancelBtu addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [_report addSubview:_cancelBtu];
    
    _talkBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _talkBtu.frame = CGRectMake(25, ViewHeight(_report) - 90, ViewWidth(self) - 25, 45);
    _talkBtu.tag = 110;
    [_talkBtu setTitle:@"我有话说" forState:UIControlStateNormal];
    [_talkBtu setImage:Image(@"report open") forState:UIControlStateNormal];
    [_talkBtu setTitleColor:Color_333333 forState:UIControlStateNormal];
    _talkBtu.titleLabel.font = SYFont(13);
    _talkBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _talkBtu.titleEdgeInsets = UIEdgeInsetsMake(0, -_talkBtu.imageView.size.width, 0, _talkBtu.imageView.size.width);
    _talkBtu.imageEdgeInsets = UIEdgeInsetsMake(0, _talkBtu.titleLabel.size.width + 15, 0,-_talkBtu.titleLabel.size.width + 15);
    [_talkBtu addTarget:self action:@selector(resonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_report addSubview:_talkBtu];
    
    _resonTV = [[UITextField alloc]initWithFrame:CGRectMake(25, ViewHeight(_report) - 45, ViewWidth(self) - 50,0)];
    _resonTV.placeholder = @"请说明具体问题,我们将尽快处理";
    _resonTV.textColor = Color_333333;
    _resonTV.delegate = self;
    _resonTV.font = SYFont(14);
    _resonTV.layer.cornerRadius = 5;
    _resonTV.layer.borderColor = Color_cccccc.CGColor;
    _resonTV.layer.borderWidth = 1;
    _resonTV.layer.masksToBounds = YES;
    [_report addSubview:_resonTV];
    
    _lowline = [[UIView alloc]initWithFrame:CGRectMake(0,ViewHeight(_report) - 45, ViewWidth(self), 1)];
    _lowline.backgroundColor = Color_ededed;
    [_report addSubview:_lowline];
    
    _finishBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _finishBtu.frame = CGRectMake(0, ViewHeight(_report) - 45, ViewWidth(self), 45);
    [_finishBtu setTitle:@"完成" forState:UIControlStateNormal];
    [_finishBtu setTitleColor:Color_333333 forState:UIControlStateNormal];
    _finishBtu.titleLabel.font = SYFont(13);
    [_finishBtu addTarget:self action:@selector(finishClick) forControlEvents:UIControlEventTouchUpInside];
    [_report addSubview:_finishBtu];
    
}
- (UIButton *)createBtuFrame:(CGRect)frame title:(NSString *)title{
    UIButton *resonBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    resonBtu.frame = frame;
    [resonBtu setTitle:title forState:UIControlStateNormal];
    [resonBtu setTitleColor:Color_333333 forState:UIControlStateNormal];
    resonBtu.titleLabel.font = SYFont(13);
    resonBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [resonBtu addTarget:self action:@selector(resonClick:) forControlEvents:UIControlEventTouchUpInside];
    return resonBtu;
}
- (void)resonClick:(UIButton *)sender{
    for (id obj in _report.subviews) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *norBtu = obj;
            [norBtu setTitleColor:Color_333333 forState:UIControlStateNormal];
        }
    }
    [sender setTitleColor:Color_cccccc forState:UIControlStateNormal];
    if (sender.tag == 110) {
        _report.frame = CGRectMake(0, ViewHeight(self) - 380,ViewWidth(self), 380);
        _resonTV.frame = CGRectMake(25, ViewHeight(_report) - 110, ViewWidth(self) - 50,65);
        [_talkBtu setImage:Image(@"report dropdown") forState:UIControlStateNormal];
        _finishBtu.frame = CGRectMake(0, ViewHeight(_report) - 45, ViewWidth(self), 45);
        _lowline.hidden = YES;
    }else{
        _resonLab.text = [NSString stringWithFormat:@"已举报  %@",sender.currentTitle];
        _report.frame = CGRectMake(0, ViewHeight(self) - 315,ViewWidth(self), 315);
        _resonTV.frame = CGRectMake(25, ViewHeight(_report) - 45, ViewWidth(self) - 50,0);
        [_talkBtu setImage:Image(@"report open") forState:UIControlStateNormal];
        _finishBtu.frame = CGRectMake(0, ViewHeight(_report) - 45, ViewWidth(self), 45);
        _lowline.hidden = YES;
    }
}
- (void)cancelClick{
    for (id obj in _report.subviews) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *norBtu = obj;
            [norBtu setTitleColor:Color_333333 forState:UIControlStateNormal];
        }
    }
    _resonLab.text = @"已举报  淫秽信息";
    _resonTV.text = @"";
    _report.frame = CGRectMake(0, ViewHeight(self) - 315,ViewWidth(self), 315);
    _resonTV.frame = CGRectMake(25, ViewHeight(_report) - 45, ViewWidth(self) - 50,0);
    [_talkBtu setImage:Image(@"report open") forState:UIControlStateNormal];
    _finishBtu.frame = CGRectMake(0, ViewHeight(_report) - 45, ViewWidth(self), 45);
    _lowline.hidden = YES;
}
- (void)finishClick{
    if ([self.delegate respondsToSelector:@selector(sendReportResonToServer:)]) {
        [self.delegate sendReportResonToServer:_resonLab.text];
    }
    _resonTV.text = @"";
    _resonLab.text = @"已举报  淫秽信息";
    self.hidden = YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.hidden = YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    _report.frame = CGRectMake(0, ViewHeight(self) - 380 - 260,ViewWidth(self), 380);
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    _report.frame = CGRectMake(0, ViewHeight(self) - 380,ViewWidth(self), 380);
}
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    return YES;
//}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    _resonLab.text = [NSString stringWithFormat:@"已举报  %@",textField.text];
    return YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
