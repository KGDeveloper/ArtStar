//
//  MineAuditTableViewCell.h
//  ArtStar
//
//  Created by abc on 2018/6/19.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

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

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewWidth;

@end
