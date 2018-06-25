//
//  FriendsThemeTopImageCell.h
//  ArtStar
//
//  Created by abc on 5/21/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FriendsThemeTopImageCellDelegate <NSObject>

- (void)deleteCell:(NSInteger)index;
- (void)headerPushInfo:(NSInteger)index;
- (void)lookAllCellImage:(NSInteger)index;
- (void)commentCell:(NSInteger)index;
- (void)zansCell:(NSInteger)index;
- (void)shareCell:(NSInteger)index;

@end

@interface FriendsThemeTopImageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headerIamge;
@property (weak, nonatomic) IBOutlet UILabel *nikNameLab;
@property (weak, nonatomic) IBOutlet UIImageView *topImage;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *themeLab;
@property (weak, nonatomic) IBOutlet UILabel *countLab;
@property (weak, nonatomic) IBOutlet UIButton *shareBtu;
@property (weak, nonatomic) IBOutlet UIButton *commentBtu;
@property (weak, nonatomic) IBOutlet UIButton *zansBtu;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *locationLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *zansWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timeWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *locationWidth;
@property (nonatomic,weak) id<FriendsThemeTopImageCellDelegate>delegate;
@property (nonatomic,assign) NSInteger cellIndex;

@end
