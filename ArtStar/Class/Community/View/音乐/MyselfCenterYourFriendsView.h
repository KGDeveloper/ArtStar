//
//  MyselfCenterYourFriendsView.h
//  ArtStar
//
//  Created by abc on 2018/6/26.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyselfCenterYourFriendsView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *lowImage;
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UILabel *nikName;
@property (weak, nonatomic) IBOutlet UILabel *detaialLab;

+ (MyselfCenterYourFriendsView *)initView;

@end
