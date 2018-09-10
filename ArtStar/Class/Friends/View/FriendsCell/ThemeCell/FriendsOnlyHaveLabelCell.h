//
//  FriendsOnlyHaveLabelCell.h
//  ArtStar
//
//  Created by abc on 5/21/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FriendsModel;
@protocol FriendsOnlyHaveLabelCellDelegate <NSObject>

- (void)deleteCell:(NSInteger)index;
- (void)headerPushInfo:(NSInteger)index;
- (void)commentCell:(NSInteger)index;
- (void)zansCell:(NSInteger)index;
- (void)shareCell:(NSInteger)index;

@end


@interface FriendsOnlyHaveLabelCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *deleteBtu;
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;

@property (weak, nonatomic) IBOutlet UILabel *nikeNameLab;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@property (weak, nonatomic) IBOutlet UILabel *themeLab;
@property (weak, nonatomic) IBOutlet UIButton *zansBtu;
@property (weak, nonatomic) IBOutlet UILabel *locationLab;

@property (weak, nonatomic) IBOutlet UIButton *commentBtu;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *zansWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tileWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *locationWidth;

@property (nonatomic,weak) id<FriendsOnlyHaveLabelCellDelegate>delegate;

- (void)fillCellWithModel:(NSDictionary *)model;

@end
