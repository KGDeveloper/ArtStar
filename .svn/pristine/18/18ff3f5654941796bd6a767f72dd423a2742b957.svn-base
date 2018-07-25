//
//  PreviewHorizontalView.m
//  ArtStar
//
//  Created by abc on 5/11/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "PreviewHorizontalView.h"

@interface PreviewHorizontalView ()<UIScrollViewDelegate>{
    CGFloat _timeWidth;
    NSInteger _countN;
}

@property (nonatomic,strong) UILabel *oneLab;
@property (nonatomic,strong) UILabel *twoLab;
@property (nonatomic,strong) UILabel *threeLab;
@property (nonatomic,strong) UILabel *fourLab;
@property (nonatomic,strong) UILabel *fiveLab;
@property (nonatomic,strong) UIView *textView;
@property (nonatomic,strong) UIView *lowView;
@property (nonatomic,strong) UIScrollView *imageBack;
@property (nonatomic,strong) UILabel *timelab;
@property (nonatomic,strong) UILabel *locationLab;
@property (nonatomic,strong) UILabel *themeLab;
@property (nonatomic,strong) UIView *photoView;
@property (nonatomic,strong) UIView *countView;
@property (nonatomic,strong) UILabel *countlab;
@property (nonatomic,assign) BOOL isMask;

@end

@implementation PreviewHorizontalView

