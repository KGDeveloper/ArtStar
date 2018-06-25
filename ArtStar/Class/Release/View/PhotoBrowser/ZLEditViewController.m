//
//  ZLEditViewController.m
//  ZLPhotoBrowser
//
//  Created by long on 2017/6/23.
//  Copyright © 2017年 long. All rights reserved.
//

#import "ZLEditViewController.h"
#import "ZLPhotoModel.h"
#import "ZLDefine.h"
#import "ZLPhotoManager.h"
#import "ToastUtils.h"
#import "ZLProgressHUD.h"
#import "ZLPhotoBrowser.h"

//裁剪代码借鉴与CLImageEditor github:https://github.com/yackle/CLImageEditor

#pragma mark- UI components
@interface ZLClippingCircle : UIView

@property (nonatomic, strong) UIColor *bgColor;

@end

@implementation ZLClippingCircle

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGRect rct = self.bounds;
    rct.origin.x = rct.size.width/2-rct.size.width/6;
    rct.origin.y = rct.size.height/2-rct.size.height/6;
    rct.size.width /= 3;
    rct.size.height /= 3;
    
    CGContextSetFillColorWithColor(context, self.bgColor.CGColor);
    CGContextFillEllipseInRect(context, rct);
}

@end

//!!!!: ZLRatio
@interface ZLRatio : NSObject
@property (nonatomic, assign) BOOL isLandscape;
@property (nonatomic, readonly) CGFloat ratio;
@property (nonatomic, strong) NSString *titleFormat;

- (id)initWithValue1:(CGFloat)value1 value2:(CGFloat)value2;

@end

@implementation ZLRatio
{
    CGFloat _longSide;
    CGFloat _shortSide;
}

- (id)initWithValue1:(CGFloat)value1 value2:(CGFloat)value2
{
    self = [super init];
    if(self){
        _longSide  = MAX(fabs(value1), fabs(value2));
        _shortSide = MIN(fabs(value1), fabs(value2));
    }
    return self;
}

- (NSString*)description
{
    NSString *format = (self.titleFormat) ? self.titleFormat : @"%g : %g";
    
    if(self.isLandscape){
        return [NSString stringWithFormat:format, _longSide, _shortSide];
    }
    return [NSString stringWithFormat:format, _shortSide, _longSide];
}

- (CGFloat)ratio
{
    if(_longSide==0 || _shortSide==0){
        return 0;
    }
    
    if(self.isLandscape){
        return _shortSide / (CGFloat)_longSide;
    }
    return _longSide / (CGFloat)_shortSide;
}

@end

//!!!!: ZLRatioMenuItem
@interface ZLRatioMenuItem : UIView
{
    UIImageView *_iconView;
    UILabel *_titleLabel;
}
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) ZLRatio *ratio;
- (void)changeOrientation;
@end

@implementation ZLRatioMenuItem

- (id)initWithFrame:(CGRect)frame target:(id)target action:(SEL)action
{
    self = [self initWithFrame:frame];
    if(self){
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
        [self addGestureRecognizer:gesture];
        
        CGFloat W = frame.size.width;
        _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, W-20, W-20)];
        _iconView.clipsToBounds = YES;
        _iconView.layer.cornerRadius = 5;
        _iconView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_iconView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_iconView.frame) + 5, W, 15)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = kRGB(18, 18, 18);
        _titleLabel.font = [UIFont systemFontOfSize:10];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
    }
    return self;
}

- (void)setRatio:(ZLRatio *)ratio
{
    if(ratio != _ratio){
        _ratio = ratio;
    }
}

- (void)refreshViews
{
    _titleLabel.text = [_ratio description];
    
    CGPoint center = _iconView.center;
    CGFloat W, H;
    if(_ratio.ratio!=0){
        if(_ratio.isLandscape){
            W = 50;
            H = 50*_ratio.ratio;
        }
        else{
            W = 50/_ratio.ratio;
            H = 50;
        }
    }
    else{
        CGFloat maxW  = MAX(_iconView.image.size.width, _iconView.image.size.height);
        W = 50 * _iconView.image.size.width / maxW;
        H = 50 * _iconView.image.size.height / maxW;
    }
    _iconView.frame = CGRectMake(center.x-W/2, center.y-H/2, W, H);
}

- (void)changeOrientation
{
    self.ratio.isLandscape = !self.ratio.isLandscape;
    
    [UIView animateWithDuration:0.2 animations:^{
        [self refreshViews];
    }];
}

