//
//  MineUnitAndPositionTableViewCell.h
//  ArtStar
//
//  Created by abc on 2018/6/19.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MineUnitAndPositionTableViewCellDelegate <NSObject>

- (void)sendUnitPosition:(NSString *)unit position:(NSString *)position;

@end

@interface MineUnitAndPositionTableViewCell : UITableViewCell <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *unitTF;
@property (weak, nonatomic) IBOutlet UITextField *positionTF;

@property (weak, nonatomic) id<MineUnitAndPositionTableViewCellDelegate>delegate;

@end
