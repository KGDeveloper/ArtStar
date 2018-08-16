//
//  MineCollectionStarCircleTableViewCell.h
//  ArtStar
//
//  Created by abc on 2018/6/14.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MineCollectionStarCircleTableViewCellDelegate <NSObject>

- (void)deleteContellWithID:(NSInteger)ID;

@end

@interface MineCollectionStarCircleTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UIImageView *topImage;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topWidth;
@property (nonatomic,assign) NSInteger cellId;
@property (nonatomic,weak) id<MineCollectionStarCircleTableViewCellDelegate> delegate;

@end
