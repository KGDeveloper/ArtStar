//
//  CommunityExhibitionIntrouceCell.h
//  ArtStar
//
//  Created by 文艺星球 on 2018/8/2.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommunityExhibitionIntrouceCell : UITableViewCell

/**
 展览介绍
 */
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
/**
 语音播报按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *voiceBtu;
/**
 展览介绍
 */
@property (weak, nonatomic) IBOutlet UILabel *detailLab;

@end
