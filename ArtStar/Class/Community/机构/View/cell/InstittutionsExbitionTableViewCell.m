//
//  InstittutionsExbitionTableViewCell.m
//  ArtStar
//
//  Created by 文艺星球 on 2018/8/29.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "InstittutionsExbitionTableViewCell.h"

@interface InstittutionsExbitionTableViewCell ()

@property (nonatomic,strong) UILabel *titleLab;

@end

@implementation InstittutionsExbitionTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = Color_fafafa;
        [self setCell];
    }
    return self;
}

- (void)setCell{
    _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, ViewWidth(self.contentView) - 30, 30)];
    _titleLab.text = @"正在展览";
    _titleLab.textColor = Color_333333;
    _titleLab.font = SYFont(14);
    [self.contentView addSubview:_titleLab];
    
    [self createViewWithFrame:CGRectMake(0, 30, kScreenWidth, (kScreenWidth - 30)/690*280 + 55) model:nil];
    [self createViewWithFrame:CGRectMake(0, (kScreenWidth - 30)/690*280 + 86, kScreenWidth, (kScreenWidth - 30)/690*280 + 55) model:nil];
    [self createViewWithFrame:CGRectMake(0, (kScreenWidth - 30)/690*280 + 86 + (kScreenWidth - 30)/690*280 + 55, kScreenWidth, (kScreenWidth - 30)/690*280 + 55) model:nil];
}

- (UIView *)createViewWithFrame:(CGRect)frame model:(NSDictionary *)modelDic{
    UIView *exbihitionView = [[UIView alloc]initWithFrame:frame];
    exbihitionView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:exbihitionView];
    
    UILabel *nameLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, ViewWidth(exbihitionView) - 30, 15)];
    nameLab.textColor = Color_333333;
    nameLab.font = SYFont(14);
    nameLab.text = @"战区";
    [exbihitionView addSubview:nameLab];
    
    UIButton *rightBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtu.frame = CGRectMake(ViewWidth(exbihitionView) - 30, 15, 15, 15);
    [rightBtu setImage:Image(@"report open") forState:UIControlStateNormal];
    rightBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightBtu addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    [exbihitionView addSubview:rightBtu];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 40, kScreenWidth - 30, (kScreenWidth - 30)/690*280)];
    imageView.backgroundColor = Color_ededed;
    imageView.layer.cornerRadius = 5;
    imageView.layer.masksToBounds = YES;
    [exbihitionView addSubview:imageView];
    
    return exbihitionView;
}

- (void)rightAction:(UIButton *)sender{
    
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