- (instancetype)initWithFrame:(CGRect)frame type:(LabelAndImageType)type{
    if (self = [super initWithFrame:frame]) {
        _isMask = NO;
        [self setUIType:type];
        _countN = 1;
    }
    return self;
}
//MARK:--根据type创建界面--
- (void)setUIType:(LabelAndImageType)type{
    switch (type) {
        case LabelAndImageTypeImageTop:
            [self setImageViewFrame:CGRectMake(15,0, ViewWidth(self) - 30, photoViewHeight)];
            [self setLabelViewFrame:CGRectMake(15,photoViewHeight + 20, ViewWidth(self) - 30, 150)];
            [self setLocationView:CGRectMake(15, 170 + photoViewHeight, kScreenWidth - 30, 50)];
            break;
        case LabelAndImageTypeLabelTop:
            [self setLabelViewFrame:CGRectMake(15,0, ViewWidth(self) - 30, 150)];
            [self setImageViewFrame:CGRectMake(15,170, ViewWidth(self) - 30, photoViewHeight)];
            [self setLocationView:CGRectMake(15, 170 + photoViewHeight, kScreenWidth - 30, 50)];
            break;
        case LabelAndImageTypeOnlyImage:
            [self setImageViewFrame:CGRectMake(15,0, ViewWidth(self) - 30, photoViewHeight)];
            [self setLocationView:CGRectMake(15,photoViewHeight, kScreenWidth - 30, 50)];
            break;
        case LabelAndImageTypeOnlyLabel:
            [self setLabelViewFrame:CGRectMake(15,0, ViewWidth(self) - 30, 150)];
            [self setLocationView:CGRectMake(15, 150, kScreenWidth - 30, 50)];
            break;
        default:
            _isMask = YES;
            [self setImageViewFrame:CGRectMake((ViewWidth(self) - photoViewHeight)/2,0, photoViewHeight, photoViewHeight)];
            [self setLabelViewFrame:CGRectMake(15,photoViewHeight + 20, ViewWidth(self) - 30, 150)];
            [self setLocationView:CGRectMake(15, 170 + photoViewHeight, kScreenWidth - 30, 50)];
            break;
    }
}
//MARK:--搭建labelview--
- (void)setLabelViewFrame:(CGRect)frame{
    //:--承载label--
    _textView = [[UIView alloc]initWithFrame:frame];
    [self addSubview:_textView];
    //:--加载label--
    _oneLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ViewWidth(_textView), 22)];
    _oneLab.font = FZFont(13);
    _oneLab.textColor = Color_333333;
    [_textView addSubview:_oneLab];
    
    _twoLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 32, ViewWidth(_textView), 22)];
    _twoLab.font = FZFont(13);
    _twoLab.textColor = Color_333333;
    [_textView addSubview:_twoLab];
    
    _threeLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, ViewWidth(_textView), 22)];
    _threeLab.font = FZFont(13);
    _threeLab.textColor = Color_333333;
    [_textView addSubview:_threeLab];

    _fourLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 96, ViewWidth(_textView), 22)];
    _fourLab.font = FZFont(13);
    _fourLab.textColor = Color_333333;
    [_textView addSubview:_fourLab];

    _fiveLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 128, ViewWidth(_textView), 22)];
    _fiveLab.font = FZFont(13);
    _fiveLab.textColor = Color_333333;
    [_textView addSubview:_fiveLab];
    
}
//MARK:--搭建imageview--
- (void)setImageViewFrame:(CGRect)frame{
    //:--加载view--
    _photoView = [[UIView alloc]initWithFrame:frame];
    [self addSubview:_photoView];
    //:--加载图片--
    _imageBack = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth(_photoView), ViewHeight(_photoView))];
    _imageBack.pagingEnabled = YES;
    _imageBack.delegate = self;
    _imageBack.showsHorizontalScrollIndicator = NO;
    _imageBack.showsVerticalScrollIndicator = NO;
    [_photoView addSubview:_imageBack];
    //:--蒙版--
    _countView = [[UIView alloc]initWithFrame:CGRectMake(ViewWidth(_photoView) - 30, ViewHeight(_photoView) - 15, 30, 15)];
    _countView.backgroundColor = [UIColor blackColor];
    _countView.alpha = 0.4;
    [_photoView addSubview:_countView];
    //:--显示页数--
    _countlab = [[UILabel alloc]initWithFrame:_countView.frame];
    _countlab.font = FZFont(11);
    _countlab.textColor = [UIColor whiteColor];
    _countlab.textAlignment = NSTextAlignmentCenter;
    [_photoView addSubview:_countlab];
}
//MARK:--给label赋值--
- (void)setTitleArr:(NSArray *)titleArr{
    _titleArr = titleArr;
    //:--判断数组是为了防止数组越界--
    if (titleArr.count == 1) {
        _oneLab.text = titleArr[0];
    }else if (titleArr.count == 2){
        _oneLab.text = titleArr[0];
        _twoLab.text = titleArr[1];
    }else if (titleArr.count == 3){
        _oneLab.text = titleArr[0];
        _twoLab.text = titleArr[1];
        _threeLab.text = titleArr[2];
    }else if (titleArr.count == 4){
        _oneLab.text = titleArr[0];
        _twoLab.text = titleArr[1];
        _threeLab.text = titleArr[2];
        _fourLab.text = titleArr[3];
    }else if (titleArr.count == 5){
        _oneLab.text = titleArr[0];
        _twoLab.text = titleArr[1];
        _threeLab.text = titleArr[2];
        _fourLab.text = titleArr[3];
        _fiveLab.text = titleArr[4];
    }
}
//MARK:--创建底部时间，位置，话题label--
- (void)setLocationView:(CGRect)frame{
    //:--加载view--
    _lowView = [[UIView alloc]initWithFrame:frame];
    [self addSubview:_lowView];
    //:--时间标签--
    _timelab = [[UILabel alloc]initWithFrame:CGRectMake(0, 25, 0, 0)];
    _timelab.textColor = Color_999999;
    _timelab.font = FZFont(12);
    [_lowView addSubview:_timelab];
    //:--位置标签--
    _locationLab = [[UILabel alloc]initWithFrame:CGRectMake(0,25, 0, 0)];
    _locationLab.textColor = Color_999999;
    _locationLab.font = FZFont(12);
    [_lowView addSubview:_locationLab];
    //:--话题标签--
    _themeLab = [[UILabel alloc]initWithFrame:CGRectMake(ViewWidth(_lowView) - 150,15, 135, 15)];
    _themeLab.textAlignment = NSTextAlignmentRight;
    _themeLab.textColor = Color_333333;
    _themeLab.font = FZFont(12);
    [_lowView addSubview:_themeLab];
}
//MARK:--给时间label赋值--
- (void)setTimeStr:(NSString *)timeStr{
    _timeStr = timeStr;
    _timeWidth = [TransformChineseToPinying stringWidthFromString:timeStr font:FZFont(12) width:kScreenWidth];
    _timelab.frame = CGRectMake(0, 25, _timeWidth, 15);
    _timelab.text = timeStr;
}
//MARK:--给位置信息label赋值--
- (void)setLocationStr:(NSString *)locationStr{
    _locationStr = locationStr;
    CGFloat width = [TransformChineseToPinying stringWidthFromString:locationStr font:FZFont(12) width:kScreenWidth];
    _locationLab.frame = CGRectMake(_timeWidth + 10, 25, width, 15);
    _locationLab.text = locationStr;
}
//MARK:--给话题label赋值--
- (void)setThemeStr:(NSString *)themeStr{
    _themeStr = themeStr;
    _themeLab.text = themeStr;
}
//MARK:--改变label的对齐方式--
- (void)setType:(TextAlignmentType)type{
    _type = type;
    switch (type) {
        case TextAlignmentTypeLeft:
            [self changeTextAligment:NSTextAlignmentLeft];
            break;
        case TextAlignmentTypeCenter:
            [self changeTextAligment:NSTextAlignmentCenter];
            break;
        default:
            [self changeTextAligment:NSTextAlignmentRight];
            break;
    }
}
//MARK:--创建滚动视图--
- (void)setImageArr:(NSArray *)imageArr{
    _imageArr = imageArr;
    _countN = imageArr.count;
    _imageBack.contentSize = CGSizeMake(ViewWidth(_imageBack)*imageArr.count, photoViewHeight);
    for (int i = 0; i < imageArr.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(ViewWidth(_imageBack)*i, 0,ViewWidth(_imageBack), photoViewHeight)];
        imageView.image = imageArr[i];
        if (_isMask == YES) {
            imageView.layer.cornerRadius = photoViewHeight/2;
            imageView.layer.masksToBounds = YES;
        }
        [_imageBack addSubview:imageView];
    }
    _countlab.text = [NSString stringWithFormat:@"1/%ld",(long)_countN];
}
//MARK:--UIScrollViewDelegate--
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _countlab.text = [NSString stringWithFormat:@"%.0f/%ld",scrollView.contentOffset.x/scrollView.size.width + 1,(long)_countN];
}
//MARK:--改变label上面文字对齐方式--
- (void)changeTextAligment:(NSTextAlignment)type{
    for (UILabel *tmp in self.textView.subviews) {
        if ([tmp isKindOfClass:[UILabel class]]) {
            tmp.textAlignment = type;
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
