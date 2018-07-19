//
//  ChangeTheModelView.m
//  ArtStar
//
//  Created by abc on 5/8/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "ChangeTheModelView.h"
#import "ChangeModelView.h"
#import "ChooseModelVC.h"
#import <Photos/Photos.h>
#import "ReleaseChooseThemeTypeView.h"

typedef NS_ENUM(NSInteger,TextFieldTextType){
    TextFieldTextTypeLeft,
    TextFieldTextTypeCenter,
    TextFieldTextTypeRight,
};

@interface ChangeTheModelView ()<UITextFieldDelegate,KGAlertViewDelegate,ChangeModelViewDelegate,KGCameraDelegate,UITextViewDelegate>

@property (nonatomic,strong) ChangeModelView *ideaView;
//MARK:--输入框模块--
@property (nonatomic,strong) UIView *textView;//:--加载输入框视图--
@property (nonatomic,strong)UITextField *firstTextField;//:--第一行--
@property (nonatomic,strong)UITextField *sencedTF;//:--第二行--
@property (nonatomic,strong)UITextField *thirdTF;//:--第三行--
@property (nonatomic,strong)UITextField *fouceTF;//:--第四行--
@property (nonatomic,strong)UITextField *fifthTF;//:--第五行--
//MARK:--选择相片模块--
@property (nonatomic,strong) UIView *photoView;
@property (nonatomic,strong) UIImageView *pictureView;//:--展示图片--
@property (nonatomic,strong) UIButton *touchBtu;//:--选择相片--
@property (nonatomic,strong) UILabel *countLab;
@property (nonatomic,strong) UIView *labMaskView;
//MARK:--位置以及可见范围模块--
@property (nonatomic,strong) UIView *lowView;//:--加载位置以及可见人群视图--
@property (nonatomic,strong) UIButton *locationBtu;//:--选择位置--
@property (nonatomic,strong) UIButton *publicBtu;//:--可见范围--

@property (nonatomic,strong) KGAlertView *alert;
@property (nonatomic,strong) IrregularView *irregularView;//:--选择可见人群--
@property (nonatomic,strong) UIView *backView;

//MARK:--竖排文字--
@property (nonatomic,strong) UIView *vertivalView;
@property (nonatomic,strong)UITextView *oneTF;//:--第一行--
@property (nonatomic,strong)UITextView *twoTF;//:--第一行--
@property (nonatomic,strong)UITextView *threeTF;//:--第一行--
@property (nonatomic,strong)UITextView *fourTF;//:--第一行--
@property (nonatomic,strong)UITextView *fiveTF;//:--第一行--
@property (nonatomic,strong)UILabel *placehodelLab;
@property (nonatomic,assign) EditType type;
@property (nonatomic,strong) KGCamera *cameraView;

@property (nonatomic,strong) NSMutableArray *imageArr;
@property (nonatomic,strong) CustomTextField *titleTF;

@property (nonatomic,copy) NSString *clipType;

@property (nonatomic,assign) BOOL isMask;

//:--接受视频--
@property (nonatomic,copy) NSString *videoURL;
@property (nonatomic,strong) UIButton *themetypeBtu;

@property (nonatomic,strong) ReleaseChooseThemeTypeView *chooseThemeTypeView;

@property (nonatomic,copy) NSString *touchPictureStr;

@end

@implementation ChangeTheModelView


- (instancetype)initWithFrame:(CGRect)frame type:(EditType)type{
    if (self = [super initWithFrame:frame]) {
        self.type = type;
        self.backgroundColor = [UIColor whiteColor];
        switch (type) {
            case EditTypeTheme:
                [self setTitleTextField];
                self.clipType = @"横向";
                self.isMask = YES;
                [self setUpPicture:type];
                self.lowView.frame = CGRectMake(0, 58 + NavTopHeight + photoViewHeight + 20 + textViewHeight, kScreenWidth, 180);
                self.backView.frame = CGRectMake(0,NavTopHeight, kScreenWidth, photoViewHeight + textViewHeight + NavTopHeight + 60);
                self.textView.hidden = NO;
                self.textView.frame = CGRectMake(ViewWidth(self)/2 - 281/2, 58 + NavTopHeight + photoViewHeight + 20,281, 115);
                [self setIdeaViewUI:0];
                break;
            case EditTypeVideo:
                self.clipType = @"横向";
                [self setUpPicture:type];
                self.lowView.frame = CGRectMake(0, 58 + NavTopHeight + photoViewHeight, kScreenWidth, 180);
                self.backView.frame = CGRectMake(0,NavTopHeight, kScreenWidth, photoViewHeight + 60 + 58);
                self.isMask = NO;
                [self setIdeaViewUI:1];
                break;
            default:
                self.clipType = @"横向";
                [self setUpPicture:type];
                self.photoView.hidden = YES;
                self.textView.hidden = NO;
                self.lowView.frame = CGRectMake(0, 58 + NavTopHeight + textViewHeight, kScreenWidth, 180);
                self.backView.frame = CGRectMake(0,NavTopHeight, kScreenWidth, textViewHeight + 60 + 58);
                self.isMask = NO;
                [self setIdeaViewUI:1];
                break;
        }
    }
    return self;
}
- (void)setTitleTextField{
    _titleTF = [[CustomTextField alloc]initWithFrame:CGRectMake(15, 20 + NavTopHeight, 120, 22)];
    _titleTF.placeholder = @"请输入话题名称";
    _titleTF.textColor = Color_333333;
    _titleTF.font = FZFont(12);
    _titleTF.delegate = self;
    _titleTF.leftView = [[UIImageView alloc] initWithImage:Image(@"#")];
    _titleTF.leftViewMode = UITextFieldViewModeAlways;
    _titleTF.rightView = [[UIImageView alloc]initWithImage:Image(@"#")];
    _titleTF.rightViewMode = UITextFieldViewModeAlways;
    [self addSubview:_titleTF];
    
    _themetypeBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _themetypeBtu.frame = CGRectMake(ViewWidth(self) - 150, 20+NavTopHeight, 125, 30);
    [_themetypeBtu setTitle:@"请选择话题类型" forState:UIControlStateNormal];
    _themetypeBtu.titleLabel.font = FZFont(12);
    [_themetypeBtu setTitleColor:Color_999999 forState:UIControlStateNormal];
    [_themetypeBtu setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [_themetypeBtu addTarget:self action:@selector(chooseThemeType:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_themetypeBtu];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(ViewWidth(self) - 20, 28+NavTopHeight, 5, 12)];
    imageView.image = Image(@"话题选择");
    [self addSubview:imageView];
}

- (void)chooseThemeType:(UIButton *)sender{
    self.chooseThemeTypeView.hidden = NO;
}

- (ReleaseChooseThemeTypeView *)chooseThemeTypeView{
    if (!_chooseThemeTypeView) {
        _chooseThemeTypeView = [[ReleaseChooseThemeTypeView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        __weak typeof(self) mySelf = self;
        _chooseThemeTypeView.sendChooseResult = ^(NSString *result) {
            [mySelf.themetypeBtu setTitle:result forState:UIControlStateNormal];
        };
        [[self pushViewController].navigationController.view addSubview:_chooseThemeTypeView];
    }
    return _chooseThemeTypeView;
}

//MARK:--搭建输入框view--
- (UIView *)textView{
    if (!_textView) {
        //:--创建加载输入框的视图--
        _textView = [[UIView alloc]initWithFrame:CGRectMake(ViewWidth(self)/2 - 281/2, 58 + NavTopHeight,281, 115)];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.hidden = YES;
        [self addSubview:_textView];
        //:--第一行--
        _firstTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 281, 22)];
        _firstTextField.delegate = self;
        _firstTextField.font = FZFont(12);
        _firstTextField.placeholder = @"记录您的奇思妙想 ...";
        _firstTextField.textAlignment = NSTextAlignmentCenter;
//        _firstTextField.enabled = NO;
        [_textView addSubview:_firstTextField];
        //:--第二行--
        _sencedTF = [[UITextField alloc]initWithFrame:CGRectMake(0, 23, 281, 22)];
        _sencedTF.delegate = self;
        _sencedTF.font = FZFont(12);
        _sencedTF.textAlignment = NSTextAlignmentCenter;
//        _sencedTF.enabled = NO;
        [_textView addSubview:_sencedTF];
        //:--第三行--
        _thirdTF = [[UITextField alloc]initWithFrame:CGRectMake(0, 46, 281, 22)];
        _thirdTF.delegate = self;
        _thirdTF.font = FZFont(12);
        _thirdTF.textAlignment = NSTextAlignmentCenter;
//        _thirdTF.enabled = NO;
        [_textView addSubview:_thirdTF];
        //:--第四行--
        _fouceTF = [[UITextField alloc]initWithFrame:CGRectMake(0, 69, 281, 22)];
        _fouceTF.delegate = self;
        _fouceTF.font = FZFont(12);
        _fouceTF.textAlignment = NSTextAlignmentCenter;
//        _fouceTF.enabled = NO;
        [_textView addSubview:_fouceTF];
        //:--第五行--
        _fifthTF = [[UITextField alloc]initWithFrame:CGRectMake(0, 92, 281 , 22)];
        _fifthTF.delegate = self;
        _fifthTF.font = FZFont(12);
        _fifthTF.textAlignment = NSTextAlignmentCenter;
//        _fifthTF.enabled = NO;
        [_textView addSubview:_fifthTF];
        
        for (int i = 0; i < 5; i++) {
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 22 + 22*i, 281, 1)];
            line.backgroundColor = Color_cccccc;
            [_textView addSubview:line];
        }
    }
    return _textView;
}
//MARK:--搭建选择图片模块--
- (void)setUpPicture:(EditType)type{
    _photoView = [[UIView alloc]initWithFrame:CGRectMake(15, 58 + NavTopHeight, kScreenWidth - 30, (kScreenWidth - 30)/690*468)];
    [self addSubview:_photoView];
    //:--显示选择的图片或者视频--
    if (_isMask == YES) {
        _pictureView = [[UIImageView alloc]initWithFrame:CGRectMake((ViewWidth(_photoView) - ViewHeight(_photoView))/2, 0, ViewHeight(_photoView), ViewHeight(_photoView))];
    }else{
        _pictureView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth(_photoView), ViewHeight(_photoView))];
    }
    switch (type) {
        case EditTypeVideo:
            _pictureView.image = Image(@"video");
            break;
        default:
            if (_isMask == YES) {
                _pictureView.image = Image(@"round");
            }else{
                _pictureView.image = Image(@"picture");
            }
            break;
    }
    [_photoView addSubview:_pictureView];
    //:--点击图片开始选择上传视频或者图片--
    _touchBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _touchBtu.frame = _pictureView.frame;
    [_touchBtu addTarget:self action:@selector(touchImageView) forControlEvents:UIControlEventTouchUpInside];
    [_photoView addSubview:_touchBtu];
    
    _labMaskView = [[UIView alloc]initWithFrame:CGRectMake(ViewWidth(_photoView) - 30, ViewHeight(_photoView) - 15, 30, 15)];
    _labMaskView.backgroundColor = [UIColor blackColor];
    _labMaskView.alpha = 0.4;
    _labMaskView.hidden = YES;
    [_photoView addSubview:_labMaskView];
    
    _countLab = [[UILabel alloc]initWithFrame:_labMaskView.frame];
    _countLab.font = FZFont(11);
    _countLab.textColor = [UIColor whiteColor];
    _countLab.textAlignment = NSTextAlignmentCenter;
    [_photoView addSubview:_countLab];
}
/**
 重新读取加载图片的框架
 */