@end

@interface ZLGridLayar : CALayer
@property (nonatomic, assign) CGRect clippingRect;
@property (nonatomic, strong) UIColor *bgColor;
@property (nonatomic, strong) UIColor *gridColor;

@end

@implementation ZLGridLayar

+ (BOOL)needsDisplayForKey:(NSString*)key
{
    if ([key isEqualToString:@"clippingRect"]) {
        return YES;
    }
    return [super needsDisplayForKey:key];
}

- (id)initWithLayer:(id)layer
{
    self = [super initWithLayer:layer];
    if(self && [layer isKindOfClass:[ZLGridLayar class]]){
        self.bgColor   = ((ZLGridLayar *)layer).bgColor;
        self.gridColor = ((ZLGridLayar *)layer).gridColor;
        self.clippingRect = ((ZLGridLayar *)layer).clippingRect;
    }
    return self;
}

- (void)drawInContext:(CGContextRef)context
{
    CGRect rct = self.bounds;
    CGContextSetFillColorWithColor(context, self.bgColor.CGColor);
    CGContextFillRect(context, rct);
    
    CGContextClearRect(context, _clippingRect);
    
    CGContextSetStrokeColorWithColor(context, self.gridColor.CGColor);
    CGContextSetLineWidth(context, 1);
    
    rct = self.clippingRect;
    
    CGContextBeginPath(context);
    CGFloat dW = 0;
    for(int i=0;i<4;++i){
        CGContextMoveToPoint(context, rct.origin.x+dW, rct.origin.y);
        CGContextAddLineToPoint(context, rct.origin.x+dW, rct.origin.y+rct.size.height);
        dW += _clippingRect.size.width/3;
    }
    
    dW = 0;
    for(int i=0;i<4;++i){
        CGContextMoveToPoint(context, rct.origin.x, rct.origin.y+dW);
        CGContextAddLineToPoint(context, rct.origin.x+rct.size.width, rct.origin.y+dW);
        dW += rct.size.height/3;
    }
    CGContextStrokePath(context);
}

@end

//!!!!: edit vc
@interface ZLEditViewController ()
{
    UIImageView *_imageView;
    UIActivityIndicatorView *_indicator;
    
    ZLGridLayar *_gridLayer;
    ZLClippingCircle *_ltView;
    ZLClippingCircle *_lbView;
    ZLClippingCircle *_rtView;
    ZLClippingCircle *_rbView;
    
    UIView *_bottomView;
    UIButton *_cancelBtn;
    UIButton *_saveBtn;
    UIButton *_doneBtn;
    
    //旋转比例按钮
//    UIButton *_rotateBtn;
    //比例底滚动视图
//    UIScrollView *_menuScroll;
}

//@property (nonatomic, strong) ZLRatioMenuItem *selectedMenu;
@property (nonatomic, assign) CGRect clippingRect;
@property (nonatomic, strong) ZLRatio *clippingRatio;

@end

@implementation ZLEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarHidden = YES;
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    UIEdgeInsets inset = UIEdgeInsetsZero;
    if (@available(iOS 11, *)) {
        inset = self.view.safeAreaInsets;
    }
    
    BOOL hideClipRatioView = [self shouldHideClipRatioView];
    //隐藏时 底部工具条高44，间距设置4即可，不隐藏时，比例view高度80，则为128
    CGFloat flag = hideClipRatioView ? 48 : 128;
    
    CGFloat w = kViewWidth-20;
    CGFloat maxH = kViewHeight-flag-inset.bottom-inset.top-50;
    CGFloat h = w * self.model.asset.pixelHeight / self.model.asset.pixelWidth;
    if (h > maxH) {
        h = maxH;
        w = h * self.model.asset.pixelWidth / self.model.asset.pixelHeight;
    }
    _imageView.frame = CGRectMake((kViewWidth-w)/2, (kViewHeight-flag-h)/2, w, h);
    _gridLayer.frame = _imageView.bounds;
    [self clippingRatioDidChange];
    
    CGFloat bottomViewH = 44;
    CGFloat bottomBtnH = 30;
    
    _bottomView.frame = CGRectMake(0, kViewHeight-bottomViewH-inset.bottom, kViewWidth, bottomViewH);
    _cancelBtn.frame = CGRectMake(10+inset.left, 7, GetMatchValue(GetLocalLanguageTextValue(ZLPhotoBrowserCancelText), 15, YES, bottomBtnH), bottomBtnH);
    _saveBtn.frame = CGRectMake(kViewWidth/2-20, 7, 40, bottomBtnH);
    _doneBtn.frame = CGRectMake(kViewWidth-70-inset.right, 7, 60, bottomBtnH);
    
    _indicator.center = _imageView.center;
}

