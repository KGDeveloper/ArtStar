//
//  ReleaseTaskWriteCell.h
//  ArtStar
//
//  Created by 文艺星球 on 2018/8/3.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReleaseTaskWriteCell : UITableViewCell<UITextFieldDelegate>
/**
 标题
 */
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
/**
 填写框
 */
@property (weak, nonatomic) IBOutlet UITextField *titleText;

@end
