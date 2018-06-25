//
//  MusicActorCell.m
//  ArtStar
//
//  Created by abc on 5/28/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "MusicActorCell.h"

@interface MusicActorCell ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIView *line;

@end


@implementation MusicActorCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setCell];
    }
    return self;
}

- (void)setCell{
    _scrollView = [UIScrollView new];
    _titleLabel = [UILabel new];
    _line = [UIView new];
    
    [self.contentView sd_addSubviews:@[_scrollView,_titleLabel,_line]];
    
    _titleLabel.text = @"演出演员（3）";
    _titleLabel.textColor = Color_333333;
    _titleLabel.font = SYFont(14);
    _titleLabel.sd_layout.leftSpaceToView(self.contentView, 15).topSpaceToView(self.contentView, 20).rightSpaceToView(self.contentView, 15).heightIs(15);
    
    _scrollView.delegate = self;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.sd_layout.leftSpaceToView(self.contentView, 15).rightSpaceToView(self.contentView, 15).topSpaceToView(_titleLabel, 15).heightIs(140 + 30);
    
    _line.backgroundColor = Color_fafafa;
    _line.sd_layout.leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).heightIs(10);
    
}

- (void)setDataArr:(NSArray *)dataArr{
    _dataArr = dataArr;
    _scrollView.contentSize = CGSizeMake(120*dataArr.count,170);
    for (int i = 0; i < dataArr.count; i++) {
        NSDictionary *dict = dataArr[i];
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(120*i, 0, 110, 140)];
        [image sd_setImageWithURL:[NSURL URLWithString:dict[@"image"]]];
        [_scrollView addSubview:image];

        UILabel *nameLab = [[UILabel alloc]initWithFrame:CGRectMake(120*i,155, 110, 15)];
        nameLab.textColor = Color_333333;
        nameLab.textAlignment = NSTextAlignmentCenter;
        nameLab.text = dict[@"name"];
        nameLab.font = SYFont(12);
        [_scrollView addSubview:nameLab];
    }
}

- (void)setTitle:(NSString *)title{
    _title = title;
    _titleLabel.text = [NSString stringWithFormat:@"演出人员（%@）",title];
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
