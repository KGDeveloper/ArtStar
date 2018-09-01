//
//  ViewForActivity.m
//  ArtStar
//
//  Created by 文艺星球 on 2018/8/30.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "ViewForActivity.h"

@interface ViewForActivity ()

@property (nonatomic,strong) UIView *centerView;

@end

@implementation ViewForActivity

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    }
    return self;
}
// MARK: --活动弹窗--
- (void)setActivityView:(UIImage *)addImage{
    _centerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth - 60, (kScreenWidth - 60)/addImage.size.width*addImage.size.height)];
    _centerView.center = self.center;
    [self addSubview:_centerView];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:_centerView.bounds];
    imageView.image = addImage;
    [_centerView addSubview:imageView];
}
// MARK: --关闭按钮点击事件--
- (void)cancelAction{
    self.hidden = YES;
}
// MARK: --根据类型创建按钮--
- (void)setAlertType:(NSInteger)alertType{
    _alertType = alertType;
    // MARK: --判断如果是APP进入首页加载活动入口，显示关闭按钮--
    if (alertType == ActivityTypeMapShow) {
        UIButton *cancelBtu = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtu.frame = CGRectMake(ViewX(_centerView) + ViewWidth(_centerView) - 26, ViewY(_centerView) - 36, 26, 26);
        [cancelBtu setImage:Image(@"组19拷贝") forState:UIControlStateNormal];
        [cancelBtu addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelBtu];
    }
}
// MARK: --根据传入的图片创建自适应的视图--
- (void)setShowImage:(UIImage *)showImage{
    _showImage = showImage;
    [self removeAllSubviews];
    [self setActivityView:showImage];
}
// MARK: --点击视图--
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    // MARK: --如果是APP启动进入首页展示的活动入口，点击即可进入活动页面，否则判断点击区域关闭页面--
    if (_alertType == ActivityTypeMapShow) {
        if (self.mapShowPushActivityController) {
            self.mapShowPushActivityController();
            self.hidden = YES;
        }
    }else{
        if (CGRectContainsPoint(CGRectMake(ViewX(_centerView) + ViewWidth(_centerView) - 60, ViewY(_centerView), 60, 60), [[touches anyObject] locationInView:self])) {
            self.hidden = YES;
        }
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
