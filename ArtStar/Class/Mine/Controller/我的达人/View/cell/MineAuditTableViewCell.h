//
//  MineAuditTableViewCell.h
//  ArtStar
//
//  Created by abc on 2018/6/19.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MineAuditTableViewCellDelegate <NSObject>

/**
 根据状态改变达人审核

 @param ID 达人发布ID
 @param cellStatus 选中还是非选中状态
 */
- (void)changeTalentStatusWithID:(NSInteger)ID status:(NSString *)cellStatus;

@end

@interface MineAuditTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UIButton *editBtu;
@property (weak, nonatomic) IBOutlet UILabel *dayLab;
@property (weak, nonatomic) IBOutlet UILabel *mouthLab;
@property (weak, nonatomic) IBOutlet UILabel *locationLab;
@property (weak, nonatomic) IBOutlet UIImageView *topImage;
@property (weak, nonatomic) IBOutlet UIView *countView;
@property (weak, nonatomic) IBOutlet UILabel *countLab;
@property (weak, nonatomic) IBOutlet UIButton *playBtu;
@property (weak, nonatomic) IBOutlet UILabel *textLab;
@property (weak, nonatomic) IBOutlet UILabel *detaiLab;
@property (weak, nonatomic) IBOutlet UIImageView *auditImage;
@property (nonatomic, assign) NSInteger cellID;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewWidth;
@property (weak, nonatomic) id <MineAuditTableViewCellDelegate>delegate;

@end
