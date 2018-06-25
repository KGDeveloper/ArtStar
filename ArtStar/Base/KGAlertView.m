/**
 
 ArtStar
 
 Created by: KG丿轩帝 on 2018/4/20
 
 Copyright (c) 2017 My Company
 
 ☆★☆★☆★☆★☆★☆★☆★☆★☆
 ★　　│　心想　│　事成　│　　★
 ☆别╭═╮　　 ╭═╮　　 ╭═╮别☆
 ★恋│人│　　│奎│　　│幸│恋★
 ☆　│氣│　　│哥│　　│福│　☆
 ★　│超│　　│制│　　│滿│　★
 ☆别│旺│　　│作│　　│滿│别☆
 ★恋│㊣│　　│㊣│　　│㊣│恋★
 ☆　╰═╯ 天天╰═╯ 開心╰═╯　☆
 ★☆★☆★☆★☆★☆★☆★☆★☆★.
 
 */

#import "KGAlertView.h"

@interface KGAlertView ()
//MARK:--警告框--
@property (nonatomic,strong) UIButton *shureBtu;
@property (nonatomic,strong) UIButton *cancelBtu;
@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UILabel *detaialLab;
@property (nonatomic,strong) UIView *alertView;
//MARK:--警告框--
@end

@implementation KGAlertView
//MARK:--------------------KGAlertView-----------------------
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpBackView];
        [self setUI];
    }
    return self;
}
- (void)setUpBackView{
    UIView *backView = [[UIView alloc]initWithFrame:self.frame];
    backView.backgroundColor = Color_999999;
    backView.alpha = 0.4;
    [self addSubview:backView];
}
//MARK:--搭建警告框界面--
- (void)setUI{
    _alertView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth(self) - 100, 200)];
    _alertView.center = CGPointMake(ViewWidth(self)/2, ViewHeight(self)/2);
    _alertView.backgroundColor= [UIColor whiteColor];
    _alertView.layer.cornerRadius = 5;
    _alertView.layer.masksToBounds = YES;
    [self addSubview:_alertView];
    
    _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ViewWidth(_alertView), 30)];
    _titleLab.text = @"提示";
    _titleLab.font = FZFont(20);
    _titleLab.textAlignment = NSTextAlignmentCenter;
    _titleLab.textColor = Color_333333;
    [_alertView addSubview:_titleLab];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 30, ViewWidth(_alertView), 1)];
    line.backgroundColor = Color_999999;
    [_alertView addSubview:line];
    
    _detaialLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, ViewWidth(_alertView), 100)];
    _detaialLab.text = @"提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示提示";
    _detaialLab.font = FZFont(15);
    _detaialLab.textAlignment = NSTextAlignmentCenter;
    _detaialLab.textColor = Color_999999;
    [_alertView addSubview:_detaialLab];
    
}
- (void)setAlertViewTitle:(NSString *)title message:(NSString *)message type:(KGAlertViewType)type{
    _titleLab.text = title;
    _detaialLab.frame = CGRectMake(ViewX(_detaialLab), ViewY(_detaialLab), ViewWidth(_detaialLab), [self calculateRowHeightWithString:message]);
    _detaialLab.text = message;
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0,ViewHeight(_alertView) - 40, ViewWidth(_alertView), 1)];
    line.backgroundColor = Color_999999;
    [_alertView addSubview:line];
    switch (type) {
        case KGAlertViewTypeDefult://默认
            [self createButton:self.shureBtu frame:CGRectMake(0, ViewHeight(_alertView) - 40, ViewWidth(_alertView), 40) title:@"确定" color:[UIColor blueColor] action:@selector(defaultClick)];
            break;
        case KGAlertViewTypeShure://左边确认
            [self createButton:self.shureBtu frame:CGRectMake(0, ViewHeight(_alertView) - 40, ViewWidth(_alertView)/2, 40) title:@"确定" color:Color_999999 action:@selector(shureClick)];
            [self createButton:self.cancelBtu frame:CGRectMake(ViewWidth(_alertView)/2, ViewHeight(_alertView) - 40, ViewWidth(_alertView)/2, 40) title:@"取消" color:[UIColor redColor] action:@selector(cancelClick)];
            break;
        default://左边取消
            [self createButton:self.shureBtu frame:CGRectMake(0, ViewHeight(_alertView) - 40, ViewWidth(_alertView)/2, 40) title:@"取消" color:[UIColor blueColor] action:@selector(cancelClick)];
            [self createButton:self.shureBtu frame:CGRectMake(ViewWidth(_alertView)/2, ViewHeight(_alertView) - 40, ViewWidth(_alertView)/2, 40) title:@"确定" color:[UIColor blueColor] action:@selector(shureClick)];
            break;
    }
}
- (void)cancelClick{
    self.hidden = YES;
    if ([self.delegate respondsToSelector:@selector(cancel)]) {
        [self.delegate cancel];
    }
}
- (void)shureClick{
    self.hidden = YES;
    if ([self.delegate respondsToSelector:@selector(shure)]) {
        [self.delegate shure];
    }
}
- (void)defaultClick{
    self.hidden = YES;
    if ([self.delegate respondsToSelector:@selector(defult)]) {
        [self.delegate defult];
    }
}
- (CGFloat)calculateRowHeightWithString:(NSString *)string{
    NSDictionary *dic = @{NSFontAttributeName:FZFont(15)};
    CGRect rect = [string boundingRectWithSize:CGSizeMake(ViewWidth(_alertView), 0) options:NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return rect.size.height;
}
- (void)createButton:(UIButton *)button frame:(CGRect)frame title:(NSString *)title color:(UIColor *)color action:(SEL)action{
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
//    button.layer.borderWidth = 1;
//    button.layer.borderColor = Color_999999.CGColor;
    [_alertView addSubview:button];
}
@end



//MARK:--------------------KGCamera-----------------------
@interface KGCamera ()
//MARK:--选择相机或者相册--
@property (nonatomic,strong) UIButton *camareBtu;
@property (nonatomic,strong) UIButton *photoBtu;
@property (nonatomic,strong) UIButton *closeBtu;
@property (nonatomic,strong) UIView *chooseView;
//MARK:--选择相机或者相册--
@end

@implementation KGCamera

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpBackView];
        [self setUI];
    }
    return self;
}
- (void)setUpBackView{
    UIView *backView = [[UIView alloc]initWithFrame:self.frame];
    backView.backgroundColor = Color_999999;
    backView.alpha = 0.4;
    [self addSubview:backView];
}
//MARK:--搭建UI界面--
- (void)setUI{
    UIView *back = [[UIView alloc]initWithFrame:CGRectMake(5, ViewHeight(self) - 160 - NavButtomHeight, ViewWidth(self) - 10, 101)];
    back.backgroundColor = [UIColor whiteColor];
    back.layer.cornerRadius = 5;
    back.layer.masksToBounds = YES;
    [self addSubview:back];
    self.camareBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.camareBtu.frame = CGRectMake(0, 0, ViewWidth(back), 50);
    [self.camareBtu setTitle:@"拍照上传" forState:UIControlStateNormal];
    [self.camareBtu setTitleColor:Color_333333 forState:UIControlStateNormal];
    self.camareBtu.titleLabel.font = FZFont(14);
    [self.camareBtu addTarget:self action:@selector(cancelBtuClick:) forControlEvents:UIControlEventTouchUpInside];
    [back addSubview:self.camareBtu];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(5, 50, ViewWidth(back) - 10, 1)];
    line.backgroundColor = Color_999999;
    [back addSubview:line];
    
    self.photoBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.photoBtu.frame = CGRectMake(0, 51, ViewWidth(back), 50);
    [self.photoBtu setTitle:@"本地上传" forState:UIControlStateNormal];
    [self.photoBtu setTitleColor:Color_333333 forState:UIControlStateNormal];
    self.photoBtu.titleLabel.font = FZFont(14);
    [self.photoBtu addTarget:self action:@selector(photoBtuClick:) forControlEvents:UIControlEventTouchUpInside];
    [back addSubview:self.photoBtu];
    
    self.closeBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.closeBtu.frame = CGRectMake(5, ViewHeight(self) - 50 - NavButtomHeight, ViewWidth(back), 50);
    self.closeBtu.backgroundColor = [UIColor whiteColor];
    [self.closeBtu setTitle:@"取消" forState:UIControlStateNormal];
    [self.closeBtu setTitleColor:Color_999999 forState:UIControlStateNormal];
    self.closeBtu.titleLabel.font = FZFont(13);
    self.closeBtu.layer.cornerRadius = 5;
    self.closeBtu.layer.masksToBounds = YES;
    [self.closeBtu addTarget:self action:@selector(closeBtuClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.closeBtu];
}
//MARK:--点击拍照上传--
- (void)cancelBtuClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(touchCamera)]) {
        [self.delegate touchCamera];
    }
}
//MARK:--点击本地上传--
- (void)photoBtuClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(touchPhoto)]) {
        [self.delegate touchPhoto];
    }
}
//MARK:--点击取消--
- (void)closeBtuClick:(UIButton *)sender{
    self.hidden = YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.hidden = YES;
}

@end


//MARK:--------------------KGMessage-----------------------
@interface KGMessage ()
//MARK:--提示信息--
@property (nonatomic,strong) UILabel *msgLab;
@property (nonatomic,strong) UIView *popupView;
//MARK:--提示信息--
@end

@implementation KGMessage

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpBackView];
    }
    return self;
}
- (void)setUpBackView{
    UIView *backView = [[UIView alloc]initWithFrame:self.frame];
    backView.backgroundColor = Color_999999;
    backView.alpha = 0.4;
    [self addSubview:backView];
}

@end
