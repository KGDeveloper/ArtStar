//
//  FocusViewChatPermissionsCell.h
//  ArtStar
//
//  Created by abc on 6/8/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FocusViewChatPermissionsCellDelegate <NSObject>

- (void)changeStatusWithName:(NSString *)name status:(NSString *)status;

@end

@interface FocusViewChatPermissionsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;
@property (weak, nonatomic) IBOutlet UISwitch *statusSwitch;
@property (nonatomic,weak) id<FocusViewChatPermissionsCellDelegate>delegate;

@end