- (void)reloadPhotoViewSubViews{
    _pictureView.frame = CGRectMake(0, 0, ViewWidth(_photoView), ViewHeight(_photoView));
    _touchBtu.frame = _pictureView.frame;
    _labMaskView.frame = CGRectMake(ViewWidth(_photoView) - 30, ViewHeight(_photoView) - 15, 30, 15);
    _countLab.frame = _labMaskView.frame;
}
//MARK:--点击选择图片--
- (void)touchImageView{
    self.cameraView.hidden = NO;
}
//MARK:--选择照片--
- (KGCamera *)cameraView{
    if (!_cameraView) {
        _cameraView = [[KGCamera alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _cameraView.hidden = YES;
        _cameraView.delegate = self;
        [self insertSubview:_cameraView atIndex:99];
    }
    return _cameraView;
}
//MARK:--代理方法--
/**
 本地上传
 */
- (void)touchPhoto{
    ZLPhotoActionSheet *ac = [[ZLPhotoActionSheet alloc]init];
    [[NSUserDefaults standardUserDefaults] setObject:self.clipType forKey:@"ChangeImageClipType"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if (self.type == EditTypeVideo) {
        ac.maxSelectCount = 1;
        ac.allowSelectGif = YES;
        ac.allowSelectVideo = YES;
        ac.allowSelectImage = NO;
    }else{
        ac.maxSelectCount = 9;
        ac.allowSelectGif = NO;
        ac.allowSelectVideo = NO;
        ac.allowSelectImage = YES;
    }
    ac.sender = [self pushViewController];
    __weak typeof(self) mySelf = self;
    [ac setSelectImageBlock:^(NSArray<UIImage *> * _Nullable images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
        if (assets.count > 0) {
            PHAsset *phAsset = [assets lastObject];
            if (phAsset.mediaType == PHAssetMediaTypeVideo) {
                PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc]init];
                options.version = PHImageRequestOptionsVersionCurrent;
                options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
                PHImageManager *manager = [PHImageManager defaultManager];
                [manager requestAVAssetForVideo:phAsset options:options resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
                    AVURLAsset *urlAsset = (AVURLAsset *)asset;
                    mySelf.videoURL = [NSString stringWithFormat:@"%@",urlAsset.URL];
                }];
            }
        }
        mySelf.imageArr = [NSMutableArray arrayWithArray:images];
        mySelf.pictureView.image = [mySelf.imageArr firstObject];
        mySelf.countLab.text = [NSString stringWithFormat:@"1/%lu",images.count];
        mySelf.labMaskView.hidden = YES;
    }];
    [ac showPhotoLibrary];
    self.cameraView.hidden = YES;
}
/**
 拍照上传
 */
