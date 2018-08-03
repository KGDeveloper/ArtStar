//
//  PreviewVerticalView.m
//  ArtStar
//
//  Created by abc on 5/11/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "PreviewVerticalView.h"

@interface PreviewVerticalView ()<UIScrollViewDelegate>{
    NSInteger _countN;
    CGFloat _timeWidth;
}

@property (nonatomic,strong) UILabel *oneLab;
@property (nonatomic,strong) UILabel *twoLab;
@property (nonatomic,strong) UILabel *threeLab;
@property (nonatomic,strong) UILabel *fourLab;
@property (nonatomic,strong) UILabel *fiveLab;
@property (nonatomic,strong) UIView *textView;
@property (nonatomic,strong) UIScrollView *imageBackView;
@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) UIView *countView;
@property (nonatomic,strong) UILabel *countlab;
@property (nonatomic,assign) LabelTextLocationType type;
@property (nonatomic,strong) UIView *lowView;
@property (nonatomic,strong) UILabel *timelab;
@property (nonatomic,strong) UILabel *locationLab;
@property (nonatomic,strong) UILabel *themeLab;

@end

@implementation PreviewVerticalView

- (instancetype)initWithFrame:(CGRect)frame type:(LabelTextLocationType)type{
    if (self = [super initWithFrame:frame]) {
        self.type = type;
        [self setLabelView:type];
        [self setImage];
        [self setLocationView];
        _countN = 1;
    }
    return self;
}

- (void)setLabelView:(LabelTextLocationType)type{
    _textView = [[UIView alloc]initWithFrame:CGRectMake(ViewWidth(self) - textViewHeight - 15, 0, textViewHeight, 281)];
    [self addSubview:_textView];
    switch (type) {
        case LabelTextLocationTypeTop:
            _oneLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 22, 0)];
            _oneLab.center = CGPointMake(11, 281/2);
            _twoLab = [[UILabel alloc]initWithFrame:CGRectMake(32, 0, 22, 0)];
            _twoLab.center = CGPointMake(11, 281/2);
            _threeLab = [[UILabel alloc]initWithFrame:CGRectMake(64, 0, 22, 0)];
            _threeLab.center = CGPointMake(53, 281/2);
            _fourLab = [[UILabel alloc]initWithFrame:CGRectMake(96, 0, 22, 0)];
            _fourLab.center = CGPointMake(85, 281/2);
            _fiveLab = [[UILabel alloc]initWithFrame:CGRectMake(128, 0, 22, 0)];
            _fiveLab.center = CGPointMake(117, 281/2);
            break;
        default:
            _oneLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 22, 281)];
            _twoLab = [[UILabel alloc]initWithFrame:CGRectMake(32, 0, 22, 281)];
            _threeLab = [[UILabel alloc]initWithFrame:CGRectMake(64, 0, 22, 281)];
            _fourLab = [[UILabel alloc]initWithFrame:CGRectMake(96, 0, 22, 281)];
            _fiveLab = [[UILabel alloc]initWithFrame:CGRectMake(128, 0, 22, 281)];
            break;
    }
    _oneLab.numberOfLines = 0;
    _oneLab.font = FZFont(12);
    _oneLab.textColor = Color_333333;
    [_textView addSubview:_oneLab];
    
    _twoLab.numberOfLines = 0;
    _twoLab.font = FZFont(12);
    _twoLab.textColor = Color_333333;
    [_textView addSubview:_twoLab];
    
    _threeLab.numberOfLines = 0;
    _threeLab.font = FZFont(12);
    _threeLab.textColor = Color_333333;
    [_textView addSubview:_threeLab];
    
    _fourLab.numberOfLines = 0;
    _fourLab.font = FZFont(12);
    _fourLab.textColor = Color_333333;
    [_textView addSubview:_fourLab];
    
    _fiveLab.numberOfLines = 0;
    _fiveLab.font = FZFont(12);
    _fiveLab.textColor = Color_333333;
    [_textView addSubview:_fiveLab];
}

