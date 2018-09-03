//
//  PickUpTaskTableViewCell.h
//  ArtStar
//
//  Created by 文艺星球 on 2018/8/13.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PickUpTaskTableViewCellDelegate <NSObject>

- (void)todoTaskWithID:(NSInteger)taskID;

@end

@interface PickUpTaskTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;
@property (nonatomic,assign) NSInteger taskID;
@property (nonatomic,weak) id<PickUpTaskTableViewCellDelegate>delegate;


@end