- (void)touchCamera{
    __weak typeof(self) mySelf = self;
    ZLCustomCamera *camera = [[ZLCustomCamera alloc]init];
    if (self.type == EditTypeVideo) {
        camera.allowRecordVideo = YES;
    }else{
        camera.allowRecordVideo = NO;
    }
    camera.sessionPreset = ZLCaptureSessionPreset1280x720;
    camera.maxRecordDuration = 10;
    camera.circleProgressColor = [UIColor redColor];
    [[NSUserDefaults standardUserDefaults] setObject:self.clipType forKey:@"ChangeImageClipType"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    camera.doneBlock = ^(UIImage *image, NSURL *videoUrl) {
        mySelf.pictureView.image = image;
        mySelf.videoURL = [NSString stringWithFormat:@"%@",videoUrl];
        
    };
    [[self pushViewController] presentViewController:camera animated:YES completion:nil];
    self.cameraView.hidden = YES;
}
//MARK:--KGAlertViewDelegate--
- (void)defult{
    _alert.hidden = YES;
}
//MARK:--创建位置以及可见范围view--
- (UIView *)lowView{
    if (!_lowView) {
        //:--在家底部定位按钮以及选择可见人群按钮--
        _lowView = [[UIView alloc]initWithFrame:CGRectMake(0, ViewHeight(self) - 180, kScreenWidth, 180)];
        [self addSubview:_lowView];
        //:--左侧定位按钮--
        _locationBtu = [UIButton buttonWithType:UIButtonTypeCustom];
        _locationBtu.frame = CGRectMake(15, 22, kScreenWidth/2, 14);
        [_locationBtu setImage:Image(@"location") forState:UIControlStateNormal];
        [_locationBtu setTitle:@"你在哪里？" forState:UIControlStateNormal];
        [_locationBtu setTitleColor:Color_999999 forState:UIControlStateNormal];
        _locationBtu.titleLabel.font = FZFont(12);
        [_locationBtu setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
        [_locationBtu setTitleEdgeInsets:UIEdgeInsetsMake(2, 5, 2, 0)];
        [_locationBtu setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [_locationBtu addTarget:self action:@selector(loactionClick) forControlEvents:UIControlEventTouchUpInside];
        [_lowView addSubview:_locationBtu];
        //:--右侧选择人群按钮--
        _publicBtu = [UIButton buttonWithType:UIButtonTypeCustom];
        _publicBtu.frame = CGRectMake(ViewWidth(_lowView) - 15 - 40, 20, 40, 20);
        [_publicBtu setTitle:@"公开" forState:UIControlStateNormal];
        _publicBtu.backgroundColor = Color_f2f2f2;
        _publicBtu.titleLabel.font = FZFont(12);
        [_publicBtu setTitleColor:Color_999999 forState:UIControlStateNormal];
        _publicBtu.layer.cornerRadius = 10;
        _publicBtu.layer.borderColor = Color_cccccc.CGColor;
        _publicBtu.layer.borderWidth = 1;
        [_publicBtu addTarget:self action:@selector(publicClick) forControlEvents:UIControlEventTouchUpInside];
        [_lowView addSubview:_publicBtu];
    }
    return _lowView;
}
//MARK:--定位按钮点击事件--
- (void)loactionClick{
    __weak typeof(self) mySelf = self;
    YourLocationVC *your = [[YourLocationVC alloc]init];
    your.nowLocation = ^(NSString *location) {
        [mySelf.locationBtu setTitle:location forState:UIControlStateNormal];
    };
    if ([self.delegate respondsToSelector:@selector(pushViewControllerWithVC:)]) {
        [self.delegate pushViewControllerWithVC:your];
    }
}
//MARK:--选择可见人群按钮点击事件--
- (void)publicClick{
    if (self.irregularView.hidden == NO) {
        self.irregularView.hidden = YES;
    }else{
        self.irregularView.hidden = NO;
    }
}
//MARK:--选择人群界面--
- (IrregularView *)irregularView{
    __weak typeof(self) mySelf = self;
    if (!_irregularView) {
        _irregularView = [[IrregularView alloc]initWithFrame:CGRectMake(ViewWidth(_lowView) - 95, 40, 80, 100)];
        _irregularView.sendStr = ^(NSString *title) {
            if ([title isEqualToString:@"公开"]) {
                mySelf.publicBtu.frame = CGRectMake(ViewWidth(mySelf.lowView) - 15 - 40, 20, 40, 20);
                [mySelf.publicBtu setTitle:title forState:UIControlStateNormal];
            }else{
                mySelf.publicBtu.frame = CGRectMake(ViewWidth(mySelf.lowView) - 15 - 80, 20, 80, 20);
                [mySelf.publicBtu setTitle:title forState:UIControlStateNormal];
            }
        };
        _irregularView.hidden = YES;
        [self.lowView addSubview:_irregularView];
    }
    return _irregularView;
}
- (UIView *)vertivalView{
    if (!_vertivalView) {
        _vertivalView = [[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width - 15 - textViewHeight - 20, 58 + NavTopHeight, textViewHeight + 20, 281)];
        _vertivalView.hidden = YES;
        [self addSubview:_vertivalView];
        
        _oneTF = [[UITextView alloc]initWithFrame:CGRectMake(ViewWidth(_vertivalView) - 22, 0, 22, ViewHeight(_vertivalView))];
        _oneTF.font = FZFont(12);
//        _oneTF.editable = NO;
        _oneTF.delegate = self;
        [_vertivalView addSubview:_oneTF];
        
        _twoTF = [[UITextView alloc]initWithFrame:CGRectMake(ViewWidth(_vertivalView) - 45, 0, 22, ViewHeight(_vertivalView))];
        _twoTF.font = FZFont(12);
//        _twoTF.editable = NO;
        _twoTF.delegate = self;
        [_vertivalView addSubview:_twoTF];
        
        _threeTF = [[UITextView alloc]initWithFrame:CGRectMake(ViewWidth(_vertivalView) - 68, 0, 22, ViewHeight(_vertivalView))];
        _threeTF.font = FZFont(12);
//        _threeTF.editable = NO;
        _threeTF.delegate = self;
        [_vertivalView addSubview:_threeTF];
        
        _fourTF = [[UITextView alloc]initWithFrame:CGRectMake(ViewWidth(_vertivalView) - 91, 0, 22, ViewHeight(_vertivalView))];
        _fourTF.font = FZFont(12);
//        _fourTF.editable = NO;
        _fourTF.delegate = self;
        [_vertivalView addSubview:_fourTF];
        
        _fiveTF = [[UITextView alloc]initWithFrame:CGRectMake(20, 0, 22, ViewHeight(_vertivalView))];
        _fiveTF.font = FZFont(12);
//        _fiveTF.editable = NO;
        _fiveTF.delegate = self;
        [_vertivalView addSubview:_fiveTF];
        
        for (int i = 0; i < 5; i++) {
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(20 + 22*i, 0, 1, 281)];
            line.backgroundColor = Color_cccccc;
            [_vertivalView addSubview:line];
        }
        [self setupPlaceHolde];
    }
    return _vertivalView;
}
//MARK:--预留字--
- (void)setupPlaceHolde{
    _placehodelLab = [[UILabel alloc]initWithFrame:CGRectMake(ViewWidth(_vertivalView) - 22, 0, 22, 281)];
    _placehodelLab.text = @"记录您的奇思妙想 ...";
    _placehodelLab.numberOfLines = 0;
    _placehodelLab.textColor = Color_999999;
    _placehodelLab.font = FZFont(12);
    [_vertivalView addSubview:_placehodelLab];
}
//MARK:--底部输入框--
- (void)setIdeaViewUI:(NSInteger)type{
    _ideaView = [[ChangeModelView alloc]initWithFrame:CGRectMake(0,kScreenHeight - 50, kScreenWidth, 50) type:type];
    _ideaView.delegate = self;
    [self addSubview:_ideaView];
}
//MARK:--EditVideoType--
- (void)setVideoType:(EditVideoType)videoType{
    _videoType = videoType;
    self.isMask = NO;
    switch (videoType) {
        case EditVideoTypeOnlyVideo:
            self.textView.hidden = YES;
            //:--重新设置frame--
            self.photoView.frame = CGRectMake(15, 58 + NavTopHeight, kScreenWidth - 30, photoViewHeight);
            self.lowView.frame = CGRectMake(0, self.frame.size.height - 180, kScreenWidth, 180);
            _backView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 120);
            self.lowView.frame = CGRectMake(0, 58 + NavTopHeight + photoViewHeight, kScreenWidth, 180);
            self.backView.frame = CGRectMake(0,NavTopHeight, kScreenWidth, photoViewHeight + 60 + 58);
            [self reloadPhotoViewSubViews];
            [self isClipImageView:NO];
            break;
        case EditVideoTypeTopLeft:
            //:--重新设置frame--
            self.photoView.frame = CGRectMake(15, 58 + NavTopHeight + textViewHeight + 20, kScreenWidth - 30, photoViewHeight);
            self.textView.frame = CGRectMake(15, 58 + NavTopHeight, 281, textViewHeight);
            self.lowView.frame = CGRectMake(0, self.frame.size.height - 180, kScreenWidth, 180);
            self.textView.hidden = NO;
            [self setTextFieldLocation:TextFieldTextTypeLeft];
            _backView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 120);
            self.lowView.frame = CGRectMake(0, 58 + NavTopHeight + photoViewHeight + 20 + textViewHeight, kScreenWidth, 180);
            self.backView.frame = CGRectMake(0,NavTopHeight, kScreenWidth, photoViewHeight + textViewHeight + 20 + 60 + 58);
            [self reloadPhotoViewSubViews];
            [self isClipImageView:NO];
            break;
        case EditVideoTypeTopCenter:
            //:--重新设置frame--
            self.photoView.frame = CGRectMake(15, 58 + NavTopHeight + textViewHeight + 20, kScreenWidth - 30, photoViewHeight);
            self.textView.frame = CGRectMake(ViewWidth(self)/2 - 281/2, 58 + NavTopHeight, 281, textViewHeight);
            self.lowView.frame = CGRectMake(0, self.frame.size.height - 180, kScreenWidth, 180);
            self.textView.hidden = NO;
            [self setTextFieldLocation:TextFieldTextTypeCenter];
            _backView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 120);
            self.lowView.frame = CGRectMake(0, 58 + NavTopHeight + photoViewHeight + 20 + textViewHeight, kScreenWidth, 180);
            self.backView.frame = CGRectMake(0,NavTopHeight, kScreenWidth, photoViewHeight + textViewHeight + 20 + 60 + 58);
            [self reloadPhotoViewSubViews];
            [self isClipImageView:NO];
            break;
        case EditVideoTypeTopRight:
            //:--重新设置frame--
            self.photoView.frame = CGRectMake(15, 58 + NavTopHeight + textViewHeight + 20, kScreenWidth - 30, photoViewHeight);
            self.textView.frame = CGRectMake(self.frame.size.width - 281 - 15, 58 + NavTopHeight, 281, textViewHeight);
            self.lowView.frame = CGRectMake(0, self.frame.size.height - 180, kScreenWidth, 180);
            self.textView.hidden = NO;
            [self setTextFieldLocation:TextFieldTextTypeRight];
            _backView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 120);
            self.lowView.frame = CGRectMake(0, 58 + NavTopHeight + photoViewHeight + 20 + textViewHeight, kScreenWidth, 180);
            self.backView.frame = CGRectMake(0,NavTopHeight, kScreenWidth, photoViewHeight + textViewHeight + 20 + 60 + 58);
            [self reloadPhotoViewSubViews];
            [self isClipImageView:NO];
            break;
        case EditVideoTypeLeft:
            //:--重新设置frame--
            self.photoView.frame = CGRectMake(15, 58 + NavTopHeight, kScreenWidth - 30, photoViewHeight);
            self.textView.frame = CGRectMake(15, 58 + NavTopHeight + photoViewHeight + 20, 281, textViewHeight);
            self.lowView.frame = CGRectMake(0, self.frame.size.height - 180, kScreenWidth, 180);
            self.textView.hidden = NO;
            [self setTextFieldLocation:TextFieldTextTypeLeft];
            _backView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 120);
            self.lowView.frame = CGRectMake(0, 58 + NavTopHeight + photoViewHeight + 20 + textViewHeight, kScreenWidth, 180);
            self.backView.frame = CGRectMake(0,NavTopHeight, kScreenWidth, photoViewHeight + textViewHeight + 20 + 60 + 58);
            [self reloadPhotoViewSubViews];
            [self isClipImageView:NO];
            break;
        case EditVideoTypeCenter:
            //:--重新设置frame--
            self.photoView.frame = CGRectMake(15, 58 + NavTopHeight, kScreenWidth - 30, photoViewHeight);
            self.textView.frame = CGRectMake(ViewWidth(self)/2 - 281/2, 58 + NavTopHeight + photoViewHeight + 20, 281, textViewHeight);
            self.lowView.frame = CGRectMake(0, self.frame.size.height - 180, kScreenWidth, 180);
            self.textView.hidden = NO;
            [self setTextFieldLocation:TextFieldTextTypeCenter];
            _backView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 120);
            self.lowView.frame = CGRectMake(0, 58 + NavTopHeight + photoViewHeight + 20 + textViewHeight, kScreenWidth, 180);
            self.backView.frame = CGRectMake(0,NavTopHeight, kScreenWidth, photoViewHeight + textViewHeight + 20 + 60 + 58);
            [self reloadPhotoViewSubViews];
            [self isClipImageView:NO];
            break;
        default:
            //:--重新设置frame--
            self.photoView.frame = CGRectMake(15, 58 + NavTopHeight, kScreenWidth - 30, photoViewHeight);
            self.textView.frame = CGRectMake(self.frame.size.width - 281 - 15, 58 + NavTopHeight + photoViewHeight + 20, 281, textViewHeight);
            self.lowView.frame = CGRectMake(0, self.frame.size.height - 180, kScreenWidth, 180);
            self.textView.hidden = NO;
            [self setTextFieldLocation:TextFieldTextTypeRight];
            _backView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 120);
            self.lowView.frame = CGRectMake(0, 58 + NavTopHeight + photoViewHeight + 20 + textViewHeight, kScreenWidth, 180);
            self.backView.frame = CGRectMake(0,NavTopHeight, kScreenWidth, photoViewHeight + textViewHeight + 20 + 60 + 58);
            [self reloadPhotoViewSubViews];
            [self isClipImageView:NO];
            break;
    }
}
/**
 判断是否是圆形，如果是圆形图片，则裁剪圆角，否侧原图保留

 @param shure 是否是圆形图片
 */
