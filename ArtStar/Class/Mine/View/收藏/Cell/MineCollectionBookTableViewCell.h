//
//  MineCollectionBookTableViewCell.h
//  ArtStar
//
//  Created by abc on 2018/6/14.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineCollectionBookTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *locationLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@end
