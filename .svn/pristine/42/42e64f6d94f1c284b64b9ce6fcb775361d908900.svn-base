//
//  MineLoveMoviesAndMusicAndBooksCell.m
//  ArtStar
//
//  Created by abc on 6/11/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "MineLoveMoviesAndMusicAndBooksCell.h"

@implementation MineLoveMoviesAndMusicAndBooksCell

- (IBAction)chooseMovies:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(pushToViewControllerChooseYourLove:)]) {
        [self.delegate pushToViewControllerChooseYourLove:@"电影"];
    }
}
- (IBAction)chooseMusic:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(pushToViewControllerChooseYourLove:)]) {
        [self.delegate pushToViewControllerChooseYourLove:@"音乐"];
    }
}

- (IBAction)chooseBooks:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(pushToViewControllerChooseYourLove:)]) {
        [self.delegate pushToViewControllerChooseYourLove:@"书籍"];
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
