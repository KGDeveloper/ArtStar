//
//  MineFeedBackIdeaTableViewCell.h
//  ArtStar
//
//  Created by abc on 2018/6/20.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MineFeedBackIdeaTableViewCellDelegate <NSObject>

- (void)sendIdeaToController:(NSString *)idea;

@end

@interface MineFeedBackIdeaTableViewCell : UITableViewCell <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *alertLab;
@property (weak, nonatomic) IBOutlet UITextView *ideaTF;
@property (weak, nonatomic) IBOutlet UILabel *countLab;

@property (nonatomic,weak) id<MineFeedBackIdeaTableViewCellDelegate>delegate;

@end
