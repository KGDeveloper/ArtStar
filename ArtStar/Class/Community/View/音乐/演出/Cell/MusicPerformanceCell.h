//
//  MusicPerformanceCell.h
//  ArtStar
//
//  Created by abc on 5/28/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MusicPerformanceCellDelegate <NSObject>

- (void)hotClick:(NSInteger)index;
- (void)buyCLick:(NSInteger)index;

@end

@interface MusicPerformanceCell : UITableViewCell

@property (nonatomic,strong) UIImageView *topImage;
@property (nonatomic,strong) UIButton *hotBtu;
@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) UILabel *timeLab;
@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UILabel *locationLab;
@property (nonatomic,strong) UILabel *priceLab;
@property (nonatomic,strong) UIButton *buyBtu;

- (void)willStarStatus;
- (void)willEndStatus;
- (void)normalStatus;

@end
