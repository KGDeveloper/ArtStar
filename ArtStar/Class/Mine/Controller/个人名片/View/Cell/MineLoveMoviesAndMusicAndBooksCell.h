//
//  MineLoveMoviesAndMusicAndBooksCell.h
//  ArtStar
//
//  Created by abc on 6/11/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MineLoveMoviesAndMusicAndBooksCellDelegate <NSObject>

- (void)pushToViewControllerChooseYourLove:(NSString *)title;

@end

@interface MineLoveMoviesAndMusicAndBooksCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIScrollView *moviesView;
@property (weak, nonatomic) IBOutlet UIScrollView *musicView;
@property (weak, nonatomic) IBOutlet UIScrollView *bookView;
@property (weak, nonatomic) IBOutlet UIButton *bookChoose;
@property (weak, nonatomic) IBOutlet UIButton *musicChoose;
@property (weak, nonatomic) IBOutlet UIButton *moviesChoose;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *moivesHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *musicHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bookHeight;

@property (weak,nonatomic) id<MineLoveMoviesAndMusicAndBooksCellDelegate>delegate;


@property (nonatomic,copy) NSArray *bookArr;
@property (nonatomic,copy) NSArray *moviesArr;
@property (nonatomic,copy) NSArray *musicArr;

@end
