//
//  MineCardLoadFriendCoverView.m
//  ArtStar
//
//  Created by abc on 6/12/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "MineCardLoadFriendCoverView.h"

@interface MineCardLoadFriendCoverView ()

@property (nonatomic,strong) UIImageView *lowImage;
@property (nonatomic,strong) UIImageView *headerImage;
@property (nonatomic,strong) UIButton *returnBtu;
@property (nonatomic,strong) UILabel *signatureLab;
@property (nonatomic,strong) UILabel *nikNameLab;


@end

@implementation MineCardLoadFriendCoverView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setCoverView];
    }
    return self;
}

- (void)setCoverView{
    
    _returnBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _lowImage = [UIImageView new];
    _headerImage = [UIImageView new];
    _signatureLab = [UILabel new];
    _nikNameLab = [UILabel new];
    
    [self sd_addSubviews:@[_lowImage,_returnBtu,_headerImage,_signatureLab,_nikNameLab]];
    
    _lowImage.sd_layout.leftEqualToView(self).topEqualToView(self).rightEqualToView(self).heightIs(ViewHeight(self) - 70);
    
    
    [_returnBtu setImage:Image(@"back") forState:UIControlStateNormal];
    [_returnBtu addTarget:self action:@selector(popToRootView) forControlEvents:UIControlEventTouchUpInside];
    _returnBtu.imageEdgeInsets = UIEdgeInsetsMake(7.5, 0, 7.5, 43);
    _returnBtu.sd_layout.leftSpaceToView(self, 15).topSpaceToView(self,NavTopHeight - 44 + 10).widthIs(50).heightIs(30);
    
    [_headerImage sd_setImageWithURL:[NSURL URLWithString:[KGUserInfo shareInterace].portraitUri] placeholderImage:Image(@"1")];
    _headerImage.layer.cornerRadius = 37.5;
    _headerImage.layer.borderColor = [UIColor whiteColor].CGColor;
    _headerImage.layer.borderWidth = 2;
    _headerImage.layer.masksToBounds = YES;
    _headerImage.sd_layout.rightSpaceToView(self, 15).bottomSpaceToView(self,50).widthIs(75).heightIs(75);
    
    _nikNameLab.text = [KGUserInfo shareInterace].userName;
    _nikNameLab.textColor = [UIColor whiteColor];
    _nikNameLab.font = SYFont(15);
    _nikNameLab.textAlignment = NSTextAlignmentRight;
    _nikNameLab.shadowColor = Color_333333;
    _nikNameLab.shadowOffset = CGSizeMake(0, 2);
    _nikNameLab.layer.shadowOpacity = 1;
    _nikNameLab.layer.shadowRadius = 90;
    _nikNameLab.sd_layout.rightSpaceToView(_headerImage, 10).leftSpaceToView(self, 15).heightIs(15).bottomSpaceToView(self, 75);
    
    _signatureLab.text = [KGUserInfo shareInterace].personSignature;
    _signatureLab.textColor = Color_333333;
    _signatureLab.font = SYFont(11);
    _signatureLab.numberOfLines = 2;
    _signatureLab.textAlignment = NSTextAlignmentRight;
    _signatureLab.sd_layout.rightSpaceToView(self, 15).leftSpaceToView(self, 35).topSpaceToView(_headerImage, 10).heightIs(30);
    
}

- (void)setCoverImage:(NSString *)coverImage{
    _coverImage = coverImage;
    [_lowImage sd_setImageWithURL:[NSURL URLWithString:coverImage]];
}

- (void)popToRootView{
    if (self.popRootViewController) {
        self.popRootViewController();
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
