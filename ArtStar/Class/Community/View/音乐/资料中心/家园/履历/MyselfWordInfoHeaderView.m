//
//  MyselfWordInfoHeaderView.m
//  ArtStar
//
//  Created by abc on 6/1/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "MyselfWordInfoHeaderView.h"

@interface MyselfWordInfoHeaderView ()

@property (nonatomic,strong) UIImageView *topImage;
@property (nonatomic,strong) UIView *titleView;
@property (nonatomic,assign) CGFloat changeHeight;

@end

@implementation MyselfWordInfoHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

- (void)setUI{
    
    _topImage = [UIImageView new];
    _titleView = [UIView new];
    
    [self sd_addSubviews:@[_topImage,_titleView]];
    
    _topImage.sd_layout.leftSpaceToView(self, 15).rightSpaceToView(self, 15).topSpaceToView(self, 30).heightIs((ViewWidth(self) - 30)/690*720);
    
    _titleView.sd_layout.topSpaceToView(_topImage, 20).leftSpaceToView(self, 15).rightSpaceToView(self, 15).heightIs(15);
    
}

- (void)setImageStr:(NSString *)imageStr{
    _imageStr = imageStr;
    [_topImage sd_setImageWithURL:[NSURL URLWithString:imageStr]];
}

- (void)setTitleArr:(NSArray *)titleArr{
    _titleArr = titleArr;
    CGFloat height = 0;
    CGFloat viewHeight = 0;
    for (int i = 0; i < titleArr.count; i++) {
        CGFloat nmbLine =  [TransformChineseToPinying string:titleArr[i] font:SYFont(15) space:15].size.width;
        if ((long)(nmbLine/(ViewWidth(self) - 30)) > 0) {
            height = (long)(nmbLine/(ViewWidth(self) - 30))*30 + 15;
        }else{
            height = 15;
        }
        
        UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0,viewHeight, ViewWidth(self) - 30, height)];
        titleLab.attributedText = [TransformChineseToPinying string:titleArr[i] font:SYFont(15) space:15];
        titleLab.textColor = Color_333333;
        titleLab.font = SYFont(15);
        titleLab.numberOfLines = 0;
        titleLab.lineBreakMode = NSLineBreakByCharWrapping;
        [_titleView addSubview:titleLab];
        
        viewHeight = viewHeight + height + 15;
    }
    _titleView.sd_layout.topSpaceToView(_topImage, 20).leftSpaceToView(self, 15).rightSpaceToView(self, 15).heightIs(viewHeight);
    _changeHeight = viewHeight + (ViewWidth(self) - 30)/690*720 + 50;
    self.frame = CGRectMake(0, 0, ViewWidth(self), _changeHeight);
    [self setNeedsLayout];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