//当裁剪比例只有 custom 或者 1:1 的时候隐藏比例视图
- (BOOL)shouldHideClipRatioView
{
    ZLImageNavigationController *nav = (ZLImageNavigationController *)self.navigationController;
    if (nav.clipRatios.count <= 1) {
        NSInteger value1 = [nav.clipRatios.firstObject[ClippingRatioValue1] integerValue];
        NSInteger value2 = [nav.clipRatios.firstObject[ClippingRatioValue2] integerValue];
        if ((value1==0 && value2==0) || (value1==1 && value2==1)) {
            return YES;
        }
    }
    return NO;
}

- (void)initUI
{
    self.view.backgroundColor = [UIColor blackColor];
    //禁用返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
    [self creatBottomView];
    [self setCropMenu];
    [self loadImage];
    
    _gridLayer = [[ZLGridLayar alloc] init];
    _gridLayer.bgColor   = [[UIColor blackColor] colorWithAlphaComponent:.5];
    _gridLayer.gridColor = [UIColor whiteColor];
    [_imageView.layer addSublayer:_gridLayer];
    
    _ltView = [self clippingCircleWithTag:0];
    _lbView = [self clippingCircleWithTag:1];
    _rtView = [self clippingCircleWithTag:2];
    _rbView = [self clippingCircleWithTag:3];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGridView:)];
    _imageView.userInteractionEnabled = YES;
    [_imageView addGestureRecognizer:panGesture];
}

- (void)creatBottomView
{
    ZLImageNavigationController *nav = (ZLImageNavigationController *)self.navigationController;
    //下方视图
    _bottomView = [[UIView alloc] init];
    _bottomView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.7];
    [self.view addSubview:_bottomView];
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_cancelBtn setTitle:GetLocalLanguageTextValue(ZLPhotoBrowserCancelText) forState:UIControlStateNormal];
    [_cancelBtn addTarget:self action:@selector(cancelBtn_click) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_cancelBtn];
    
    _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _saveBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_saveBtn setTitle:GetLocalLanguageTextValue(ZLPhotoBrowserSaveText) forState:UIControlStateNormal];
    [_saveBtn addTarget:self action:@selector(saveBtn_click) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_saveBtn];
    
    _doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_doneBtn setTitle:GetLocalLanguageTextValue(ZLPhotoBrowserDoneText) forState:UIControlStateNormal];
    [_doneBtn setBackgroundColor:nav.bottomBtnsNormalTitleColor];
    [_doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _doneBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    _doneBtn.layer.masksToBounds = YES;
    _doneBtn.layer.cornerRadius = 3.0f;
    [_doneBtn addTarget:self action:@selector(btnDone_click) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_doneBtn];
}

- (void)loadImage
{
    //imageview
    _imageView = [[UIImageView alloc] init];
    _imageView.image = self.oriImage;
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_imageView];
    
    _indicator = [[UIActivityIndicatorView alloc] init];
    _indicator.center = _imageView.center;
    _indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    _indicator.hidesWhenStopped = YES;
    [self.view addSubview:_indicator];
    
    CGFloat scale = 3;
    CGFloat width = MIN(kViewWidth, kMaxImageWidth);
    CGSize size = CGSizeMake(width*scale, width*scale*self.model.asset.pixelHeight/self.model.asset.pixelWidth);
    
    [_indicator startAnimating];
    zl_weakify(self);
    [ZLPhotoManager requestImageForAsset:self.model.asset size:size completion:^(UIImage *image, NSDictionary *info) {
        if (![[info objectForKey:PHImageResultIsDegradedKey] boolValue]) {
            zl_strongify(weakSelf);
            [strongSelf->_indicator stopAnimating];
            strongSelf->_imageView.image = image;
//
//            CGFloat W = 70;
//            CGSize  imgSize = image.size;
//            CGFloat maxW = MIN(imgSize.width, imgSize.height);
//            UIImage *iconImage = [strongSelf scaleImage:image toSize:CGSizeMake(W * imgSize.width/maxW, W * imgSize.height/maxW)];
        }
    }];
}

