//
//  InstittutionsCell.m
//  ArtStar
//
//  Created by abc on 5/29/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "InstittutionsCell.h"

@interface InstittutionsCell ()

@property (nonatomic,strong) UIImageView *topImage;
@property (nonatomic,strong) UILabel *nameLab;
@property (nonatomic,strong) UIView *starView;
@property (nonatomic,strong) UILabel *priceLab;
@property (nonatomic,strong) UILabel *spaceLab;
@property (nonatomic,strong) UILabel *locationLab;
@property (nonatomic,strong) UIView *line;

@property (nonatomic,strong) UILabel *timeLab;
@property (nonatomic,strong) UILabel *detaialLab;


@end

@implementation InstittutionsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setCell];
    }
    return self;
}

- (void)setCell{
    
    _topImage = [UIImageView new];
    _nameLab = [UILabel new];
    _starView = [UIView new];
    _priceLab = [UILabel new];
    _spaceLab = [UILabel new];
    _locationLab = [UILabel new];
    _timeLab = [UILabel new];
    _detaialLab = [UILabel new];
    _line = [UIView new];
    
    [self.contentView sd_addSubviews:@[_topImage,_nameLab,_starView,_priceLab,_spaceLab,_locationLab,_timeLab,_detaialLab,_line]];
    
    _topImage.imageURL = [NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527572257661&di=2ff8d0b518818b90ac7e69cc7aa250d7&imgtype=0&src=http%3A%2F%2Fwww.jzjxqm.com%2Ffile%2Fupload%2F201511%2F17%2F17-01-24-10-10003.jpg.thumb.jpg"];
    _topImage.sd_layout.leftSpaceToView(self.contentView, 15).topSpaceToView(self.contentView, 15).widthIs(100).heightIs(100);
    
    _nameLab.text = @"万达影城";
    _nameLab.textColor = Color_333333;
    _nameLab.font = SYBFont(13);
    _nameLab.sd_layout.leftSpaceToView(_topImage, 15).topSpaceToView(self.contentView, 25).widthIs(150).heightIs(15);
    
    _starView.sd_layout.rightSpaceToView(self.contentView, 15).centerYEqualToView(_nameLab).widthIs(80).heightIs(15);
    
    for (int i = 0; i < 4; i++) {
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(15*i, 2, 11, 11)];
        image.image = Image(@"star");
        [_starView addSubview:image];
    }
    
    _priceLab.text = @"￥46.9起";
    _priceLab.textColor = Color_999999;
    _priceLab.font = SYFont(12);
    _priceLab.sd_layout.leftSpaceToView(_topImage, 15).centerYEqualToView(_topImage).widthIs(150).heightIs(15);
    
    _spaceLab.text = @"1.6km";
    _spaceLab.textColor = Color_999999;
    _spaceLab.font = SYFont(12);
    _spaceLab.textAlignment = NSTextAlignmentRight;
    _spaceLab.sd_layout.rightSpaceToView(self.contentView, 15).centerYEqualToView(_priceLab).widthIs(150).heightIs(15);
    
    _locationLab.text = @"朝阳区酒仙桥路18号颐提港4层";
    _locationLab.textColor = Color_999999;
    _locationLab.font = SYFont(12);
    _locationLab.sd_layout.leftSpaceToView(_topImage, 15).rightSpaceToView(self.contentView, 15).topSpaceToView(_priceLab, 15).heightIs(15);
    
    _timeLab.text = @"开馆时间：8：00-20：00";
    _timeLab.textColor = Color_999999;
    _timeLab.font = SYFont(12);
    _timeLab.hidden = YES;
    _timeLab.sd_layout.leftSpaceToView(_topImage, 15).topSpaceToView(_nameLab, 10).widthIs(150).heightIs(15);
    
    _detaialLab.text = @"迪拜位于阿拉伯半岛中部、阿拉伯湾南岸，是海湾地区中心。与南亚次大陆隔海相望，与卡塔尔为邻、与沙特阿拉伯交界、与阿曼毗连。迪拜常住人口约280万人，本地人口占15%左右，外籍人士来自全球200多个国家和地区。常住迪拜的华人有约34万人，其他外籍人士来自诸如埃及、黎巴嫩、约旦、伊朗、印度、巴基斯坦、菲律宾等。";
    _detaialLab.textColor = Color_999999;
    _detaialLab.font = SYFont(12);
    _detaialLab.hidden = YES;
    _detaialLab.sd_layout.leftSpaceToView(_topImage, 15).topSpaceToView(_locationLab, 10).rightSpaceToView(self.contentView, 15).heightIs(15);
    
    _line.backgroundColor = Color_fafafa;
    _line.sd_layout.leftSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(10);
    
}

- (void)setIsChageUI:(BOOL)isChageUI{
    _isChageUI = isChageUI;
    if (isChageUI == YES) {
        _timeLab.hidden = NO;
        _detaialLab.hidden = NO;
        _priceLab.hidden = YES;
        _timeLab.sd_layout.leftSpaceToView(_topImage, 15).topSpaceToView(_nameLab, 10).widthIs(150).heightIs(15);
        _locationLab.sd_layout.leftSpaceToView(_topImage, 15).topSpaceToView(_timeLab, 10).rightSpaceToView(self.contentView, 15).heightIs(15);
        _detaialLab.sd_layout.leftSpaceToView(_topImage, 15).topSpaceToView(_locationLab, 10).rightSpaceToView(self.contentView, 15).heightIs(15);
        _spaceLab.sd_layout.rightSpaceToView(self.contentView, 15).topSpaceToView(_starView, 10).widthIs(150).heightIs(15);
        [self.contentView setNeedsLayout];
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
