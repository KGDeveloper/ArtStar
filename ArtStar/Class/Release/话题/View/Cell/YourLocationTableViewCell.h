//
//  YourLocationTableViewCell.h
//  ArtStar
//
//  Created by abc on 5/14/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YourLocationTableViewCell : UITableViewCell
/**
 位置
 */
@property (weak, nonatomic) IBOutlet UILabel *locationLab;
/**
 去过多少人
 */
@property (weak, nonatomic) IBOutlet UILabel *posenLab;

@end
