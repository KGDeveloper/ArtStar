//
//  MineEditMyselfInfoEditCell.h
//  ArtStar
//
//  Created by abc on 6/11/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MineEditMyselfInfoEditCellDelegate <NSObject>

- (void)touchUITableViewCellMakeSomeThingWithTitle:(NSString *)title;
- (void)sendNikNameToController:(NSString *)nikName;
- (void)sendIntroudceToController:(NSString *)introudce;

@end

@interface MineEditMyselfInfoEditCell : UITableViewCell <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nikNameTF;
@property (weak, nonatomic) IBOutlet UILabel *brithdayLab;
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UILabel *heightLab;
@property (weak, nonatomic) IBOutlet UILabel *weightLab;
@property (weak, nonatomic) IBOutlet UITextField *introudceTF;
@property (weak, nonatomic) IBOutlet UILabel *homeLab;
@property (weak, nonatomic) id<MineEditMyselfInfoEditCellDelegate>delegate;

@end
