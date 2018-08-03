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

- (void)setBookArr:(NSArray *)bookArr{
    _bookArr = bookArr;
    if (bookArr.count > 0) {
        _bookView.contentSize = CGSizeMake(120*bookArr.count, ViewHeight(_bookView));
        for (int i = 0; i < bookArr.count; i++) {
            NSDictionary *dic = bookArr[i];
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(120*i, 0, 100, 130)];
            [imageView sd_setImageWithURL:[NSURL URLWithString:dic[@"imageUrl"]]];
            [_bookView addSubview:imageView];
            
            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(120*i, 130, 100, ViewHeight(_bookView) - 130)];
            lab.text = dic[@"bookName"];
            lab.textColor = Color_333333;
            lab.textAlignment = NSTextAlignmentCenter;
            lab.font = SYFont(12);
            [_bookView addSubview:lab];
        }
    }
}

- (void)setMoviesArr:(NSArray *)moviesArr{
    _moviesArr = moviesArr;
    if (moviesArr.count > 0) {
        _moviesView.contentSize = CGSizeMake(120*moviesArr.count, ViewHeight(_moviesView));
        for (int i = 0; i < moviesArr.count; i++) {
            NSDictionary *dic = moviesArr[i];
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(120*i, 0, 100, 130)];
            [imageView sd_setImageWithURL:[NSURL URLWithString:dic[@"imageUrl"]]];
            [_moviesView addSubview:imageView];
            
            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(120*i, 130, 100, ViewHeight(_bookView) - 130)];
            lab.text = dic[@"movieName"];
            lab.textColor = Color_333333;
            lab.textAlignment = NSTextAlignmentCenter;
            lab.font = SYFont(12);
            [_moviesView addSubview:lab];
        }
    }
}

- (void)setMusicArr:(NSArray *)musicArr{
    _musicArr = musicArr;
    if (musicArr.count > 0) {
        _musicView.contentSize = CGSizeMake(120*musicArr.count, ViewHeight(_musicView));
        for (int i = 0; i < musicArr.count; i++) {
            NSDictionary *dic = musicArr[i];
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(120*i, 0, 100, 100)];
            [imageView sd_setImageWithURL:[NSURL URLWithString:dic[@"imageUrl"]]];
            imageView.layer.cornerRadius = 50;
            imageView.layer.masksToBounds = YES;
            [_musicView addSubview:imageView];
            
            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(120*i, 120, 100, ViewHeight(_musicView) - 100)];
            lab.text = dic[@"musicName"];
            lab.textColor = Color_333333;
            lab.textAlignment = NSTextAlignmentCenter;
            lab.font = SYFont(12);
            [_musicView addSubview:lab];
        }
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
