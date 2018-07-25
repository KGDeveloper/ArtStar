//
//  FriendsThemeCirulerImageCell.h
//  ArtStar
//
//  Created by abc on 5/21/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FriendsModel;
@protocol FriendsThemeCirulerImageCellDelegate <NSObject>

- (void)deleteCell:(NSInteger)index;
- (void)headerPushInfo:(NSInteger)index;
- (void)commentCell:(NSInteger)index;
- (void)zansCell:(NSInteger)index;
- (void)shareCell:(NSInteger)index;

@end

@interface FriendsThemeCirulerImageCell: UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UILabel *nikNameLab;
@property (weak, nonatomic) IBOutlet UIImageView *topImage;
@property (weak, nonatomic) IBOutlet UILabel *countLab;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *themelab;
@property (weak, nonatomic) IBOutlet UIButton *commentBtu;
@property (weak, nonatomic) IBOutlet UIButton *zansBtu;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *locationLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *locationWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timeWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *zansWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentWidth;
@property (nonatomic,weak) id<FriendsThemeCirulerImageCellDelegate>delegate;

- (void)fillCellWithModel:(FriendsModel *)model;

@end
