//
//  FriendsLeftImageRightLabelCell.h
//  ArtStar
//
//  Created by abc on 5/22/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FriendsLeftImageRightLabelCellDelegate <NSObject>

- (void)deleteCell:(NSInteger)index;
- (void)headerPushInfo:(NSInteger)index;
- (void)lookAllCellImage:(NSInteger)index;
- (void)commentCell:(NSInteger)index;
- (void)zansCell:(NSInteger)index;
- (void)shareCell:(NSInteger)index;

@end

@interface FriendsLeftImageRightLabelCell : UITableViewCell

@property (nonatomic,weak) id<FriendsButtomImageTopLabelCellDelegate>delegate;
@property (nonatomic,assign) NSInteger cellIndex;

@end
