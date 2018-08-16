//
//  FriendsOnlyHaveImageCell.h
//  ArtStar
//
//  Created by abc on 5/17/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FriendsModel;
@protocol FriendsOnlyHaveImageCellDelegate <NSObject>

- (void)deleteCell:(NSInteger)index;
- (void)headerPushInfo:(NSInteger)index;
- (void)commentCell:(NSInteger)index;
- (void)zansCell:(NSInteger)index;
- (void)shareCell:(NSInteger)index;

@end

@interface FriendsOnlyHaveImageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *topImage;
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UILabel *nikNameLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *locationLab;
@property (weak, nonatomic) IBOutlet UIButton *zansBtu;
@property (weak, nonatomic) IBOutlet UIButton *commentBtu;
@property (weak, nonatomic) IBOutlet UIButton *shareBtu;
@property (weak, nonatomic) IBOutlet UILabel *themeLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timeWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *locationWidth;
@property (weak, nonatomic) IBOutlet UIView *labView;
@property (weak, nonatomic) IBOutlet UILabel *countLab;
@property (weak, nonatomic) IBOutlet UIView *btuView;
@property (weak, nonatomic) IBOutlet UIButton *lookAllImageBtu;
@property (weak, nonatomic) IBOutlet UIButton *playBtu;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentWidth;
@property (nonatomic,weak) id<FriendsOnlyHaveImageCellDelegate>delegate;

- (void)fillCellWithModel:(NSDictionary *)model;

- (void)showVideo;
- (void)showGraphic;

@end
