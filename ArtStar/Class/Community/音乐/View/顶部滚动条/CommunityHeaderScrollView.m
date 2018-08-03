//
//  CommunityHeaderScrollView.m
//  ArtStar
//
//  Created by abc on 5/23/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "CommunityHeaderScrollView.h"

@interface CommunityHeaderScrollView ()

@property (nonatomic,strong) UIScrollView *scrollerView;
@property (nonatomic,assign) BOOL isSelectRightBtu;
@property (nonatomic,copy) NSString *type;

@end

@implementation CommunityHeaderScrollView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        _isSelectRightBtu = NO;
        [self setUI];
    }
    return self;
}

- (void)setUI{
    
    self.scrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth(self) - 53, ViewHeight(self))];
    self.scrollerView.showsVerticalScrollIndicator = NO;
    self.scrollerView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.scrollerView];
    
    UIButton *rightBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtu.frame = CGRectMake(ViewWidth(self) - 53, 7, 38, 26);
    [rightBtu setImage:Image(@"screen") forState:UIControlStateNormal];
    [rightBtu addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rightBtu];
}

- (void)rightClick{
    if (self.rightAction) {
        self.rightAction(self.type);
    }
}

- (void)setItemArr:(NSArray *)itemArr{
    _itemArr = itemArr;
    
    self.scrollerView.contentSize = CGSizeMake(70 *itemArr.count, ViewHeight(self));
    
    for (int i = 0 ; i < itemArr.count; i++) {
        if (i == 0) {
            [self.scrollerView addSubview:[self createButtonWithFrame:CGRectMake(0, 10, 50, 25) title:itemArr[i] font:SYFont(15) color:Color_333333]];
        }else{
            [self.scrollerView addSubview:[self createButtonWithFrame:CGRectMake(70*i, 10, 50, 25) title:itemArr[i] font:SYFont(14) color:Color_999999]];
        }
    }
}

- (UIButton *)createButtonWithFrame:(CGRect)frame title:(NSString *)title font:(UIFont *)font color:(UIColor *)color{
    UIButton *titleBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    titleBtu.frame = frame;
    [titleBtu setTitle:title forState:UIControlStateNormal];
    [titleBtu setTitleColor:color forState:UIControlStateNormal];
    titleBtu.titleLabel.font = font;
    [titleBtu addTarget:self action:@selector(titleBtuClick:) forControlEvents:UIControlEventTouchUpInside];
    return titleBtu;
}

- (void)titleBtuClick:(UIButton *)sender{
    for (id obj in self.scrollerView.subviews) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *normalBtu = obj;
            [normalBtu setTitleColor:Color_999999 forState:UIControlStateNormal];
            normalBtu.titleLabel.font = SYFont(14);
        }
    }
    [sender setTitleColor:Color_333333 forState:UIControlStateNormal];
    sender.titleLabel.font = SYFont(15);
    if (self.titleAction) {
        self.titleAction(sender.currentTitle);
    }
    _type = sender.currentTitle;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
