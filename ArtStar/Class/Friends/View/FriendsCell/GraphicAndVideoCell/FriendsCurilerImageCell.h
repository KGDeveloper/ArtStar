//
//  FriendsCurilerImageCell.h
//  ArtStar
//
//  Created by abc on 5/21/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FriendsCurilerImageCellDelegate <NSObject>

- (void)deleteCell:(NSInteger)index;
- (void)headerPushInfo:(NSInteger)index;
- (void)lookAllCellImage:(NSInteger)index;
- (void)commentCell:(NSInteger)index;
- (void)zansCell:(NSInteger)index;
- (void)shareCell:(NSInteger)index;

@end

@interface FriendsCurilerImageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headerIamge;
@property (weak, nonatomic) IBOutlet UILabel *nikNameLab;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIImageView *topImage;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *locationLab;
@property (weak, nonatomic) IBOutlet UIButton *shareBtu;
@property (weak, nonatomic) IBOutlet UIButton *commentBtu;
@property (weak, nonatomic) IBOutlet UIButton *zansBtu;
@property (weak, nonatomic) IBOutlet UILabel *countLab;
@property (nonatomic,weak) id<FriendsCurilerImageCellDelegate>delegate;
@property (nonatomic,assign) NSInteger cellIndex;


@end
