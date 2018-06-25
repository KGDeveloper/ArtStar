//
//  FriendsDetailCommentCell.h
//  ArtStar
//
//  Created by abc on 5/22/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendsDetailCommentCell : UITableViewCell

@property (nonatomic,assign) BOOL isShowCommentBtu;

- (void)valuenikName:(NSString *)nikName comment:(NSString *)commnet;

@end
