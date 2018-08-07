//
//  MinePushIDCardTableViewCell.h
//  ArtStar
//
//  Created by abc on 2018/6/19.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MinePushIDCardTableViewCellDelegate <NSObject>

- (void)chooseImage:(NSString *)btu;

@end

@interface MinePushIDCardTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIButton *leftBtu;
@property (weak, nonatomic) IBOutlet UIButton *rightBtu;

@property (weak, nonatomic) id<MinePushIDCardTableViewCellDelegate>delegate;


@end
