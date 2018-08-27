//
//  FriendsDetailTimeComponentView.m
//  ArtStar
//
//  Created by abc on 5/22/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "FriendsDetailTimeComponentView.h"

@interface FriendsDetailTimeComponentView ()

@property (nonatomic,strong) UILabel *timeLab;
@property (nonatomic,strong) UILabel *locationLab;
@property (nonatomic,strong) UIButton *shareBtu;
@property (nonatomic,strong) UIButton *collectionBtu;
@property (nonatomic,strong) UIButton *zansBtu;
@property (nonatomic,strong) UIButton *commentBtu;

@end

@implementation FriendsDetailTimeComponentView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

- (void)setUI{
    
    _timeLab = [UILabel new];
    _locationLab = [UILabel new];
    _shareBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _collectionBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _commentBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _zansBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self sd_addSubviews:@[_timeLab,_locationLab,_shareBtu,_collectionBtu,_zansBtu,_commentBtu]];
    
    _timeLab.textColor = Color_999999;
    _timeLab.text = @"2018-06-23";
    _timeLab.font = FZFont(12);
    _timeLab.sd_layout.leftSpaceToView(self, 0).topSpaceToView(self, 45).widthIs(100).heightIs(20);
    
    _locationLab.textColor = Color_999999;
    _locationLab.text = @"北京";
    _locationLab.font = FZFont(12);
    _locationLab.sd_layout.leftSpaceToView(_timeLab, 15).topSpaceToView(self, 45).widthIs(150).heightIs(20);
    
    [_commentBtu setImage:Image(@"评论") forState:UIControlStateNormal];
    [_commentBtu addTarget:self action:@selector(commentClick:) forControlEvents:UIControlEventTouchUpInside];
    _commentBtu.sd_layout.rightSpaceToView(self, 0).topSpaceToView(self, 20).widthIs(20).widthIs(20);
    
    [_zansBtu setImage:Image(@"点赞") forState:UIControlStateNormal];
    [_zansBtu addTarget:self action:@selector(zansClick:) forControlEvents:UIControlEventTouchUpInside];
    _zansBtu.sd_layout.rightSpaceToView(_commentBtu, 25).topSpaceToView(self, 20).widthIs(20).widthIs(20);
    
    [_collectionBtu setImage:Image(@"collection") forState:UIControlStateNormal];
    [_collectionBtu addTarget:self action:@selector(collectionClick:) forControlEvents:UIControlEventTouchUpInside];
    _collectionBtu.sd_layout.rightSpaceToView(_zansBtu, 25).topSpaceToView(self, 20).widthIs(20).widthIs(20);
    
    [_shareBtu setImage:Image(@"分享") forState:UIControlStateNormal];
    [_shareBtu addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    _shareBtu.sd_layout.rightSpaceToView(_collectionBtu, 25).topSpaceToView(self, 20).widthIs(20).widthIs(20);
    
}

- (void)setTimeStr:(NSString *)timeStr{
    _timeStr = timeStr;
    _timeLab.text = timeStr;
    _timeLab.sd_layout.widthIs([TransformChineseToPinying stringWidthFromString:timeStr font:FZFont(12) width:kScreenWidth]);
}

- (void)setLocationStr:(NSString *)locationStr{
    _locationStr = locationStr;
    _locationLab.text = locationStr;
}

- (void)commentClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(commentAction)]) {
        [self.delegate commentAction];
    }
}

- (void)zansClick:(UIButton *)sender{
    if ([sender.currentImage isEqual:Image(@"点赞")]) {
        [sender setImage:Image(@"点赞选中") forState:UIControlStateNormal];
    }else{
        [sender setImage:Image(@"点赞") forState:UIControlStateNormal];
    }
    if ([self.delegate respondsToSelector:@selector(zansAction)]) {
        [self.delegate zansAction];
    }
}

- (void)collectionClick:(UIButton *)sender{
    if ([sender.currentImage isEqual:Image(@"collection")]) {
        [sender setImage:Image(@"shoucang") forState:UIControlStateNormal];
    }else{
        [sender setImage:Image(@"collection") forState:UIControlStateNormal];
    }
    if ([self.delegate respondsToSelector:@selector(collectionAction)]) {
        [self.delegate collectionAction];
    }
}

- (void)shareClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(shareAction)]) {
        [self.delegate shareAction];
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
