//
//  MineEditMyLabelCell.m
//  ArtStar
//
//  Created by abc on 6/11/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "MineEditMyLabelCell.h"

@interface MineEditMyLabelCell ()

@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UIView *labView;
@property (nonatomic,strong) UIButton *writeLabBtu;

@end

@implementation MineEditMyLabelCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setCell];
    }
    return self;
}
- (void)setCell{
    
    _titleLab = [UILabel new];
    _labView = [UIView new];
    _writeLabBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.contentView sd_addSubviews:@[_titleLab,_labView,_writeLabBtu]];
    
    _titleLab.text = @"我的标签";
    _titleLab.textColor = Color_333333;
    _titleLab.font = SYBFont(13);
    _titleLab.sd_layout.leftSpaceToView(self.contentView, 15).topSpaceToView(self.contentView, 25).widthIs(70).heightIs(15);
    
    [_writeLabBtu setTitle:@"请领取您的专属标签" forState:UIControlStateNormal];
    [_writeLabBtu setTitleColor:Color_333333 forState:UIControlStateNormal];
    [_writeLabBtu setImage:Image(@"report open") forState:UIControlStateNormal];
    _writeLabBtu.titleLabel.font = SYFont(12);
    _writeLabBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    _writeLabBtu.titleEdgeInsets = UIEdgeInsetsMake(0,0, 0, 14);
    _writeLabBtu.imageEdgeInsets = UIEdgeInsetsMake(0,105, 0,-105);
    [_writeLabBtu addTarget:self action:@selector(writeMyLabel) forControlEvents:UIControlEventTouchUpInside];
    _writeLabBtu.sd_layout.leftSpaceToView(_titleLab, 20).rightSpaceToView(self.contentView, 15).centerYEqualToView(_titleLab).heightIs(20);
    
    _labView.sd_layout.leftEqualToView(_titleLab).rightEqualToView(_writeLabBtu).topSpaceToView(_titleLab, 50).heightIs(55);
}

- (CGFloat)arrayToHeight:(NSArray *)arr{
    CGFloat width = 0;
    CGFloat height = 0;
    NSInteger number = 1;
    for (int i = 0; i < arr.count; i++) {
        if (width + [TransformChineseToPinying stringWidthFromString:arr[i] font:SYFont(12) width:kScreenWidth - 30] + 40 > kScreenWidth - 30) {
            width = 0;
            height = 30*number;
            number ++;
        }
        width = width + [TransformChineseToPinying stringWidthFromString:arr[i] font:SYFont(12) width:kScreenWidth - 30] + 40;
    }
    return height + 100;
}

- (void)setTitleArr:(NSArray *)titleArr{
    _titleArr = titleArr;
    if (titleArr.count > 0) {
        CGFloat width = 0;
        CGFloat height = 0;
        NSInteger number = 1;
        for (int i = 0; i < titleArr.count; i++) {
            if (width + [TransformChineseToPinying stringWidthFromString:titleArr[i] font:SYFont(12) width:kScreenWidth - 30] + 40 > kScreenWidth - 30) {
                width = 0;
                height = 30*number;
                number ++;
            }
            [_labView addSubview:[self createLabelWithTitle:titleArr[i] frame:CGRectMake(width, height, [TransformChineseToPinying stringWidthFromString:titleArr[i] font:SYFont(12) width:kScreenWidth - 30] + 20, 20)]];
            width = width + [TransformChineseToPinying stringWidthFromString:titleArr[i] font:SYFont(12) width:kScreenWidth - 30] + 40;
        }
        _labView.sd_layout.leftEqualToView(_titleLab).rightEqualToView(_writeLabBtu).topSpaceToView(_titleLab, 25).heightIs(height + 10);
    }
}

- (UILabel *)createLabelWithTitle:(NSString *)title frame:(CGRect)frame{
    UILabel *lab = [[UILabel alloc]initWithFrame:frame];
    lab.text = title;
    lab.backgroundColor = Color_333333;
    lab.textColor = [UIColor whiteColor];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = SYFont(12);
    lab.layer.cornerRadius = 10;
    lab.layer.masksToBounds = YES;
    return lab;
}

- (void)showLabel{
    _labView.hidden = NO;
}
- (void)hidenLabel{
    _labView.hidden = YES;
}
- (void)writeMyLabel{
    if ([self.delegate respondsToSelector:@selector(pushMyWordViewController)]) {
        [self.delegate pushMyWordViewController];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
