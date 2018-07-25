//
//  TlentIntroudceTableViewCell.h
//  ArtStar
//
//  Created by abc on 2018/6/25.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TlentIntroudceTableViewCellDelegate <NSObject>

- (void)whereAreYour;
- (void)sendYouIntroudceToController:(NSString *)text;

@end

@interface TlentIntroudceTableViewCell : UITableViewCell<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *plholderLab;
@property (weak, nonatomic) IBOutlet UITextView *introudceTV;
@property (weak, nonatomic) IBOutlet UIButton *locationBtu;
@property (weak, nonatomic) id<TlentIntroudceTableViewCellDelegate>delegate;

@end
