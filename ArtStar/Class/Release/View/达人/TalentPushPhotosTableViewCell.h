//
//  TalentPushPhotosTableViewCell.h
//  ArtStar
//
//  Created by abc on 2018/6/25.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TalentPushPhotosTableViewCellDelegate <NSObject>

- (void)touchAddButtonWithIndex:(NSInteger)index;
- (void)deleteImageFrameCell:(UIImage *)image;
- (void)deleteVideos;

@end

@interface TalentPushPhotosTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (nonatomic,copy) NSArray *imageArr;
@property (nonatomic,copy) NSURL *videoStr;
@property (nonatomic,assign) NSInteger cellIndex;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backViewHeight;
@property (nonatomic,weak) id<TalentPushPhotosTableViewCellDelegate> delegate;

- (CGFloat)cellHeightFromArray:(NSArray *)imageArr;

@end
