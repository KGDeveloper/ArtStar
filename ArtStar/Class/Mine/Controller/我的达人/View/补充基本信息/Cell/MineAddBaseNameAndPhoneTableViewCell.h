//
//  MineAddBaseNameAndPhoneTableViewCell.h
//  ArtStar
//
//  Created by abc on 2018/6/15.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MineAddBaseNameAndPhoneTableViewCellDelegate <NSObject>

- (void)sendYourNameTelephone:(NSString *)name phone:(NSString *)phone;

@end

@interface MineAddBaseNameAndPhoneTableViewCell : UITableViewCell<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *phoneLab;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;

@property (weak, nonatomic) id<MineAddBaseNameAndPhoneTableViewCellDelegate>delegate;


@end
