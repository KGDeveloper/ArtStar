//
//  ReleaseTaskIntrduiceCell.h
//  ArtStar
//
//  Created by 文艺星球 on 2018/8/3.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ReleaseTaskIntrduiceCellDelegate <NSObject>
/**
 发送任务描述

 @param describe 任务描述
 */
- (void)sendTaskDescribe:(NSString *)describe;
/**
 发布任务
 */
- (void)releaseTask;

@end

@interface ReleaseTaskIntrduiceCell : UITableViewCell<UITextViewDelegate>

/**
 标题
 */
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
/**
 填写描述的textview
 */
@property (weak, nonatomic) IBOutlet UITextView *writeLab;
/**
 提示文字
 */
@property (weak, nonatomic) IBOutlet UILabel *placehodleLab;
/**
 发布任务
 */
@property (weak, nonatomic) IBOutlet UIButton *releaseBtu;
/**
 发送任务描述到view
 */
@property (weak, nonatomic) id <ReleaseTaskIntrduiceCellDelegate>delegate;


@end
