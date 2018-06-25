//
//  HotMoviesCell.m
//  ArtStar
//
//  Created by abc on 5/30/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "HotMoviesCell.h"

@implementation HotMoviesCell

- (void)hotMovies{
    [self.buyTickBtu setTitle:@"购票" forState:UIControlStateNormal];
}

- (void)willPlayMovies{
    [self.buyTickBtu setTitle:@"预定" forState:UIControlStateNormal];
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
