//
//  FriendsThemeLeftImageCell.h
//  ArtStar
//
//  Created by abc on 5/21/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FriendsThemeLeftImageCellDelegate <NSObject>

- (void)deleteCell:(NSInteger)index;
- (void)headerPushInfo:(NSInteger)index;
- (void)lookAllCellImage:(NSInteger)index;
- (void)commentCell:(NSInteger)index;
- (void)zansCell:(NSInteger)index;
- (void)shareCell:(NSInteger)index;

@end

@interface FriendsThemeLeftImageCell: UITableViewCell

@property (nonatomic,weak) id<FriendsThemeLeftImageCellDelegate>delegate;
@property (nonatomic,assign) NSInteger cellIndex;

@end
