//
//  MusicFriendsInfoView.m
//  ArtStar
//
//  Created by abc on 6/4/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "MusicFriendsInfoView.h"

@interface MusicFriendsInfoView ()

@property (nonatomic,strong) UIImageView *topImage;
@property (nonatomic,strong) UILabel *nameLab;
@property (nonatomic,strong) UIButton *sexBtu;
@property (nonatomic,strong) UILabel *ageLab;
@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UIView *labView;

@end

@implementation MusicFriendsInfoView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UISwipeGestureRecognizer *topLeftSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(regcognizerAction:)];
        [topLeftSwipe setDirection:UISwipeGestureRecognizerDirectionLeft];
        [self addGestureRecognizer:topLeftSwipe];
        
        UISwipeGestureRecognizer *topRightSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(regcognizerAction:)];
        [topRightSwipe setDirection:UISwipeGestureRecognizerDirectionRight];
        [self addGestureRecognizer:topRightSwipe];
        
        [self setUI];
    }
    return self;
}
- (void)regcognizerAction:(UISwipeGestureRecognizer *)sender{
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"左滑");
    }else if (sender.direction == UISwipeGestureRecognizerDirectionLeft){
        [UIView animateWithDuration:0.5 animations:^{
            self.frame = CGRectMake(-ViewWidth(self), 0, ViewWidth(self), ViewHeight(self));
            NSLog(@"进行中");
        } completion:^(BOOL finished) {
            if (self.finishAnimalShowView) {
                self.finishAnimalShowView();
            }
        }];
    }
}

- (void)setUI{
    
    _topImage = [UIImageView new];
    _nameLab = [UILabel new];
    _sexBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _ageLab = [UILabel new];
    _titleLab = [UILabel new];
    _labView = [UIView new];
    
    [self sd_addSubviews:@[_topImage,_nameLab,_sexBtu,_ageLab,_titleLab,_labView]];
    
    _topImage.sd_layout.leftSpaceToView(self, 0).topSpaceToView(self, 0).rightSpaceToView(self, 0).heightIs(ViewHeight(self));
    
    _nameLab.text = @"轩哥哥";
    _nameLab.textColor = [UIColor whiteColor];
    _nameLab.font = SYFont(16);
    _nameLab.sd_layout.leftSpaceToView(self, 30).bottomSpaceToView(self, 120).widthIs(120).heightIs(20);
    
    [_sexBtu setImage:Image(@"girl") forState:UIControlStateNormal];
    _sexBtu.backgroundColor = [UIColor colorWithHexString:@"#FFC4C4"];
    [_sexBtu setTitle:@"85%匹配" forState:UIControlStateNormal];
    _sexBtu.titleLabel.font = SYFont(11);
    _sexBtu.layer.cornerRadius = 5;
    _sexBtu.layer.masksToBounds = YES;
    _sexBtu.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    _sexBtu.sd_layout.leftSpaceToView(_nameLab, 15).centerYEqualToView(_nameLab).widthIs(80).heightIs(15);
    
    _ageLab.text = @"28岁";
    _ageLab.textColor = [UIColor whiteColor];
    _ageLab.font = SYFont(13);
    _ageLab.sd_layout.leftSpaceToView(self, 30).topSpaceToView(_nameLab, 15).widthIs(40).heightIs(15);
    
    _titleLab.text = @"教师";
    _titleLab.textColor = [UIColor whiteColor];
    _titleLab.font = SYFont(13);
    _titleLab.sd_layout.leftSpaceToView(_ageLab, 15).topSpaceToView(_nameLab, 15).rightSpaceToView(self, 15).heightIs(15);
    
    _labView.sd_layout.leftSpaceToView(self, 30).rightSpaceToView(self, 30).topSpaceToView(_ageLab, 15).heightIs(20);
    
}

- (void)setModel:(MusicFriendsInfoViewModel *)model{
    _model = model;
    [_topImage sd_setImageWithURL:[NSURL URLWithString:model.image]];
    _nameLab.text = model.name;
    _ageLab.text = model.age;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
