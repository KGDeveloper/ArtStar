//
//  MineReleaseArticleTableViewCell.h
//  ArtStar
//
//  Created by abc on 2018/6/15.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MineReleaseArticleTableViewCellDelegate <NSObject>

- (void)sendDeleteIDtoView:(NSInteger)ID style:(NSInteger)style;

@end

@interface MineReleaseArticleTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtu;
@property (weak, nonatomic) IBOutlet UILabel *dayLab;
@property (weak, nonatomic) IBOutlet UILabel *mouthLab;
@property (weak, nonatomic) IBOutlet UIImageView *topImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewWidth;
@property (nonatomic,assign) NSInteger ID;
@property (nonatomic,weak) id<MineReleaseArticleTableViewCellDelegate>delegate;

@end