- (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  newImage;
}

- (void)setCropMenu
{
    //旋转按钮
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.8];
    [self.view addSubview:view];
    
    CGFloat W = 70;
    CGFloat x = 0;
    
    ZLImageNavigationController *nav = (ZLImageNavigationController *)self.navigationController;
    //如需要其他比例，请按照格式自行设置
    NSArray *ratios = nav.clipRatios;
    
    for(NSDictionary *info in ratios){
        CGFloat val1 = [info[@"value1"] floatValue];
        CGFloat val2 = [info[@"value2"] floatValue];
        
        ZLRatio *ratio = [[ZLRatio alloc] initWithValue1:val1 value2:val2];
        ratio.titleFormat = info[@"titleFormat"];
        
        ratio.isLandscape = NO;
        x += W;
    }
}

- (void)setClippingRatio:(ZLRatio *)clippingRatio
{
    if(clippingRatio != _clippingRatio){
        _clippingRatio = clippingRatio;
        [self clippingRatioDidChange];
    }
}

- (void)clippingRatioDidChange
{
    CGRect rect;
    CGFloat x;
    CGFloat y;
    CGFloat width;
    CGFloat height;
    BOOL isTrue;
    if (_imageView.bounds.size.width > _imageView.bounds.size.height) {
        isTrue = YES;
    }else{
        isTrue = NO;
    }
    switch ([self returnClipTypeFrameNSUserDefaults]) {
        case CliptypeH://水平115:78
            width = _imageView.bounds.size.width - 100;
            height = width/115*78;
            if (height > _imageView.bounds.size.height) {
                height = _imageView.bounds.size.height;
                width = _imageView.bounds.size.height/115*78;
                y = (_imageView.bounds.size.height - height)/2;
                x = (_imageView.bounds.size.width - width)/2;
            }else{
                y = (_imageView.bounds.size.height - height)/2;
                x = (_imageView.bounds.size.width - width)/2;
            }
            break;
        case CliptypeV://15:23
            width = _imageView.bounds.size.width - 100;
            height = width/15*23;
            if (height > _imageView.bounds.size.height) {
                height = _imageView.bounds.size.height;
                width = _imageView.bounds.size.height/23*15;
                y = (_imageView.bounds.size.height - height)/2;
                x = (_imageView.bounds.size.width - width)/2;
            }else{
                y = (_imageView.bounds.size.height - height)/2;
                x = (_imageView.bounds.size.width - width)/2;
            }
            break;
        default://1:1
            width = _imageView.bounds.size.width - 100;
            height = width;
            if (height > _imageView.bounds.size.height) {
                height = _imageView.bounds.size.height;
                width = _imageView.bounds.size.height;
                y = (_imageView.bounds.size.height - height)/2;
                x = (_imageView.bounds.size.width - width)/2;
            }else{
                y = (_imageView.bounds.size.height - height)/2;
                x = (_imageView.bounds.size.width - width)/2;
            }
            break;
    }
    [self setClippingRect:CGRectMake(x, y, width, height) animated:YES];
}
//MARK:--根据闯过来的参数确定点击的是那种类型的裁剪方式--
- (Cliptype)returnClipTypeFrameNSUserDefaults{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"ChangeImageClipType"] isEqualToString:@"圆形"]) {
        return CliptypeR;
    }else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"ChangeImageClipType"] isEqualToString:@"横向"]){
        return CliptypeH;
    }else{
        return CliptypeV;
    }
}

- (void)setClippingRect:(CGRect)clippingRect animated:(BOOL)animated
{
    if (animated) {
        [UIView animateWithDuration:0.2 animations:^{
            self->_ltView.center = [self.view convertPoint:CGPointMake(clippingRect.origin.x, clippingRect.origin.y) fromView:self->_imageView];
            self->_lbView.center = [self.view convertPoint:CGPointMake(clippingRect.origin.x, clippingRect.origin.y+clippingRect.size.height) fromView:self->_imageView];
            self->_rtView.center = [self.view convertPoint:CGPointMake(clippingRect.origin.x+clippingRect.size.width, clippingRect.origin.y) fromView:self->_imageView];
            self->_rbView.center = [self.view convertPoint:CGPointMake(clippingRect.origin.x+clippingRect.size.width, clippingRect.origin.y+clippingRect.size.height) fromView:self->_imageView];
                         }
         ];
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"clippingRect"];
        animation.duration = 0.2;
        animation.fromValue = [NSValue valueWithCGRect:_clippingRect];
        animation.toValue = [NSValue valueWithCGRect:clippingRect];
        [_gridLayer addAnimation:animation forKey:nil];
        
        _gridLayer.clippingRect = clippingRect;
        _clippingRect = clippingRect;
        [_gridLayer setNeedsDisplay];
    } else {
        self.clippingRect = clippingRect;
    }
}

