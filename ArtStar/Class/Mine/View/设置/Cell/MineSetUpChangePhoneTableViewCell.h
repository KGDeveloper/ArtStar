//
//  MineSetUpChangePhoneTableViewCell.h
//  ArtStar
//
//  Created by abc on 2018/6/19.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MineSetUpChangePhoneTableViewCellDelegate <NSObject>

- (void)changeYourPhone:(NSString *)type;

@end

@interface MineSetUpChangePhoneTableViewCell : UITableViewCell

@property (weak, nonatomic) id<MineSetUpChangePhoneTableViewCellDelegate>delegate;

@end
