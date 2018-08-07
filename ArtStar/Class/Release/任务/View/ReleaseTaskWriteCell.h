//
//  ReleaseTaskWriteCell.h
//  ArtStar
//
//  Created by 文艺星球 on 2018/8/3.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ReleaseTaskWriteCellDelegate <NSObject>

/**
 当点击选择开始以及结束时间的时候，改变输入框的输入状态，变成点击事件

 @param text 用来判断是开始事件还是结束时间
 */
- (void)changeTextFieldEditStyleWithString:(NSString *)text;
/**
 当UITextField停止编辑时，发送编辑内容到UIView

 @param text 编辑内容
 @param placeholder 预留字
 */
- (void)whenTextFieldEndEditSendContentTextToTheUIView:(NSString *)text placeholder:(NSString *)placeholder;

@end

@interface ReleaseTaskWriteCell : UITableViewCell<UITextFieldDelegate>
/**
 标题
 */
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
/**
 填写框
 */
@property (weak, nonatomic) IBOutlet UITextField *titleText;
/**
 改变输入框状态
 */
@property (nonatomic,weak) id <ReleaseTaskWriteCellDelegate>delegate;

@end