- (void)isClipImageView:(BOOL)shure{
    if (shure == YES) {
        self.pictureView.layer.cornerRadius = self.pictureView.frame.size.width/2;
        self.pictureView.layer.masksToBounds = YES;
    }else{
        self.pictureView.layer.cornerRadius = 0;
        self.pictureView.layer.masksToBounds = NO;
    }
}
//MARK:--EditThemeType--
- (void)setThemeType:(EditThemeType)themeType{
    _themeType = themeType;
    self.isMask = NO;
    switch (themeType) {
        case EditThemeTypeOnlyTitle:
            //:--重新设置frame--
            self.textView.hidden = NO;
            self.photoView.hidden = YES;
            self.vertivalView.hidden = YES;
            self.textView.frame = CGRectMake(ViewWidth(self)/2 - 281/2, 58 + NavTopHeight, 281, textViewHeight);
            self.textView.hidden = NO;
            [self setTextFieldLocation:TextFieldTextTypeCenter];
            self.lowView.frame = CGRectMake(0, 58 + NavTopHeight + photoViewHeight + 20 + textViewHeight, kScreenWidth, 180);
            self.backView.frame = CGRectMake(0,NavTopHeight, kScreenWidth, photoViewHeight + textViewHeight + 20 + 60 + 58);
            [self reloadPhotoViewSubViews];
            self.clipType = @"横向";
            [self isClipImageView:NO];
            break;
        case EditThemeTypeOnlyPicture:
            //:--重新设置frame--
            self.textView.hidden = YES;
            self.photoView.hidden = NO;
            self.vertivalView.hidden = YES;
            self.photoView.frame = CGRectMake(15, 58 + NavTopHeight, kScreenWidth - 30, photoViewHeight);
            self.pictureView.image = Image(@"picture");
            [self setTextFieldLocation:TextFieldTextTypeCenter];
            _backView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 120);
            self.lowView.frame = CGRectMake(0, 58 + NavTopHeight + photoViewHeight + 20, kScreenWidth, 180);
            [self reloadPhotoViewSubViews];
            self.clipType = @"横向";
            [self isClipImageView:NO];
            break;
        case EditThemeTypeCircular:
            self.isMask = YES;
            //:--重新设置frame--
            self.textView.hidden = NO;
            self.photoView.hidden = NO;
            self.vertivalView.hidden = YES;
            self.photoView.frame = CGRectMake(self.frame.size.width/2 - photoViewHeight/2, 58 + NavTopHeight, photoViewHeight, photoViewHeight);
            self.pictureView.image = Image(@"round");
            self.textView.frame = CGRectMake(ViewWidth(self)/2 - 281/2, 58 + NavTopHeight + photoViewHeight + 20, 281, textViewHeight);
            self.lowView.frame = CGRectMake(0, self.frame.size.height - 180, kScreenWidth, 180);
            self.textView.hidden = NO;
            [self setTextFieldLocation:TextFieldTextTypeCenter];
            _backView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 120);
            self.lowView.frame = CGRectMake(0, 58 + NavTopHeight + photoViewHeight + 20 + textViewHeight, kScreenWidth, 180);
            self.backView.frame = CGRectMake(0,NavTopHeight, kScreenWidth, photoViewHeight + textViewHeight + 20 + 60 + 58);
            [self reloadPhotoViewSubViews];
            self.clipType = @"圆形";
            [self isClipImageView:YES];
            break;
        case EditThemeTypeRightTop:
            //:--重新设置frame--
            self.textView.hidden = YES;
            self.photoView.hidden = NO;
            self.vertivalView.hidden = NO;
            self.photoView.frame = CGRectMake(15, 58 + NavTopHeight, self.frame.size.width - 30 - textViewHeight - 20, (self.frame.size.width - 30 - textViewHeight - 20)/225*345);
            self.pictureView.image = Image(@"rectangle");
            self.textView.hidden = YES;
            self.lowView.frame = CGRectMake(0, self.frame.size.height - 180, kScreenWidth, 180);
            self.vertivalView.frame = CGRectMake(self.frame.size.width - 15 - textViewHeight - 20, 58 + NavTopHeight, textViewHeight + 20, 281);
            _backView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 120);
            [self setVertivalText:0];
            self.lowView.frame = CGRectMake(0, 58 + NavTopHeight + (self.frame.size.width - 30 - textViewHeight - 20)/225*345, kScreenWidth, 180);
            self.backView.frame = CGRectMake(0,NavTopHeight, kScreenWidth, 58 + self.pictureView.frame.size.height + 60);
            [self reloadPhotoViewSubViews];
            self.clipType = @"竖向";
            [self isClipImageView:NO];
            _placehodelLab.hidden = NO;
            _placehodelLab.frame = CGRectMake(ViewWidth(_vertivalView) - 22, 0, 22, [TransformChineseToPinying stringWidthFromString:@"记录您的奇思妙想 ..." font:FZFont(12) height:281]);
            break;
        case EditThemeTypeRightCenter:
            //:--重新设置frame--
            self.textView.hidden = YES;
            self.photoView.hidden = NO;
            self.vertivalView.hidden = NO;
            self.photoView.frame = CGRectMake(15, 58 + NavTopHeight, self.frame.size.width - 30 - textViewHeight - 20, (self.frame.size.width - 30 - textViewHeight - 20)/225*345);
            self.pictureView.image = Image(@"rectangle");
            self.textView.hidden = YES;
            self.lowView.frame = CGRectMake(0, self.frame.size.height - 180, kScreenWidth, 180);
            self.vertivalView.hidden = NO;
            self.vertivalView.frame = CGRectMake(self.frame.size.width - 15 - textViewHeight - 20, 58 + NavTopHeight + ((self.frame.size.width - 30 - textViewHeight - 20)/225*345 - 281)/2, textViewHeight + 20, 281);
            _backView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 120);
            [self setVertivalText:1];
            self.lowView.frame = CGRectMake(0, 58 + NavTopHeight + (self.frame.size.width - 30 - textViewHeight - 20)/225*345, kScreenWidth, 180);
            self.backView.frame = CGRectMake(0,NavTopHeight, kScreenWidth, 58 + self.pictureView.frame.size.height + 60);
            [self reloadPhotoViewSubViews];
            self.clipType = @"竖向";
            [self isClipImageView:NO];
            _placehodelLab.hidden = NO;
            _placehodelLab.frame = CGRectMake(ViewWidth(_vertivalView) - 22, 0, 22, 281);
            break;
        case EditThemeTypeTopLeft:
            //:--重新设置frame--
            self.textView.hidden = NO;
            self.photoView.hidden = NO;
            self.vertivalView.hidden = YES;
            self.photoView.frame = CGRectMake(15, 58 + NavTopHeight + textViewHeight + 20, kScreenWidth - 30, photoViewHeight);
            self.pictureView.image = Image(@"picture");
            self.textView.frame = CGRectMake(15, 58 + NavTopHeight, 281, textViewHeight);
            self.lowView.frame = CGRectMake(0, self.frame.size.height - 180, kScreenWidth, 180);
            self.textView.hidden = NO;
            [self setTextFieldLocation:TextFieldTextTypeLeft];
            _backView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 120);
            self.lowView.frame = CGRectMake(0, 58 + NavTopHeight + photoViewHeight + 20 + textViewHeight, kScreenWidth, 180);
            self.backView.frame = CGRectMake(0,NavTopHeight, kScreenWidth, photoViewHeight + textViewHeight + 20 + 60 + 58);
            [self reloadPhotoViewSubViews];
            self.clipType = @"横向";
            [self isClipImageView:NO];
            break;
        case EditThemeTypeTopCenter:
            //:--重新设置frame--
            self.textView.hidden = NO;
            self.photoView.hidden = NO;
            self.vertivalView.hidden = YES;
            self.photoView.frame = CGRectMake(15, 58 + NavTopHeight + textViewHeight + 20, kScreenWidth - 30, photoViewHeight);
            self.pictureView.image = Image(@"picture");
            self.textView.frame = CGRectMake(ViewWidth(self)/2 - 281/2, 58 + NavTopHeight, 281, textViewHeight);
            self.lowView.frame = CGRectMake(0, self.frame.size.height - 180, kScreenWidth, 180);
            self.textView.hidden = NO;
            [self setTextFieldLocation:TextFieldTextTypeCenter];
            _backView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 120);
            self.lowView.frame = CGRectMake(0, 58 + NavTopHeight + photoViewHeight + 20 + textViewHeight, kScreenWidth, 180);
            self.backView.frame = CGRectMake(0,NavTopHeight, kScreenWidth, photoViewHeight + textViewHeight + 20 + 60 + 58);
            [self reloadPhotoViewSubViews];
            self.clipType = @"横向";
            [self isClipImageView:NO];
            break;
        case EditThemeTypeTopRight:
            //:--重新设置frame--
            self.textView.hidden = NO;
            self.photoView.hidden = NO;
            self.vertivalView.hidden = YES;
            self.photoView.frame = CGRectMake(15, 58 + NavTopHeight + textViewHeight + 20, kScreenWidth - 30, photoViewHeight);
            self.pictureView.image = Image(@"picture");
            self.textView.frame = CGRectMake(self.frame.size.width - 281 - 15, 58 + NavTopHeight, 281, textViewHeight);
            self.lowView.frame = CGRectMake(0, self.frame.size.height - 180, kScreenWidth, 180);
            self.textView.hidden = NO;
            [self setTextFieldLocation:TextFieldTextTypeRight];
            _backView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 120);
            self.lowView.frame = CGRectMake(0, 58 + NavTopHeight + photoViewHeight + 20 + textViewHeight, kScreenWidth, 180);
            self.backView.frame = CGRectMake(0,NavTopHeight, kScreenWidth, photoViewHeight + textViewHeight + 20 + 60 + 58);
            [self reloadPhotoViewSubViews];
            self.clipType = @"横向";
            [self isClipImageView:NO];
            break;
        case EditThemeTypeLeft:
            //:--重新设置frame--
            self.textView.hidden = NO;
            self.photoView.hidden = NO;
            self.vertivalView.hidden = YES;
            self.photoView.frame = CGRectMake(15, 58 + NavTopHeight, kScreenWidth - 30, photoViewHeight);
            self.pictureView.image = Image(@"picture");
            self.textView.frame = CGRectMake(15, 58 + NavTopHeight + photoViewHeight + 20, 281, textViewHeight);
            self.lowView.frame = CGRectMake(0, self.frame.size.height - 180, kScreenWidth, 180);
            self.textView.hidden = NO;
            [self setTextFieldLocation:TextFieldTextTypeLeft];
            _backView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 120);
            self.lowView.frame = CGRectMake(0, 58 + NavTopHeight + photoViewHeight + 20 + textViewHeight, kScreenWidth, 180);
            self.backView.frame = CGRectMake(0,NavTopHeight, kScreenWidth, photoViewHeight + textViewHeight + 20 + 60 + 58);
            [self reloadPhotoViewSubViews];
            self.clipType = @"横向";
            [self isClipImageView:NO];
            break;
        case EditThemeTypeCenter:
            //:--重新设置frame--
            self.textView.hidden = NO;
            self.photoView.hidden = NO;
            self.vertivalView.hidden = YES;
            self.photoView.frame = CGRectMake(15, 58 + NavTopHeight, kScreenWidth - 30, photoViewHeight);
            self.pictureView.image = Image(@"picture");
            self.textView.frame = CGRectMake(ViewWidth(self)/2 - 281/2, 58 + NavTopHeight + photoViewHeight + 20, 281, textViewHeight);
            self.lowView.frame = CGRectMake(0, self.frame.size.height - 180, kScreenWidth, 180);
            self.textView.hidden = NO;
            [self setTextFieldLocation:TextFieldTextTypeCenter];
            _backView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 120);
            self.lowView.frame = CGRectMake(0, 58 + NavTopHeight + photoViewHeight + 20 + textViewHeight, kScreenWidth, 180);
            self.backView.frame = CGRectMake(0,NavTopHeight, kScreenWidth, photoViewHeight + textViewHeight + 20 + 60 + 58);
            [self reloadPhotoViewSubViews];
            self.clipType = @"横向";
            [self isClipImageView:NO];
            break;
        default:
            //:--重新设置frame--
            self.textView.hidden = NO;
            self.photoView.hidden = NO;
            self.vertivalView.hidden = YES;
            self.photoView.frame = CGRectMake(15, 58 + NavTopHeight, kScreenWidth - 30, photoViewHeight);
            self.pictureView.image = Image(@"picture");
            self.textView.frame = CGRectMake(self.frame.size.width - 281 - 15, 58 + NavTopHeight + photoViewHeight + 20, 281, textViewHeight);
            self.lowView.frame = CGRectMake(0, self.frame.size.height - 180, kScreenWidth, 180);
            self.textView.hidden = NO;
            [self setTextFieldLocation:TextFieldTextTypeRight];
            _backView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 120);
            self.lowView.frame = CGRectMake(0, 58 + NavTopHeight + photoViewHeight + 20 + textViewHeight, kScreenWidth, 180);
            self.backView.frame = CGRectMake(0,NavTopHeight, kScreenWidth, photoViewHeight + textViewHeight + 20 + 60 + 58);
            [self reloadPhotoViewSubViews];
            self.clipType = @"横向";
            [self isClipImageView:NO];
            break;
    }
}
//MARK:--EditGraphicType--
- (void)setGraphicType:(EditGraphicType)graphicType{
    _graphicType = graphicType;
    self.isMask = NO;
    switch (graphicType) {
        case EditGraphicTypeOnlyTitle:
            //:--重新设置frame--
            self.textView.hidden = NO;
            self.photoView.hidden = YES;
            self.vertivalView.hidden = YES;
            self.textView.frame = CGRectMake(15, 58 + NavTopHeight, 281, textViewHeight);
            self.lowView.frame = CGRectMake(0, 58 + NavTopHeight + textViewHeight, kScreenWidth, 60);
            self.lowView.frame = CGRectMake(0, 58 + NavTopHeight + textViewHeight, kScreenWidth, 180);
            self.backView.frame = CGRectMake(0,NavTopHeight, kScreenWidth, textViewHeight + 60 + 58);
            break;
        case EditGraphicTypeOnlyPicture:
            //:--重新设置frame--
            self.textView.hidden = YES;
            self.photoView.hidden = NO;
            self.vertivalView.hidden = YES;
            self.photoView.frame = CGRectMake(15, 58 + NavTopHeight, kScreenWidth - 30, photoViewHeight);
            self.pictureView.image = Image(@"picture");
            self.lowView.frame = CGRectMake(0, 58 + NavTopHeight + photoViewHeight, kScreenWidth, 60);
            self.lowView.frame = CGRectMake(0, 58 + NavTopHeight + photoViewHeight, kScreenWidth, 180);
            self.backView.frame = CGRectMake(0,NavTopHeight, kScreenWidth, photoViewHeight + 60 + 58);
            [self reloadPhotoViewSubViews];
            self.clipType = @"横向";
            [self isClipImageView:NO];
            break;
        case EditGraphicTypeCircular:
            self.isMask = YES;
            //:--重新设置frame--
            self.photoView.hidden = NO;
            self.vertivalView.hidden = YES;
            self.photoView.frame = CGRectMake(self.frame.size.width/2 - photoViewHeight/2, 58 + NavTopHeight, photoViewHeight, photoViewHeight);
            self.pictureView.image = Image(@"round");
            self.textView.frame = CGRectMake(ViewWidth(self)/2 - 281/2, 58 + NavTopHeight + photoViewHeight + 20, 281, textViewHeight);
            self.lowView.frame = CGRectMake(0, self.frame.size.height - 180, kScreenWidth, 180);
            self.textView.hidden = NO;
            [self setTextFieldLocation:TextFieldTextTypeCenter];
            _backView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 120);
            self.lowView.frame = CGRectMake(0, 58 + NavTopHeight + photoViewHeight + 20 + textViewHeight, kScreenWidth, 180);
            self.backView.frame = CGRectMake(0,NavTopHeight, kScreenWidth, photoViewHeight + textViewHeight + 20 + 60 + 58);
            [self reloadPhotoViewSubViews];
            self.clipType = @"圆形";
            [self isClipImageView:YES];
            break;
        case EditGraphicTypeRightTop:
            //:--重新设置frame--
            self.textView.hidden = YES;
            self.photoView.hidden = NO;
            self.vertivalView.hidden = NO;
            self.photoView.frame = CGRectMake(15, 58 + NavTopHeight, self.frame.size.width - 30 - textViewHeight - 20, (self.frame.size.width - 30 - textViewHeight - 20)/225*345);
            self.pictureView.image = Image(@"rectangle");
            self.lowView.frame = CGRectMake(0, self.frame.size.height - 180, kScreenWidth, 180);
            self.vertivalView.hidden = NO;
            self.vertivalView.frame = CGRectMake(self.frame.size.width - 15 - textViewHeight - 20, 58 + NavTopHeight, textViewHeight + 20, 281);
            _backView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 120);
            [self setVertivalText:0];
            self.lowView.frame = CGRectMake(0, 58 + NavTopHeight + (self.frame.size.width - 30 - textViewHeight - 20)/225*345, kScreenWidth, 180);
            self.backView.frame = CGRectMake(0,NavTopHeight, kScreenWidth, 58 + ViewHeight(self.pictureView) + 60);
            [self reloadPhotoViewSubViews];
            self.clipType = @"竖向";
            [self isClipImageView:NO];
            _placehodelLab.hidden = NO;
            _placehodelLab.frame = CGRectMake(ViewWidth(_vertivalView) - 22, 0, 22, [TransformChineseToPinying stringWidthFromString:@"记录您的奇思妙想 ..." font:FZFont(12) height:281]);
            break;
        case EditGraphicTypeRightCenter:
            //:--重新设置frame--
            self.textView.hidden = YES;
            self.photoView.hidden = NO;
            self.vertivalView.hidden = NO;
            self.photoView.frame = CGRectMake(15, 58 + NavTopHeight, self.frame.size.width - 30 - textViewHeight - 20, (self.frame.size.width - 30 - textViewHeight - 20)/225*345);
            self.pictureView.image = Image(@"rectangle");
            self.textView.hidden = YES;
            self.lowView.frame = CGRectMake(0, self.frame.size.height - 180, kScreenWidth, 180);
            self.vertivalView.hidden = NO;
            self.vertivalView.frame = CGRectMake(self.frame.size.width - 15 - textViewHeight - 20, 58 + NavTopHeight + ((self.frame.size.width - 30 - textViewHeight - 20)/225*345 - 281)/2, textViewHeight + 20, 281);
            [self setTextFieldLocation:TextFieldTextTypeCenter];
            _backView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 120);
            [self setVertivalText:1];
            self.lowView.frame = CGRectMake(0, 58 + NavTopHeight + (self.frame.size.width - 30 - textViewHeight - 20)/225*345, kScreenWidth, 180);
            self.backView.frame = CGRectMake(0,NavTopHeight, kScreenWidth, 58 + ViewHeight(self.pictureView) + 60);
            [self reloadPhotoViewSubViews];
            self.clipType = @"竖向";
            [self isClipImageView:NO];
            _placehodelLab.hidden = NO;
            _placehodelLab.frame = CGRectMake(ViewWidth(_vertivalView) - 22, 0, 22, 281);
            break;
        case EditGraphicTypeTopLeft:
            //:--重新设置frame--
            self.textView.hidden = NO;
            self.photoView.hidden = NO;
            self.vertivalView.hidden = YES;
            self.photoView.frame = CGRectMake(15, 58 + NavTopHeight + textViewHeight + 20, kScreenWidth - 30, photoViewHeight);
            self.pictureView.image = Image(@"picture");
            self.textView.frame = CGRectMake(15, 58 + NavTopHeight, 281, textViewHeight);
            self.lowView.frame = CGRectMake(0, self.frame.size.height - 180, kScreenWidth, 180);
            self.textView.hidden = NO;
            [self setTextFieldLocation:TextFieldTextTypeLeft];
            _backView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 120);
            self.lowView.frame = CGRectMake(0, 58 + NavTopHeight + photoViewHeight + 20 + textViewHeight, kScreenWidth, 180);
            self.backView.frame = CGRectMake(0,NavTopHeight, kScreenWidth, photoViewHeight + textViewHeight + 20 + 60 + 58);
            [self reloadPhotoViewSubViews];
            self.clipType = @"横向";
            [self isClipImageView:NO];
            break;
        case EditGraphicTypeTopCenter:
            //:--重新设置frame--
            self.textView.hidden = NO;
            self.photoView.hidden = NO;
            self.vertivalView.hidden = YES;
            self.photoView.frame = CGRectMake(15, 58 + NavTopHeight + textViewHeight + 20, kScreenWidth - 30, photoViewHeight);
            self.pictureView.image = Image(@"picture");
            self.textView.frame = CGRectMake(ViewWidth(self)/2 - 281/2, 58 + NavTopHeight, 281, textViewHeight);
            self.lowView.frame = CGRectMake(0, self.frame.size.height - 180, kScreenWidth, 180);
            self.textView.hidden = NO;
            [self setTextFieldLocation:TextFieldTextTypeCenter];
            _backView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 120);
            self.lowView.frame = CGRectMake(0, 58 + NavTopHeight + photoViewHeight + 20 + textViewHeight, kScreenWidth, 180);
            self.backView.frame = CGRectMake(0,NavTopHeight, kScreenWidth, photoViewHeight + textViewHeight + 20 + 60 + 58);
            [self reloadPhotoViewSubViews];
            self.clipType = @"横向";
            [self isClipImageView:NO];
            break;
        case EditGraphicTypeTopRight:
            //:--重新设置frame--
            self.textView.hidden = NO;
            self.photoView.hidden = NO;
            self.vertivalView.hidden = YES;
            self.photoView.frame = CGRectMake(15, 58 + NavTopHeight + textViewHeight + 20, kScreenWidth - 30, photoViewHeight);
            self.pictureView.image = Image(@"picture");
            self.textView.frame = CGRectMake(self.frame.size.width - 281 - 15, 58 + NavTopHeight, 281, textViewHeight);
            self.lowView.frame = CGRectMake(0, self.frame.size.height - 180, kScreenWidth, 180);
            self.textView.hidden = NO;
            [self setTextFieldLocation:TextFieldTextTypeRight];
            _backView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 120);
            self.lowView.frame = CGRectMake(0, 58 + NavTopHeight + photoViewHeight + 20 + textViewHeight, kScreenWidth, 180);
            self.backView.frame = CGRectMake(0,NavTopHeight, kScreenWidth, photoViewHeight + textViewHeight + 20 + 60 + 58);
            [self reloadPhotoViewSubViews];
            self.clipType = @"横向";
            [self isClipImageView:NO];
            break;
        case EditGraphicTypeLeft:
            //:--重新设置frame--
            self.textView.hidden = NO;
            self.photoView.hidden = NO;
            self.vertivalView.hidden = YES;
            self.photoView.frame = CGRectMake(15, 58 + NavTopHeight, kScreenWidth - 30, photoViewHeight);
            self.pictureView.image = Image(@"picture");
            self.textView.frame = CGRectMake(15, 58 + NavTopHeight + photoViewHeight + 20, 281, textViewHeight);
            self.lowView.frame = CGRectMake(0, self.frame.size.height - 180, kScreenWidth, 180);
            self.textView.hidden = NO;
            [self setTextFieldLocation:TextFieldTextTypeLeft];
            _backView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 120);
            self.lowView.frame = CGRectMake(0, 58 + NavTopHeight + photoViewHeight + 20 + textViewHeight, kScreenWidth, 180);
            self.backView.frame = CGRectMake(0,NavTopHeight, kScreenWidth, photoViewHeight + textViewHeight + 20 + 60 + 58);
            [self reloadPhotoViewSubViews];
            self.clipType = @"横向";
            [self isClipImageView:NO];
            break;
        case EditGraphicTypeCenter:
            //:--重新设置frame--
            self.textView.hidden = NO;
            self.photoView.hidden = NO;
            self.vertivalView.hidden = YES;
            self.photoView.frame = CGRectMake(15, 58 + NavTopHeight, kScreenWidth - 30, photoViewHeight);
            self.pictureView.image = Image(@"picture");
            self.textView.frame = CGRectMake(ViewWidth(self)/2 - 281/2, 58 + NavTopHeight + photoViewHeight + 20, 281, textViewHeight);
            self.lowView.frame = CGRectMake(0, self.frame.size.height - 180, kScreenWidth, 180);
            self.textView.hidden = NO;
            [self setTextFieldLocation:TextFieldTextTypeCenter];
            _backView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 120);
            self.lowView.frame = CGRectMake(0, 58 + NavTopHeight + photoViewHeight + 20 + textViewHeight, kScreenWidth, 180);
            self.backView.frame = CGRectMake(0,NavTopHeight, kScreenWidth, photoViewHeight + textViewHeight + 20 + 60 + 58);
            [self reloadPhotoViewSubViews];
            self.clipType = @"横向";
            [self isClipImageView:NO];
            break;
        default:
            //:--重新设置frame--
            self.textView.hidden = NO;
            self.photoView.hidden = NO;
            self.vertivalView.hidden = YES;
            self.photoView.frame = CGRectMake(15, 58 + NavTopHeight, kScreenWidth - 30, photoViewHeight);
            self.pictureView.image = Image(@"picture");
            self.textView.frame = CGRectMake(self.frame.size.width - 281 - 15, 58 + NavTopHeight + photoViewHeight + 20, 281, textViewHeight);
            self.textView.hidden = NO;
            _backView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 120);
            self.lowView.frame = CGRectMake(0, 58 + NavTopHeight + photoViewHeight + 20 + textViewHeight, kScreenWidth, 180);
            self.backView.frame = CGRectMake(0,NavTopHeight, kScreenWidth, photoViewHeight + textViewHeight + 20 + 60 + 58);
            [self setTextFieldLocation:TextFieldTextTypeRight];
            [self reloadPhotoViewSubViews];
            self.clipType = @"横向";
            [self isClipImageView:NO];
            break;
    }
}
//MARK:--设置输入框字体位置--
- (void)setTextFieldLocation:(TextFieldTextType)type{
    switch (type) {
        case TextFieldTextTypeLeft:
            _firstTextField.textAlignment = NSTextAlignmentLeft;
            _sencedTF.textAlignment = NSTextAlignmentLeft;
            _thirdTF.textAlignment = NSTextAlignmentLeft;
            _fouceTF.textAlignment = NSTextAlignmentLeft;
            _fifthTF.textAlignment = NSTextAlignmentLeft;
            break;
        case TextFieldTextTypeCenter:
            _firstTextField.textAlignment = NSTextAlignmentCenter;
            _sencedTF.textAlignment = NSTextAlignmentCenter;
            _thirdTF.textAlignment = NSTextAlignmentCenter;
            _fouceTF.textAlignment = NSTextAlignmentCenter;
            _fifthTF.textAlignment = NSTextAlignmentCenter;
            break;
        default:
            _firstTextField.textAlignment = NSTextAlignmentRight;
            _sencedTF.textAlignment = NSTextAlignmentRight;
            _thirdTF.textAlignment = NSTextAlignmentRight;
            _fouceTF.textAlignment = NSTextAlignmentRight;
            _fifthTF.textAlignment = NSTextAlignmentRight;
            break;
    }
}
//MARK:--设置竖排居中居上--
- (void)setVertivalText:(NSInteger)type{
    switch (type) {
        case 0:
            _oneTF.contentMode = UIViewContentModeTop;
            _twoTF.contentMode = UIViewContentModeTop;
            _threeTF.contentMode = UIViewContentModeTop;
            _fourTF.contentMode = UIViewContentModeTop;
            _fiveTF.contentMode = UIViewContentModeTop;
            break;
        default:
            _oneTF.contentMode = UIViewContentModeRedraw;
            _twoTF.contentMode = UIViewContentModeRedraw;
            _threeTF.contentMode = UIViewContentModeRedraw;
            _fourTF.contentMode = UIViewContentModeRedraw;
            _fiveTF.contentMode = UIViewContentModeRedraw;
            break;
    }
}
//MARK:--ChangeModelViewDelegate--
- (void)changeViewFrame:(CGRect)frame{
    if (frame.size.height == 50) {
        [UIView animateWithDuration:0.3 animations:^{
            self.ideaView.frame = CGRectMake(0, kScreenHeight - 50 - 120, kScreenWidth, 50 + 120);
        }];
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            self.ideaView.frame = CGRectMake(0,kScreenHeight - 50, kScreenWidth, 50);
        }];
    }
}
- (void)changeModelViewClick{
    __weak typeof(self) mySelf = self;
    ChooseModelVC *vc = [[ChooseModelVC alloc]init];
    if (self.type == EditTypeTheme) {
        vc.imageArr = @[Image(@"A文字"),Image(@"A图片"),Image(@"C圆形"),Image(@"C右上"),Image(@"C右中"),Image(@"C上左"),Image(@"C上中"),Image(@"C上右"),Image(@"C下左"),Image(@"C下中"),Image(@"C下右")];
        vc.sendModel = ^(NSInteger index) {
            mySelf.themeType = [[ModelFrameIndex shareInterace] themeTypeWithIndex:index];
        };
    }else if (self.type == EditTypeVideo){
        vc.imageArr = @[Image(@"B视频"),Image(@"B上左"),Image(@"B上中"),Image(@"B上右"),Image(@"B下左"),Image(@"B下中"),Image(@"B下右")];
        vc.sendModel = ^(NSInteger index) {
            mySelf.videoType = [[ModelFrameIndex shareInterace] videoTypeWithIndex:index];
        };
    }else{
        vc.imageArr = @[Image(@"A文字"),Image(@"A图片"),Image(@"A圆形"),Image(@"A右上"),Image(@"A右中"),Image(@"A上左"),Image(@"A上中"),Image(@"A上右"),Image(@"A下左"),Image(@"A下中"),Image(@"A下右")];
        vc.sendModel = ^(NSInteger index) {
            mySelf.graphicType = [[ModelFrameIndex shareInterace] graphicTypeWithIndex:index];
        };
    }
    [[self pushViewController].navigationController pushViewController:vc animated:YES];
}
- (void)textFieldLenght{
    if (!_alert) {
        _alert = [[KGAlertView alloc]initWithFrame:self.frame];
        _alert.delegate = self;
        [_alert setAlertViewTitle:@"提示" message:@"输入字符不能超过20，请重新输入" type:KGAlertViewTypeDefult];
        [self addSubview:_alert];
    }else{
        _alert.hidden = NO;
    }
}
- (void)sendStringToView:(NSString *)string index:(NSInteger)index{
    switch (self.type) {
        case EditTypeVideo:
            switch (self.videoType) {
                case EditVideoTypeOnlyVideo:
                    
                    break;
                case EditVideoTypeTopLeft:
                    [self textFieldString:string number:index];
                    break;
                case EditVideoTypeTopCenter:
                    [self textFieldString:string number:index];
                    break;
                case EditVideoTypeTopRight:
                    [self textFieldString:string number:index];
                    break;
                case EditVideoTypeLeft:
                    [self textFieldString:string number:index];
                    break;
                case EditVideoTypeCenter:
                    [self textFieldString:string number:index];
                    break;
                default:
                    [self textFieldString:string number:index];
                    break;
            }
            break;
        case EditTypeTheme:
            switch (self.themeType) {
                case EditThemeTypeOnlyTitle:
                    [self textFieldString:string number:index];
                    break;
                case EditThemeTypeOnlyPicture:
                    [self textFieldString:string number:index];
                    break;
                case EditThemeTypeCircular:
                    [self textFieldString:string number:index];
                    break;
                case EditThemeTypeRightTop:
                    [self textViewString:string number:index];
                    break;
                case EditThemeTypeRightCenter:
                    [self textViewString:string number:index];
                    break;
                case EditThemeTypeTopLeft:
                    [self textFieldString:string number:index];
                    break;
                case EditThemeTypeTopCenter:
                    [self textFieldString:string number:index];
                    break;
                case EditThemeTypeTopRight:
                    [self textFieldString:string number:index];
                    break;
                case EditThemeTypeLeft:
                    [self textFieldString:string number:index];
                    break;
                case EditThemeTypeCenter:
                    [self textFieldString:string number:index];
                    break;
                default:
                    [self textFieldString:string number:index];
                    break;
            }
            break;
        default:
            switch (self.graphicType) {
                case EditGraphicTypeOnlyTitle:
                    [self textFieldString:string number:index];
                    break;
                case EditGraphicTypeOnlyPicture:
                    
                    break;
                case EditGraphicTypeCircular:
                    [self textFieldString:string number:index];
                    break;
                case EditGraphicTypeRightTop:
                    [self textViewString:string number:index];
                    break;
                case EditGraphicTypeRightCenter:
                    [self textViewString:string number:index];
                    break;
                case EditGraphicTypeTopLeft:
                    [self textFieldString:string number:index];
                    break;
                case EditGraphicTypeTopCenter:
                    [self textFieldString:string number:index];
                    break;
                case EditGraphicTypeTopRight:
                    [self textFieldString:string number:index];
                    break;
                case EditGraphicTypeLeft:
                    [self textFieldString:string number:index];
                    break;
                case EditGraphicTypeCenter:
                    [self textFieldString:string number:index];
                    break;
                default:
                    [self textFieldString:string number:index];
                    break;
            }
            break;
    }
}
//MARK:--横排文字填充--
- (void)textFieldString:(NSString *)str number:(NSInteger)nmb{
    switch (nmb) {
        case 0:
            _firstTextField.text = str;
            break;
        case 1:
            _sencedTF.text = str;
            break;
        case 2:
            _thirdTF.text = str;
            break;
        case 3:
            _fouceTF.text = str;
            break;
        default:
            _fifthTF.text = str;
            break;
    }
}
//MARK:--竖排文字填充--
- (void)textViewString:(NSString *)str number:(NSInteger)nmb{
    _placehodelLab.hidden = YES;
    if (str.length > 0) {
        _placehodelLab.hidden = YES;
    }else{
        _placehodelLab.hidden = NO;
    }
    switch (nmb) {
        case 0:
            _oneTF.text = str;
            break;
        case 1:
            _twoTF.text = str;
            break;
        case 2:
            _threeTF.text = str;
            break;
        case 3:
            _fourTF.text = str;
            break;
        default:
            _fiveTF.text = str;
            break;
    }
}
- (UIViewController *)pushViewController{
    id target = self;
    while (target) {
        target = ((UIResponder *)target).nextResponder;
        if ([target isKindOfClass:[UIViewController class]]) {
            break;
        }
    }
    return target;
}

