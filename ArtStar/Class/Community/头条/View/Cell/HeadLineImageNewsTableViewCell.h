//
//  HeadLineImageNewsTableViewCell.h
//  ArtStar
//
//  Created by abc on 2018/6/29.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadLineImageNewsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *topImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labHeight;
@end
