//
//  CommunityExhibitionDetailTimeAndAddressCell.m
//  ArtStar
//
//  Created by 文艺星球 on 2018/8/1.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "CommunityExhibitionDetailTimeAndAddressCell.h"

@implementation CommunityExhibitionDetailTimeAndAddressCell

- (void)changeImageWithScoreNumber:(double)scroe{
    if (scroe <= 1) {
        if (modf(scroe, &scroe) == 0.0) {
            _oneImage.image = Image(@"stargray");
        }else{
            _oneImage.image = Image(@"yellowstay");
        }
        _twoImage.image = Image(@"stargray");
        _threeImage.image = Image(@"stargray");
        _fourImage.image = Image(@"stargray");
        _fiveImage.image = Image(@"stargray");
    }else if (scroe > 1 && scroe <= 2){
        if (modf(scroe, &scroe) == 0.0) {
            _twoImage.image = Image(@"stargray");
        }else{
            _twoImage.image = Image(@"yellowstay");
        }
        _oneImage.image = Image(@"star");
        _threeImage.image = Image(@"stargray");
        _fourImage.image = Image(@"stargray");
        _fiveImage.image = Image(@"stargray");
    }else if (scroe > 2 && scroe <= 3){
        if (modf(scroe, &scroe) == 0.0) {
            _threeImage.image = Image(@"stargray");
        }else{
            _threeImage.image = Image(@"yellowstay");
        }
        _oneImage.image = Image(@"star");
        _twoImage.image = Image(@"star");
        _fourImage.image = Image(@"stargray");
        _fiveImage.image = Image(@"stargray");
    }else if (scroe > 3 && scroe <= 4){
        if (modf(scroe, &scroe) == 0.0) {
            _fourImage.image = Image(@"stargray");
        }else{
            _fourImage.image = Image(@"yellowstay");
        }
        _oneImage.image = Image(@"star");
        _twoImage.image = Image(@"star");
        _threeImage.image = Image(@"star");
        _fiveImage.image = Image(@"stargray");
    }else if (scroe > 4 && scroe <= 5){
        if (modf(scroe, &scroe) == 0.0) {
            _fiveImage.image = Image(@"stargray");
        }else{
            _fiveImage.image = Image(@"yellowstay");
        }
        _oneImage.image = Image(@"star");
        _twoImage.image = Image(@"star");
        _threeImage.image = Image(@"star");
        _fourImage.image = Image(@"stargray");
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
