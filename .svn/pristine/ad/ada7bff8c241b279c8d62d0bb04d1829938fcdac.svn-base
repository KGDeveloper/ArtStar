//
//  FriendsCommentView.h
//  ArtStar
//
//  Created by abc on 5/22/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendsCustomTextField.h"

@protocol FriendsCommentViewDelegate <NSObject>

- (void)releaseComment:(NSString *)comment;

@end

@interface FriendsCommentView : UIView

@property (nonatomic,strong) FriendsCustomTextField *commnetView;
@property (nonatomic,weak) id<FriendsCommentViewDelegate>delegate;
@property (nonatomic,copy) NSString *plholder;

@end
