//
//  MineFeedBackChooseTableViewCell.h
//  ArtStar
//
//  Created by abc on 2018/6/19.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MineFeedBackChooseTableViewCellDelegate <NSObject>

- (void)sendChooseResonToController:(NSString *)reson;

@end

@interface MineFeedBackChooseTableViewCell : UITableViewCell

@property (nonatomic,weak) id<MineFeedBackChooseTableViewCellDelegate>delegate;

@end
