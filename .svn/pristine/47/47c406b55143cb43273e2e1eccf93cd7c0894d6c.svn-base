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
- (void)commentCell:(NSInteger)index;
- (void)zansCell:(NSInteger)index;
- (void)shareCell:(NSInteger)index;

@end

@interface FriendsLeftImageRightLabelCell : UITableViewCell

@property (nonatomic,strong) UIImageView *headerImage;
@property (nonatomic,strong) UILabel *nikNameLab;
@property (nonatomic,strong) UILabel *timeLab;
@property (nonatomic,strong) UILabel *locationLab;
@property (nonatomic,strong) UILabel *countLab;
@property (nonatomic,strong) UIButton *commentBtu;
@property (nonatomic,strong) UIButton *zansBtu;
@property (nonatomic,copy) NSString *contentStr;
@property (nonatomic,copy) NSString *topImageUrl;
@property (nonatomic,weak) id<FriendsButtomImageTopLabelCellDelegate>delegate;
@property (nonatomic,assign) NSInteger cellIndex;
@property (nonatomic,assign) YYTextVerticalAlignment textAlignment;

@end