- (PreviewVCModel *)model{
    PreviewVCModel *model = [PreviewVCModel new];
    switch (self.type) {
        case EditTypeTheme:
            if (self.themeType == EditThemeTypeRightTop || self.themeType == EditThemeTypeRightCenter) {
                if (_titleTF.text.length > 0 & _titleTF.text != nil) {
                    model.title = _titleTF.text;
                    model.topicType = _themetypeBtu.currentTitle;
                    model.typeStr = @"1";
                }else{
                    model.typeStr = @"0";
                }
                model.str1 = self.oneTF.text;
                model.str2 = self.twoTF.text;
                model.str3 = self.threeTF.text;
                model.str4 = self.fourTF.text;
                model.str5 = self.fiveTF.text;
                model.imageURLs = self.imageArr.copy;
            }else if (self.themeType == EditThemeTypeOnlyTitle & self.themeType == EditThemeTypeOnlyPicture){
                model.typeStr = @"0";
                model.str1 = self.firstTextField.text;
                model.str2 = self.sencedTF.text;
                model.str3 = self.thirdTF.text;
                model.str4 = self.fouceTF.text;
                model.str5 = self.fifthTF.text;
                model.imageURLs = self.imageArr.copy;
            }else{
                
                if (_titleTF.text.length > 0 & _titleTF.text != nil) {
                    model.title = _titleTF.text;
                    model.topicType = _themetypeBtu.currentTitle;
                    model.typeStr = @"1";
                }else{
                    model.typeStr = @"0";
                }
                
                model.str1 = self.firstTextField.text;
                model.str2 = self.sencedTF.text;
                model.str3 = self.thirdTF.text;
                model.str4 = self.fouceTF.text;
                model.str5 = self.fifthTF.text;
                model.imageURLs = self.imageArr.copy;
            }
            model.composing = [self returnTType:self.themeType];
            break;
        case EditTypeGraphic:
            if (self.graphicType == EditGraphicTypeRightTop & self.graphicType == EditGraphicTypeRightCenter) {
                model.str1 = self.oneTF.text;
                model.str2 = self.twoTF.text;
                model.str3 = self.threeTF.text;
                model.str4 = self.fourTF.text;
                model.str5 = self.fiveTF.text;
                model.imageURLs = self.imageArr.copy;
            }else{
                model.str1 = self.firstTextField.text;
                model.str2 = self.sencedTF.text;
                model.str3 = self.thirdTF.text;
                model.str4 = self.fouceTF.text;
                model.str5 = self.fifthTF.text;
                model.imageURLs = self.imageArr.copy;
            }
            
            model.composing = [self returnGType:self.graphicType];
            break;
        default:
            if (self.videoType == EditVideoTypeOnlyVideo) {
                model.str1 = self.oneTF.text;
                model.str2 = self.twoTF.text;
                model.str3 = self.threeTF.text;
                model.str4 = self.fourTF.text;
                model.str5 = self.fiveTF.text;
                model.imageURLs = self.imageArr.copy;
            }else{
                model.str1 = self.firstTextField.text;
                model.str2 = self.sencedTF.text;
                model.str3 = self.thirdTF.text;
                model.str4 = self.fouceTF.text;
                model.str5 = self.fifthTF.text;
                model.imageURLs = self.imageArr.copy;
            }
            model.typeStr = @"2";
            model.composing = [self returnVType:self.videoType];
            break;
    }
    model.location = _locationBtu.currentTitle;
    model.ids = @[];
    if ([_publicBtu.currentTitle isEqualToString:@"公开"]){
        model.visitPermission = @"0";
    }else if ([_publicBtu.currentTitle isEqualToString:@"仅自己可见"]){
        model.visitPermission = @"1";
    }else{
        model.visitPermission = @"2";
    }
    return model;
}

