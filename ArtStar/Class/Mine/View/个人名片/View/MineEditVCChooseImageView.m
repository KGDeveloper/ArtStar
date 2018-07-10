//
//  MineEditVCChooseImageView.m
//  ArtStar
//
//  Created by abc on 6/11/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "MineEditVCChooseImageView.h"

@interface MineEditVCChooseImageView ()<KGCameraDelegate>

@property (nonatomic,strong) UIImageView *choooseImage;
@property (nonatomic,strong) UIButton *deleteBtu;
@property (nonatomic,strong) UIButton *touchBtu;
@property (nonatomic,strong) KGCamera *cameraView;
@property (nonatomic,assign) BOOL isChoose;

@property (nonatomic,copy) NSString *imageString;

@end

@implementation MineEditVCChooseImageView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        _isChoose = NO;
        [self setChooseView];
    }
    return self;
}

- (void)setChooseView{
    
    _choooseImage = [UIImageView new];
    _deleteBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _touchBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self sd_addSubviews:@[_choooseImage,_touchBtu,_deleteBtu]];
    
    _choooseImage.image = Image(@"tianjia");
    _choooseImage.sd_layout.topEqualToView(self).leftEqualToView(self).widthIs(ViewWidth(self)).heightIs(ViewHeight(self));
    
    [_touchBtu addTarget:self action:@selector(touchUpImage) forControlEvents:UIControlEventTouchUpInside];
    _touchBtu.sd_layout.topEqualToView(_choooseImage).leftEqualToView(_choooseImage).heightIs(ViewHeight(self)).widthIs(ViewWidth(self));
    
    [_deleteBtu setImage:Image(@"收藏删除") forState:UIControlStateNormal];
    [_deleteBtu addTarget:self action:@selector(deleteImage) forControlEvents:UIControlEventTouchUpInside];
    _deleteBtu.backgroundColor = [UIColor whiteColor];
    _deleteBtu.layer.cornerRadius = 12;
    _deleteBtu.layer.masksToBounds = YES;
    _deleteBtu.hidden = YES;
    _deleteBtu.sd_layout.topEqualToView(_choooseImage).rightEqualToView(_choooseImage).widthIs(24).heightIs(24);
    
}
- (void)touchUpImage{
    self.cameraView.hidden = NO;
}
- (void)deleteImage{
    _choooseImage.image = Image(@"tianjia");
    _isChoose = NO;
    _deleteBtu.hidden = YES;
}

- (UIViewController *)rootViewCintroller{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

//MARK:--选择照片--
- (KGCamera *)cameraView{
    if (!_cameraView) {
        _cameraView = [[KGCamera alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _cameraView.hidden = YES;
        _cameraView.delegate = self;
        [[self rootViewCintroller].navigationController.view addSubview:_cameraView];
    }
    return _cameraView;
}
//MARK:--代理方法--
/**
 本地上传
 */
- (void)touchPhoto{
    ZLPhotoActionSheet *ac = [[ZLPhotoActionSheet alloc]init];
    ac.maxSelectCount = 1;
    ac.allowSelectGif = NO;
    ac.allowSelectVideo = NO;
    ac.allowSelectImage = YES;
    ac.sender = [self rootViewCintroller];
    __weak typeof(self) mySelf = self;
    [ac setSelectImageBlock:^(NSArray<UIImage *> * _Nullable images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
        mySelf.choooseImage.image = [images firstObject];
        mySelf.isChoose = YES;
        if (mySelf.sendChooseFileToController) {
            mySelf.sendChooseFileToController([[KGQiniuUploadManager shareInstance] getImagePath:[images firstObject]]);
        }
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
    camera.allowRecordVideo = NO;
    camera.sessionPreset = ZLCaptureSessionPreset1280x720;
    camera.maxRecordDuration = 10;
    camera.circleProgressColor = [UIColor redColor];
    camera.doneBlock = ^(UIImage *image, NSURL *videoUrl) {
        mySelf.choooseImage.image = image;
        if (mySelf.sendChooseFileToController) {
            mySelf.sendChooseFileToController([[KGQiniuUploadManager shareInstance] getImagePath:image]);
        }
        mySelf.isChoose = YES;
    };
    [[self rootViewCintroller] presentViewController:camera animated:YES completion:nil];
    self.cameraView.hidden = YES;
}

- (void)setIsChoose:(BOOL)isChoose{
    _isChoose = isChoose;
    if (isChoose == YES) {
        _deleteBtu.hidden = NO;
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
