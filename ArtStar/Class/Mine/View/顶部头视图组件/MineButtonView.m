//
//  MineButtonView.m
//  ArtStar
//
//  Created by abc on 6/7/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "MineButtonView.h"

@interface MineButtonView ()

@property (nonatomic,strong) UIImageView *btuImag;
@property (nonatomic,strong) UILabel *btuLab;

@end

@implementation MineButtonView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setButton];
    }
    return self;
}

- (void)setButton{
    _btuImag = [UIImageView new];
    _btuLab = [UILabel new];
    
    [self sd_addSubviews:@[_btuImag,_btuLab]];
    
    _btuImag.contentMode = UIViewContentModeScaleAspectFit;
    _btuImag.sd_layout.leftSpaceToView(self,ViewWidth(self)/2 - 12).topSpaceToView(self,15).rightSpaceToView(self, ViewWidth(self)/2 - 12).heightIs(23);
    
    _btuLab.textColor = [UIColor whiteColor];
    _btuLab.font = SYFont(14);
    _btuLab.textAlignment = NSTextAlignmentCenter;
    _btuLab.sd_layout.leftSpaceToView(self, 0).topSpaceToView(_btuImag, 10).rightSpaceToView(self, 0).heightIs(15);
    
}

- (void)setImageStr:(NSString *)imageStr{
    _imageStr = imageStr;
    _btuImag.image = Image(imageStr);
}

- (void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    _btuLab.text = titleStr;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.selectButton) {
        self.selectButton(_titleStr);
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