- (ZLClippingCircle*)clippingCircleWithTag:(NSInteger)tag
{
    ZLClippingCircle *view = [[ZLClippingCircle alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    view.backgroundColor = [UIColor clearColor];
    view.bgColor = [UIColor whiteColor];
    view.tag = tag;
    
    [self.view addSubview:view];
    
    return view;
}

- (void)setClippingRect:(CGRect)clippingRect
{
    _clippingRect = clippingRect;
    
    _ltView.center = [self.view convertPoint:CGPointMake(_clippingRect.origin.x, _clippingRect.origin.y) fromView:_imageView];
    _lbView.center = [self.view convertPoint:CGPointMake(_clippingRect.origin.x, _clippingRect.origin.y+_clippingRect.size.height) fromView:_imageView];
    _rtView.center = [self.view convertPoint:CGPointMake(_clippingRect.origin.x+_clippingRect.size.width, _clippingRect.origin.y) fromView:_imageView];
    _rbView.center = [self.view convertPoint:CGPointMake(_clippingRect.origin.x+_clippingRect.size.width, _clippingRect.origin.y+_clippingRect.size.height) fromView:_imageView];
    
    _gridLayer.clippingRect = clippingRect;
    [_gridLayer setNeedsDisplay];
}

- (void)panGridView:(UIPanGestureRecognizer*)sender
{
    static BOOL dragging = NO;
    static CGRect initialRect;
    
    if (sender.state==UIGestureRecognizerStateBegan) {
        CGPoint point = [sender locationInView:_imageView];
        dragging = CGRectContainsPoint(_clippingRect, point);
        initialRect = self.clippingRect;
    } else if(dragging) {
        CGPoint point = [sender translationInView:_imageView];
        CGFloat left  = MIN(MAX(initialRect.origin.x + point.x, 0), _imageView.frame.size.width-initialRect.size.width);
        CGFloat top   = MIN(MAX(initialRect.origin.y + point.y, 0), _imageView.frame.size.height-initialRect.size.height);
        
        CGRect rct = self.clippingRect;
        rct.origin.x = left;
        rct.origin.y = top;
        self.clippingRect = rct;
    }
}

#pragma mark - action
- (void)cancelBtn_click
{
    ZLImageNavigationController *nav = (ZLImageNavigationController *)self.navigationController;
    if (nav.editAfterSelectThumbnailImage &&
        nav.maxSelectCount == 1) {
        [nav.arrSelectedModels removeAllObjects];
    }
    UIViewController *vc = [self.navigationController popViewControllerAnimated:NO];
    if (!vc) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)saveBtn_click
{
    //保存到相册
    ZLProgressHUD *hud = [[ZLProgressHUD alloc] init];
    [hud show];
    [ZLPhotoManager saveImageToAblum:[self clipImage] completion:^(BOOL suc, PHAsset *asset) {
        [hud hide];
        if (!suc) {
            ShowToastLong(@"%@", GetLocalLanguageTextValue(ZLPhotoBrowserSaveImageErrorText));
        }
    }];
}

- (void)btnDone_click
{
    //确定裁剪，返回
    ZLImageNavigationController *nav = (ZLImageNavigationController *)self.navigationController;
    if (nav.callSelectClipImageBlock) {
        nav.callSelectClipImageBlock([self clipImage], self.model.asset);
    }
}

- (UIImage *)clipImage
{
    CGFloat zoomScale = _imageView.bounds.size.width / _imageView.image.size.width;
    CGRect rct = self.clippingRect;
    rct.size.width  /= zoomScale;
    rct.size.height /= zoomScale;
    rct.origin.x    /= zoomScale;
    rct.origin.y    /= zoomScale;
    
    CGPoint origin = CGPointMake(-rct.origin.x, -rct.origin.y);
    UIImage *img = nil;
    
    UIGraphicsBeginImageContextWithOptions(rct.size, NO, _imageView.image.scale);
    [_imageView.image drawAtPoint:origin];
    img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

@end