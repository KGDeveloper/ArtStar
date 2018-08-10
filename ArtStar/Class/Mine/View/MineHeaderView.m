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
        [_backImage sd_setImageWithURL:[NSURL URLWithString:[KGUserInfo shareInterace].portraitUri]];
        _backImage.alpha = 0.2;
        [self addSubview:_backImage];
        [self setHeaderView];
    }
    return self;
}

- (void)setHeaderView{
    
    _headerImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, NavTopHeight - 4, 60, 60)];
    [_headerImage sd_setImageWithURL:[NSURL URLWithString:[KGUserInfo shareInterace].portraitUri]];
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
    if ([[KGUserInfo shareInterace].userState integerValue] == 0) {
        [_statuBtu setTitle:@"在线" forState:UIControlStateNormal];
    }else if ([[KGUserInfo shareInterace].userState integerValue] == 1){
        [_statuBtu setTitle:@"隐身" forState:UIControlStateNormal];
    }
    _statuBtu.titleLabel.font = SYFont(11);
    [_statuBtu addTarget:self action:@selector(changeStatus:) forControlEvents:UIControlEventTouchUpInside];
    _statuBtu.backgroundColor = [UIColor colorWithRed:211/255.0 green:211/255.0 blue:211/255.0 alpha:0.1];
    _statuBtu.layer.cornerRadius = 10;
    _statuBtu.layer.masksToBounds = YES;
    [self addSubview:_statuBtu];
    
    _nameLab = [[UILabel alloc]initWithFrame:CGRectMake(15, NavTopHeight + 71, 120, 15)];
    _nameLab.textColor = [UIColor whiteColor];
    _nameLab.font = SYFont(15);
    _nameLab.text = [KGUserInfo shareInterace].userName;
    [self addSubview:_nameLab];
    
    _ageBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _ageBtu.frame = CGRectMake(25 + [TransformChineseToPinying stringWidthFromString:[KGUserInfo shareInterace].userName font:SYFont(15) width:ViewWidth(self)], NavTopHeight + 71, 40, 15);
    [_ageBtu setTitle:[NSString stringWithFormat:@"%@",[KGUserInfo shareInterace].userAge] forState:UIControlStateNormal];
    _ageBtu.titleLabel.font = SYFont(11);
    [_ageBtu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    if ([[KGUserInfo shareInterace].userSex integerValue] == 0) {
        [_ageBtu setImage:Image(@"girl") forState:UIControlStateNormal];
        _ageBtu.backgroundColor = Color_Girl;
    }else if ([[KGUserInfo shareInterace].userSex integerValue] == 1){
        [_ageBtu setImage:Image(@"man") forState:UIControlStateNormal];
        _ageBtu.backgroundColor = Color_Boy;
    }
    [_ageBtu setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    _ageBtu.layer.cornerRadius = 2;
    _ageBtu.layer.masksToBounds = YES;
    [self addSubview:_ageBtu];
    
    _signatureLab = [[UILabel alloc]initWithFrame:CGRectMake(15, NavTopHeight + 101, ViewWidth(self) - 30, 15)];
    _signatureLab.textColor = [UIColor whiteColor];
    _signatureLab.font = SYFont(11);
    _signatureLab.text = [KGUserInfo shareInterace].personSignature;
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
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"MineAlertImage"]) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(90, NavTopHeight - 4 + 17, 106, 25)];
        imageView.image = Image(@"提示语");
        [self addSubview:imageView];
    }
}



- (void)changeStatus:(UIButton *)sender{
    self.stutaView.hidden = NO;
}

- (MineOnlineOrStealthView *)stutaView{
    if (!_stutaView) {
        _stutaView = [[MineOnlineOrStealthView alloc]initWithFrame:CGRectMake(ViewWidth(self) - 55, NavTopHeight + 16, 40, 40)];
        __weak typeof(self) mySelf = self;
        _stutaView.touchUpBtu = ^(NSString *status) {
            [mySelf changeStatusWithStatus:status];
        };
        [self insertSubview:_stutaView atIndex:99];
    }
    return _stutaView;
}
- (void)changeStatusWithStatus:(NSString *)status{
    __weak typeof(self) weakSelf = self;
//    KGRequestNetWorking postWothUrl:<#(NSString *)#> parameters:<#(NSDictionary *)#> succ:<#^(id result)succ#> fail:<#^(NSError *error)fail#>
//    [mySelf.statuBtu setTitle:status forState:UIControlStateNormal];
}
- (void)intoMySelfCenter{
    if (self.pushIntoMyselfCenter) {
        self.pushIntoMyselfCenter();
    }
    [[NSUserDefaults standardUserDefaults] setObject:@"MineAlertImage" forKey:@"MineAlertImage"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
