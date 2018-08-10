//
//  MineBooksFriendsTableViewCell.h
//  ArtStar
//
//  Created by abc on 2018/6/15.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MineBooksFriendsTableViewCellDelegate <NSObject>

- (void)foucsActionWithID:(NSString *)ID;

@end

@interface MineBooksFriendsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UIButton *foucsBtu;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageWidth;
@property (nonatomic,weak) id<MineBooksFriendsTableViewCellDelegate>delegate;
@property (nonatomic,copy) NSString *ID;

@end
