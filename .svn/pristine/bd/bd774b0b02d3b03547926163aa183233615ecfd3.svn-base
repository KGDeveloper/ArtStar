/**
 
 ArtStar
 
 Created by: KG丿轩帝 on 2018/4/28
 
 Copyright (c) 2017 My Company
 
 ☆★☆★☆★☆★☆★☆★☆★☆★☆
 ★　　│　心想　│　事成　│　　★
 ☆别╭═╮　　 ╭═╮　　 ╭═╮别☆
 ★恋│人│　　│奎│　　│幸│恋★
 ☆　│氣│　　│哥│　　│福│　☆
 ★　│超│　　│制│　　│滿│　★
 ☆别│旺│　　│作│　　│滿│别☆
 ★恋│㊣│　　│㊣│　　│㊣│恋★
 ☆　╰═╯ 天天╰═╯ 開心╰═╯　☆
 ★☆★☆★☆★☆★☆★☆★☆★☆★.
 
 */

#import "CustomTabbar.h"

@interface CustomTabbar ()

@property (nonatomic,strong) UIButton *centerBtu;

@end

@implementation CustomTabbar

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.translucent = NO;
        //MARK:--创建按钮，先不给按钮设置frame--
        _centerBtu = [UIButton buttonWithType:UIButtonTypeCustom];
        //MARK:--给按钮添加点击事件--
        [_centerBtu addTarget:self action:@selector(centerClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_centerBtu];
        
    }
    return self;
}
//MARK:--中间按钮点击事件--
- (void)centerClick{
    if ([self.mydelegate respondsToSelector:@selector(tabbar:clickCenterBtu:)]) {
        [self.mydelegate tabbar:self clickCenterBtu:_centerBtu];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    //MARK:--每个item的宽度--
    CGFloat width = self.frame.size.width/5;
    
    Class class = NSClassFromString(@"UITabBarButton");
    
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:class]) {
            CGRect frame = view.frame;
            
            int indexFromOrign = view.frame.origin.x/width;
            if (indexFromOrign >= 2) {
                indexFromOrign ++;
            }
            
            CGFloat x = indexFromOrign * width;
            view.frame = CGRectMake(x, view.frame.origin.y, width, frame.size.height);
            
            for (UIView *badgeView in view.subviews) {
                NSString *className = NSStringFromClass([badgeView class]);
                if ([className rangeOfString:@"BadgeView"].location != NSNotFound) {
                    badgeView.layer.transform = CATransform3DIdentity;
                    badgeView.layer.transform = CATransform3DMakeTranslation(-17.0, 1.0, 1.0);
                    break;
                }
            }
        }else if ([view isEqual:self.centerBtu]){
            view.frame = CGRectMake(self.frame.size.width/2 - width/2,52 - width*14/13, width, width*14/13);
        }
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if (self.isHidden == NO) {
        CGPoint newP = [self convertPoint:point toView:self.centerBtu];
        
        if ([self.centerBtu pointInside:newP withEvent:event]) {
            return self.centerBtu;
        }else{
            return [super hitTest:point withEvent:event];
        }
    }else{
        return [super hitTest:point withEvent:event];
    }
}

- (void)setCenterImage:(NSString *)centerImage{
    _centerImage = centerImage;
    [self.centerBtu setImage:Image(centerImage) forState:UIControlStateNormal];
    [self.centerBtu setImage:Image(centerImage) forState:UIControlStateHighlighted];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
