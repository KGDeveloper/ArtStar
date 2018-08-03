//
//  HotMoviesCell.h
//  ArtStar
//
//  Created by abc on 5/30/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotMoviesCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *movieImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *introduceLab;
@property (weak, nonatomic) IBOutlet UIButton *buyTickBtu;
@property (weak, nonatomic) IBOutlet UILabel *scoreLab;

- (void)hotMovies;
- (void)willPlayMovies;

@end