- (void)setImage{
    _backView = [[UIView alloc]initWithFrame:CGRectMake(15, 0, kScreenWidth - textViewHeight - 50, (kScreenWidth - textViewHeight - 50)/354*544)];
    [self addSubview:_backView];
    
    _imageBackView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth(_backView), ViewHeight(_backView))];
    _imageBackView.pagingEnabled = YES;
    _imageBackView.showsVerticalScrollIndicator = NO;
    _imageBackView.showsHorizontalScrollIndicator = NO;
    _imageBackView.delegate = self;
    [_backView addSubview:_imageBackView];
    //:--蒙版--
    _countView = [[UIView alloc]initWithFrame:CGRectMake(ViewWidth(_backView) - 30, ViewHeight(_backView) - 15, 30, 15)];
    _countView.backgroundColor = [UIColor blackColor];
    _countView.alpha = 0.4;
    [_backView addSubview:_countView];
    //:--显示页数--
    _countlab = [[UILabel alloc]initWithFrame:_countView.frame];
    _countlab.font = FZFont(11);
    _countlab.textColor = [UIColor whiteColor];
    _countlab.textAlignment = NSTextAlignmentCenter;
    [_backView addSubview:_countlab];
}
//MARK:--创建底部时间，位置，话题label--
- (void)setLocationView{
    //:--加载view--
    _lowView = [[UIView alloc]initWithFrame:CGRectMake(15, ViewHeight(_backView), kScreenWidth - 30, 50)];
    _lowView.backgroundColor = [UIColor whiteColor];
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
//MARK:--创建滚动视图--
- (void)setImageArr:(NSArray *)imageArr{
    _imageArr = imageArr;
    _countN = imageArr.count;
    _imageBackView.contentSize = CGSizeMake(ViewWidth(_imageBackView)*imageArr.count, ViewHeight(_imageBackView));
    for (int i = 0; i < imageArr.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(ViewWidth(_imageBackView)*i, 0,ViewWidth(_imageBackView), ViewWidth(_imageBackView))];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.image = imageArr[i];
        [_imageBackView addSubview:imageView];
    }
    _countlab.text = [NSString stringWithFormat:@"1/%ld",(long)_countN];
}
//MARK:--给label赋值--
- (void)setTitleArr:(NSArray *)titleArr{
    _titleArr = titleArr;
    //:--判断数组是为了防止数组越界--
    if (self.type == LabelTextLocationTypeTop) {
        if (titleArr.count == 1) {
            _oneLab.frame = CGRectMake(0, 0, 22, [TransformChineseToPinying stringWidthFromString:titleArr[0] font:FZFont(12) height:281]);
        }else if (titleArr.count == 2){
            _oneLab.frame = CGRectMake(0, 0, 22, [TransformChineseToPinying stringWidthFromString:titleArr[0] font:FZFont(12) height:281]);
            _twoLab.frame = CGRectMake(32, 0, 22, [TransformChineseToPinying stringWidthFromString:titleArr[1] font:FZFont(12) height:281]);
        }else if (titleArr.count == 3){
            _oneLab.frame = CGRectMake(0, 0, 22, [TransformChineseToPinying stringWidthFromString:titleArr[0] font:FZFont(12) height:281]);
            _twoLab.frame = CGRectMake(32, 0, 22, [TransformChineseToPinying stringWidthFromString:titleArr[1] font:FZFont(12) height:281]);
            _threeLab.frame = CGRectMake(64, 0, 22, [TransformChineseToPinying stringWidthFromString:titleArr[2] font:FZFont(12) height:281]);
        }else if (titleArr.count == 4){
            _oneLab.frame = CGRectMake(0, 0, 22, [TransformChineseToPinying stringWidthFromString:titleArr[0] font:FZFont(12) height:281]);
            _twoLab.frame = CGRectMake(32, 0, 22, [TransformChineseToPinying stringWidthFromString:titleArr[1] font:FZFont(12) height:281]);
            _threeLab.frame = CGRectMake(64, 0, 22, [TransformChineseToPinying stringWidthFromString:titleArr[2] font:FZFont(12) height:281]);
            _fourLab.frame = CGRectMake(96, 0, 22, [TransformChineseToPinying stringWidthFromString:titleArr[3] font:FZFont(12) height:281]);
        }else if (titleArr.count == 5){
            _oneLab.frame = CGRectMake(0, 0, 22, [TransformChineseToPinying stringWidthFromString:titleArr[0] font:FZFont(12) height:281]);
            _twoLab.frame = CGRectMake(32, 0, 22, [TransformChineseToPinying stringWidthFromString:titleArr[1] font:FZFont(12) height:281]);
            _threeLab.frame = CGRectMake(64, 0, 22, [TransformChineseToPinying stringWidthFromString:titleArr[2] font:FZFont(12) height:281]);
            _fourLab.frame = CGRectMake(96, 0, 22, [TransformChineseToPinying stringWidthFromString:titleArr[3] font:FZFont(12) height:281]);
            _fiveLab.frame = CGRectMake(128, 0, 22, [TransformChineseToPinying stringWidthFromString:titleArr[4] font:FZFont(12) height:281]);
        }
    }
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
//MARK:--UIScrollViewDelegate--
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _countlab.text = [NSString stringWithFormat:@"%.0f/%ld",scrollView.contentOffset.x/scrollView.size.width + 1,(long)_countN];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
