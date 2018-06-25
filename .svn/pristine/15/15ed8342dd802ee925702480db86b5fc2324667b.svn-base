//
//  FriendsMessageView.h
//  ArtStar
//
//  Created by abc on 5/23/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FriendsMessageViewDelegate <NSObject>

- (void)loadMessage;

@end

@interface FriendsMessageView : UIView

@property (nonatomic,copy) NSString *imageStr;
@property (nonatomic,copy) NSString *messStr;
@property (nonatomic,weak) id<FriendsMessageViewDelegate>delegate;

@end
