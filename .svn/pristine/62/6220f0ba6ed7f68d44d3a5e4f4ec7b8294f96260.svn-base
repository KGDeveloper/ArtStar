//
//  KGLowCommentView.m
//  ArtStar
//
//  Created by abc on 5/25/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "KGLowCommentView.h"
#import "KGCommentTF.h"

@interface KGLowCommentView ()

@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) KGCommentTF *commentTF;
@property (nonatomic,strong) UIButton *zansBtu;
@property (nonatomic,strong) UIButton *commentBtu;
@property (nonatomic,strong) UIButton *shareBtu;

@end

@implementation KGLowCommentView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUI];
    }
    return self;
}

- (void)setUI{
    _line = [UIView new];
    _commentTF = [KGCommentTF new];
    _zansBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _commentBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _shareBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self sd_addSubviews:@[_line,_commentTF,_zansBtu,_commentBtu,_shareBtu]];
    
    _line.backgroundColor = Color_ededed;
    _line.sd_layout.leftSpaceToView(self, 0).topSpaceToView(self, 0).rightSpaceToView(self, 0).heightIs(1);
    
    _commentTF.placeholder = @"写一个评论 ...";
    _commentTF.font = SYFont(12);
    _commentTF.textColor = Color_333333;
    _commentTF.layer.cornerRadius = 5;
    _commentTF.layer.borderColor = Color_cccccc.CGColor;
    _commentTF.layer.borderWidth = 1;
    _commentTF.layer.masksToBounds = YES;
    _commentTF.sd_layout.leftSpaceToView(self, 15).centerYEqualToView(self).widthIs(ViewWidth(self) - 165).heightIs(30);
    
    [_shareBtu setImage:Image(@"分享") forState:UIControlStateNormal];
    [_shareBtu addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    _shareBtu.sd_layout.rightSpaceToView(self, 15).centerYEqualToView(self).widthIs(16).heightIs(16);
    
    [_commentBtu setImage:Image(@"评论") forState:UIControlStateNormal];
    [_commentBtu addTarget:self action:@selector(commentAction) forControlEvents:UIControlEventTouchUpInside];
    _commentBtu.sd_layout.rightSpaceToView(_shareBtu, 25).centerYEqualToView(self).widthIs(18).heightIs(16);
    
    [_zansBtu setImage:Image(@"点赞") forState:UIControlStateNormal];
    [_zansBtu addTarget:self action:@selector(zansAction:) forControlEvents:UIControlEventTouchUpInside];
    _zansBtu.sd_layout.rightSpaceToView(_commentBtu, 25).centerYEqualToView(self).widthIs(15).heightIs(16);
    
}

- (void)shareAction{
    if (self.actionWithTitle) {
        self.actionWithTitle(@"分享", nil);
    }
}

- (void)commentAction{
    if (self.actionWithTitle) {
        self.actionWithTitle(@"评论", _commentTF.text);
    }
    _commentTF.text = @"";
}

- (void)zansAction:(UIButton *)sender{
    if (self.actionWithTitle) {
        self.actionWithTitle(@"点赞", nil);
    }
    if ([sender.currentImage isEqual:Image(@"点赞选中")]) {
        [_zansBtu setImage:Image(@"点赞") forState:UIControlStateNormal];
    }else{
        [_zansBtu setImage:Image(@"点赞选中") forState:UIControlStateNormal];
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
