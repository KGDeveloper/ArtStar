//
//  FriendsButtomImageTopLabelCell.h
//  ArtStar
//
//  Created by abc on 5/18/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FriendsButtomImageTopLabelCellDelegate <NSObject>

- (void)deleteCell:(NSInteger)index;
- (void)headerPushInfo:(NSInteger)index;
- (void)lookAllCellImage:(NSInteger)index;
- (void)playCellVideo:(NSInteger)index;
- (void)commentCell:(NSInteger)index;
- (void)zansCell:(NSInteger)index;
- (void)shareCell:(NSInteger)index;

@end

@interface FriendsButtomImageTopLabelCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UILabel *nikName;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIImageView *topImage;
@property (weak, nonatomic) IBOutlet UIButton *imageBtu;
@property (weak, nonatomic) IBOutlet UIView *playView;
@property (weak, nonatomic) IBOutlet UIButton *playBtu;
@property (weak, nonatomic) IBOutlet UIView *countView;
@property (weak, nonatomic) IBOutlet UILabel *countLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *locationLab;
@property (weak, nonatomic) IBOutlet UIButton *shareBtu;
@property (weak, nonatomic) IBOutlet UIButton *commentBtu;
@property (weak, nonatomic) IBOutlet UIButton *zansBtu;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timeWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *locationWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentWidht;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *zansWidth;
@property (nonatomic,weak) id<FriendsButtomImageTopLabelCellDelegate>delegate;
@property (nonatomic,assign) NSInteger cellIndex;

- (void)showVideo;
- (void)showGraphic;

@end
