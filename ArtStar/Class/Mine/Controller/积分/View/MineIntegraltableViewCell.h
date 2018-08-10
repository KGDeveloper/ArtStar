//
//  MineIntegraltableViewCell.h
//  ArtStar
//
//  Created by abc on 2018/6/14.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MineIntegraltableViewCellDelegate <NSObject>

- (void)clickBtuToDoSomeThing:(NSString *)someThing;

@end

@interface MineIntegraltableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIButton *statusBtu;
@property (nonatomic,weak) id<MineIntegraltableViewCellDelegate>delegate;


@end
