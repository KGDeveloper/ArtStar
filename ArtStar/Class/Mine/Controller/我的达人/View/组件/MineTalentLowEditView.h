//
//  MineTalentLowEditView.h
//  ArtStar
//
//  Created by 文艺星球 on 2018/8/7.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineTalentLowEditView : UIView

/**
 左边标签
 */
@property (nonatomic,copy) NSString *title;
/**
 右边标签
 */
@property (nonatomic,copy) NSString *detailStr;
/**
 全选
 */
@property (nonatomic,copy) void(^chooseAllCell)(NSString *clear);
/**
 删除
 */
@property (nonatomic,copy) void(^deleteChooseCell)(NSString *deleteStr);

@end
