//
//  MineHeaderView.m
//  ArtStar
//
//  Created by abc on 6/7/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "MineHeaderView.h"
#import "MineOnlineOrStealthView.h"
#import "MineButtonView.h"

@interface MineHeaderView ()

@property (nonatomic,strong) UIImageView *backImage;
@property (nonatomic,strong) UIImageView *headerImage;
@property (nonatomic,strong) UILabel *nameLab;
@property (nonatomic,strong) UIButton *ageBtu;
@property (nonatomic,strong) UIButton *statuBtu;
@property (nonatomic,strong) UILabel *signatureLab;
@property (nonatomic,strong) MineOnlineOrStealthView *stutaView;

@end

@implementation MineHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = Color_333333;
        _backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, ViewWidth(self), ViewHeight(self) - 10)];
        _backImage.image = Image(@"2");
        _backImage.alpha = 0.2;
        [self addSubview:_backImage];
        [self setHeaderView];
    }
    return self;
}

- (void)setHeaderView{
    
    _headerImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, NavTopHeight - 4, 60, 60)];
    _headerImage.image = Image(@"2");
    _headerImage.layer.cornerRadius = 30;
    _headerImage.layer.borderColor = [UIColor colorWithHexString:@"#ffffff"].CGColor;
    _headerImage.layer.borderWidth = 1;
    _headerImage.layer.masksToBounds = YES;
    [self addSubview:_headerImage];
    
    UIButton *btu = [UIButton buttonWithType:UIButtonTypeCustom];
    btu.frame = _headerImage.frame;
    [btu addTarget:self action:@selector(intoMySelfCenter) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btu];
    
    _statuBtu = [[UIButton alloc]initWithFrame:CGRectMake(ViewWidth(self) - 55, NavTopHeight - 4, 40, 20)];
    [_statuBtu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_statuBtu setTitle:@"在线" forState:UIControlStateNormal];
    _statuBtu.titleLabel.font = SYFont(11);
    [_statuBtu addTarget:self action:@selector(changeStatus:) forControlEvents:UIControlEventTouchUpInside];
    _statuBtu.backgroundColor = [UIColor colorWithRed:211/255.0 green:211/255.0 blue:211/255.0 alpha:0.1];
    _statuBtu.layer.cornerRadius = 10;
    _statuBtu.layer.masksToBounds = YES;
    [self addSubview:_statuBtu];
    
    _nameLab = [[UILabel alloc]initWithFrame:CGRectMake(15, NavTopHeight + 71, 120, 15)];
    _nameLab.textColor = [UIColor whiteColor];
    _nameLab.font = SYFont(15);
    _nameLab.text = @"轩哥哥";
    [self addSubview:_nameLab];
    
    _ageBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _ageBtu.frame = CGRectMake(25 + [TransformChineseToPinying stringWidthFromString:@"轩哥哥" font:SYFont(15) width:ViewWidth(self)], NavTopHeight + 71, 40, 15);
    [_ageBtu setTitle:@"28" forState:UIControlStateNormal];
    _ageBtu.titleLabel.font = SYFont(11);
    [_ageBtu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_ageBtu setImage:Image(@"man") forState:UIControlStateNormal];
    [_ageBtu setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    _ageBtu.backgroundColor = Color_Boy;
    _ageBtu.layer.cornerRadius = 2;
    _ageBtu.layer.masksToBounds = YES;
    [self addSubview:_ageBtu];
    
    _signatureLab = [[UILabel alloc]initWithFrame:CGRectMake(15, NavTopHeight + 101, ViewWidth(self) - 30, 15)];
    _signatureLab.textColor = [UIColor whiteColor];
    _signatureLab.font = SYFont(11);
    _signatureLab.text = @"我若成佛，天下无魔。我若成魔，杀神屠佛！！！";
    [self addSubview:_signatureLab];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(15, NavTopHeight + 131, ViewWidth(self) - 30, 1)];
    line.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.4];
    [self addSubview:line];
    
    MineButtonView *collectionBtu = [[MineButtonView alloc]initWithFrame:CGRectMake(0, ViewHeight(self) - 80,ViewWidth(self)/4, 80)];
    collectionBtu.titleStr = @"收藏";
    collectionBtu.imageStr = @"收藏";
    __weak typeof(self) mySelf = self;
    collectionBtu.selectButton = ^(NSString *title) {
        if ([mySelf.delegate respondsToSelector:@selector(pushViewControllerViewTitle:)]) {
            [mySelf.delegate pushViewControllerViewTitle:title];
        }
    };
    [self addSubview:collectionBtu];
    
    MineButtonView *integralBtu = [[MineButtonView alloc]initWithFrame:CGRectMake(ViewWidth(self)/4, ViewHeight(self) - 80,ViewWidth(self)/4, 80)];
    integralBtu.titleStr = @"积分";
    integralBtu.imageStr = @"积分";
    integralBtu.selectButton = ^(NSString *title) {
        if ([mySelf.delegate respondsToSelector:@selector(pushViewControllerViewTitle:)]) {
            [mySelf.delegate pushViewControllerViewTitle:title];
        }
    };
    [self addSubview:integralBtu];
    
    MineButtonView *addressBookBtu = [[MineButtonView alloc]initWithFrame:CGRectMake(ViewWidth(self)/2, ViewHeight(self) - 80,ViewWidth(self)/4, 80)];
    addressBookBtu.titleStr = @"通讯录";
    addressBookBtu.imageStr = @"通讯录";
    addressBookBtu.selectButton = ^(NSString *title) {
        if ([mySelf.delegate respondsToSelector:@selector(pushViewControllerViewTitle:)]) {
            [mySelf.delegate pushViewControllerViewTitle:title];
        }
    };
    [self addSubview:addressBookBtu];
    
    MineButtonView *messageBtu = [[MineButtonView alloc]initWithFrame:CGRectMake(ViewWidth(self)/4*3, ViewHeight(self) - 80,ViewWidth(self)/4, 80)];
    messageBtu.titleStr = @"消息";
    messageBtu.imageStr = @"消息";
    messageBtu.selectButton = ^(NSString *title) {
        if ([mySelf.delegate respondsToSelector:@selector(pushViewControllerViewTitle:)]) {
            [mySelf.delegate pushViewControllerViewTitle:title];
        }
    };
    [self addSubview:messageBtu];
    
    UIView *lowline = [[UIView alloc]initWithFrame:CGRectMake(0, ViewHeight(self) - 10, ViewWidth(self), 10)];
    lowline.backgroundColor = Color_fafafa;
    [self addSubview:lowline];
}



- (void)changeStatus:(UIButton *)sender{
    self.stutaView.hidden = NO;
}

- (MineOnlineOrStealthView *)stutaView{
    if (!_stutaView) {
        _stutaView = [[MineOnlineOrStealthView alloc]initWithFrame:CGRectMake(ViewWidth(self) - 55, NavTopHeight + 16, 40, 40)];
        __weak typeof(self) mySelf = self;
        _stutaView.touchUpBtu = ^(NSString *status) {
            [mySelf.statuBtu setTitle:status forState:UIControlStateNormal];
        };
        [self insertSubview:_stutaView atIndex:99];
    }
    return _stutaView;
}

- (void)intoMySelfCenter{
    if (self.pushIntoMyselfCenter) {
        self.pushIntoMyselfCenter();
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
