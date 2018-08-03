//
//  MusicChooseSexView.m
//  ArtStar
//
//  Created by abc on 5/31/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "MusicChooseSexView.h"
#import "SexButton.h"

@interface MusicChooseSexView ()

@property (nonatomic,strong) SexButton *manBtu;
@property (nonatomic,strong) SexButton *womanBtu;
@property (nonatomic,strong) SexButton *knowBtu;

@end

@implementation MusicChooseSexView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setBtu];
    }
    return self;
}

- (void)setBtu{
    __weak typeof(self) mySelf = self;
    _manBtu = [[SexButton alloc]initWithFrame:CGRectMake(50, 30, (ViewWidth(self) - 160)/3, (ViewWidth(self) - 160)/3 + 25)];
    _manBtu.titleStr = @"男生";
    _manBtu.imageStr = @"男未选择状态";
    _manBtu.tag = 101;
    _manBtu.chooseSexAction = ^(NSString *sex) {
        [mySelf changeButtonColor:mySelf.manBtu currImage:@"男 选中状态"];
        if (mySelf.chooseSexStr) {
            mySelf.chooseSexStr(sex);
        }
    };
    [self addSubview:_manBtu];
    
    _womanBtu = [[SexButton alloc]initWithFrame:CGRectMake(80 + (ViewWidth(self) - 160)/3, 30, (ViewWidth(self) - 160)/3, (ViewWidth(self) - 160)/3 + 25)];
    _womanBtu.titleStr = @"女生";
    _womanBtu.imageStr = @"女未选中状态";
    _womanBtu.tag = 102;
    _womanBtu.chooseSexAction = ^(NSString *sex) {
        [mySelf changeButtonColor:mySelf.womanBtu currImage:@"女选中状态"];
        if (mySelf.chooseSexStr) {
            mySelf.chooseSexStr(sex);
        }
    };
    [self addSubview:_womanBtu];
    
    _knowBtu = [[SexButton alloc]initWithFrame:CGRectMake(ViewWidth(self) - (ViewWidth(self) - 160)/3 - 50, 30, (ViewWidth(self) - 160)/3, (ViewWidth(self) - 160)/3 + 25)];
    _knowBtu.titleStr = @"保密";
    _knowBtu.imageStr = @"保密未选中状态";
    _knowBtu.tag = 103;
    _knowBtu.chooseSexAction = ^(NSString *sex) {
        [mySelf changeButtonColor:mySelf.knowBtu currImage:@"保密选中状态"];
        if (mySelf.chooseSexStr) {
            mySelf.chooseSexStr(sex);
        }
    };
    [self addSubview:_knowBtu];
}

- (void)changeButtonColor:(SexButton *)sender currImage:(NSString *)imageStr{
    for (id obj in self.subviews) {
        if ([obj isKindOfClass:[SexButton class]]) {
            SexButton *btu = obj;
            btu.currColor = Color_999999;
            switch (btu.tag) {
                case 101:
                    btu.imageStr = @"男未选择状态";
                    break;
                case 102:
                    btu.imageStr = @"女未选中状态";
                    break;
                default:
                    btu.imageStr = @"保密未选中状态";
                    break;
            }
            
        }
    }
    sender.currColor = Color_333333;
    sender.imageStr = imageStr;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
