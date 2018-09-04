//
//  MusicExhibitTableViewCell.m
//  ArtStar
//
//  Created by abc on 5/29/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "MusicExhibitTableViewCell.h"

@interface MusicExhibitTableViewCell ()

@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) UIImageView *topImage;
@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UILabel *detailLab;
@property (nonatomic,strong) UILabel *spaceLab;
@property (nonatomic,strong) UIView *starView;

@end

@implementation MusicExhibitTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setCell];
    }
    return self;
}

- (void)setCell{
    
    _topImage = [UIImageView new];
    _titleLab = [UILabel new];
    _detailLab = [UILabel new];
    _spaceLab = [UILabel new];
    _backView = [UIView new];
    _starView = [UIView new];
    
    [self.contentView sd_addSubviews:@[_backView,_topImage,_titleLab,_detailLab,_spaceLab,_starView]];
    
    _backView.backgroundColor = [UIColor whiteColor];
    _backView.layer.borderColor = Color_ededed.CGColor;
    _backView.layer.borderWidth = 1;
    _backView.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(100);
    
    _topImage.imageURL = [NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527572257661&di=2ff8d0b518818b90ac7e69cc7aa250d7&imgtype=0&src=http%3A%2F%2Fwww.jzjxqm.com%2Ffile%2Fupload%2F201511%2F17%2F17-01-24-10-10003.jpg.thumb.jpg"];
    _topImage.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(self.contentView, 0).widthIs(100).heightIs(100);
    
    _titleLab.textColor = Color_333333;
    _titleLab.text = @"轩哥哥北京艺术展";
    _titleLab.font = SYFont(13);
    _titleLab.sd_layout.leftSpaceToView(_topImage, 15).topSpaceToView(self.contentView, 10).rightSpaceToView(self.contentView, 15).heightIs(15);
    
    _spaceLab.textColor = Color_333333;
    _spaceLab.text = @"1.8km";
    _spaceLab.font = SYFont(10);
    _spaceLab.textAlignment = NSTextAlignmentRight;
    _spaceLab.sd_layout.topSpaceToView(_titleLab, 10).rightSpaceToView(self.contentView, 15).heightIs(15).widthIs(100);
    
    _starView.sd_layout.leftSpaceToView(_topImage, 15).topSpaceToView(_titleLab, 10).widthIs(150).heightIs(12);
    
    for (int i = 0; i < 4; i++) {
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(17*i, 0, 12, 12)];
        image.image = Image(@"star");
        [_starView addSubview:image];
    }
    
    _detailLab.attributedText = [TransformChineseToPinying string:@"成都博达展示非常期待您的合作。针对公司提供的展厅设计，在合作达成之前请注意我公司的服务地区为四川，以确定您的地理位置是否处于我司的业务覆盖范围之内。展厅设计主要以立体展现的形式展示，整套服务流程下来的预算为20-100万元，请您知晓" font:SYFont(12) space:9];
    _detailLab.font = SYFont(12);
    _detailLab.textColor = Color_999999;
    _detailLab.numberOfLines = 2;
    _detailLab.lineBreakMode = NSLineBreakByTruncatingTail;
    _detailLab.sd_layout.topSpaceToView(_starView, 10).rightSpaceToView(self.contentView, 15).leftSpaceToView(_topImage, 15).heightIs(40);
    
}

- (void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
    NSArray<NSDictionary *> *imageArr = dataDic[@"imgList"];
    NSDictionary *imageDic = [imageArr firstObject];
    [_topImage sd_setImageWithURL:[NSURL URLWithString:imageDic[@"locationimg"]]];
    _titleLab.text = dataDic[@"showname"];
    _detailLab.attributedText = [TransformChineseToPinying string:dataDic[@"recommend"] font:SYFont(12) space:9];
}

- (void)setInDic:(NSDictionary *)inDic{
    _inDic = inDic;
    NSArray<NSDictionary *> *imageArr = inDic[@"images"];
    if (imageArr.count > 0) {
        NSDictionary *imageDic = [imageArr firstObject];
        [_topImage sd_setImageWithURL:[NSURL URLWithString:imageDic[@"iamgeURL"]]];
    }
    _titleLab.text = inDic[@"username"];
    if (![inDic[@"blurb"] isKindOfClass:[NSNull class]]) {
        _detailLab.attributedText = [TransformChineseToPinying string:inDic[@"blurb"] font:SYFont(12) space:9];
    }else{
        _detailLab.attributedText = [TransformChineseToPinying string:@"" font:SYFont(12) space:9];
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
