//
//  MineWordLoveFoodsCell.m
//  ArtStar
//
//  Created by abc on 6/12/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "MineWordLoveFoodsCell.h"

@implementation MineWordLoveFoodsCell

- (void)addArray:(NSArray *)arr toView:(UIView *)addView{
    if (arr.count == 0) {
        return;
    }else{
        CGFloat wight = 0;
        CGFloat height = 0;
        
        [addView removeAllSubviews];
        
        for (int i = 0; i < arr.count; i++) {
            NSDictionary *dic = arr[i];
            if (wight + 30 + [TransformChineseToPinying stringWidthFromString:dic[@"name"] font:SYFont(12) width:ViewWidth(addView)] + 20 >= kScreenWidth - 30) {
                wight = 0;
                height = height + 30;
            }
            [addView addSubview:[self createLabel:CGRectMake(wight, height, [TransformChineseToPinying stringWidthFromString:dic[@"name"] font:SYFont(12) width:ViewWidth(addView)] + 20, 20) title:dic[@"name"]]];
            wight = wight + 30 + [TransformChineseToPinying stringWidthFromString:dic[@"name"] font:SYFont(12) width:ViewWidth(addView)] + 20;
        }
        [self setNeedsLayout];
    }
}

- (UILabel *)createLabel:(CGRect)frame title:(NSString *)title{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.text = title;
    label.backgroundColor = [UIColor colorWithHexString:@"#4d4d4d"];
    label.textColor = [UIColor whiteColor];
    label.font = SYFont(12);
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = 10;
    label.layer.masksToBounds = YES;
    return label;
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
