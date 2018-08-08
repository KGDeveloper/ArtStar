//
//  MineFeedBackPictureTableViewCell.h
//  ArtStar
//
//  Created by abc on 2018/6/20.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MineFeedBackPictureTableViewCellDelegate <NSObject>

- (void)chooseImage;

@end

@interface MineFeedBackPictureTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIScrollView *backView;
@property (weak, nonatomic) IBOutlet UILabel *countLab;
@property (nonatomic,copy) NSArray *photosArr;

@property (nonatomic,weak) id<MineFeedBackPictureTableViewCellDelegate>delegate;

@end