- (void)setIsMask:(BOOL)isMask{
    _isMask = isMask;
    if (isMask == YES) {
        self.pictureView.layer.cornerRadius = self.pictureView.frame.size.height/2;
        self.pictureView.layer.masksToBounds = YES;
    }
}

- (NSString *)returnTType:(EditThemeType)type{
    switch (type) {
        case EditThemeTypeOnlyTitle:
            return @"0";
            break;
        case EditThemeTypeOnlyPicture:
            return @"1";
            break;
        case EditThemeTypeCircular:
            return @"2";
            break;
        case EditThemeTypeRightTop:
            return @"3";
            break;
        case EditThemeTypeRightCenter:
            return @"4";
            break;
        case EditThemeTypeTopLeft:
            return @"5";
            break;
        case EditThemeTypeTopCenter:
            return @"6";
            break;
        case EditThemeTypeTopRight:
            return @"7";
            break;
        case EditThemeTypeLeft:
            return @"8";
            break;
        case EditThemeTypeCenter:
            return @"9";
            break;
        case EditThemeTypeRight:
            return @"10";
            break;
        default:
            break;
    }
}
- (NSString *)returnVType:(EditVideoType)type{
    switch (type) {
        case EditVideoTypeTopLeft:
            return @"5";
            break;
        case EditVideoTypeTopCenter:
            return @"6";
            break;
        case EditVideoTypeTopRight:
            return @"7";
            break;
        case EditVideoTypeLeft:
            return @"8";
            break;
        case EditVideoTypeCenter:
            return @"9";
            break;
        case EditVideoTypeRight:
            return @"10";
            break;
        case EditVideoTypeOnlyVideo:
            return @"1";
            break;
        default:
            break;
    }
}
- (NSString *)returnGType:(EditGraphicType)type{
    switch (type) {
        case EditGraphicTypeCircular:
            return @"2";
            break;
        case EditGraphicTypeRightTop:
            return @"3";
            break;
        case EditGraphicTypeRightCenter:
            return @"4";
            break;
        case EditGraphicTypeTopLeft:
            return @"5";
            break;
        case EditGraphicTypeTopCenter:
            return @"6";
            break;
        case EditGraphicTypeTopRight:
            return @"7";
            break;
        case EditGraphicTypeLeft:
            return @"8";
            break;
        case EditGraphicTypeCenter:
            return @"9";
            break;
        case EditGraphicTypeRight:
            return @"10";
            break;
        case EditGraphicTypeOnlyTitle:
            return @"0";
            break;
        case EditGraphicTypeOnlyPicture:
            return @"1";
            break;
        default:
            break;
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    self.placehodelLab.hidden = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
