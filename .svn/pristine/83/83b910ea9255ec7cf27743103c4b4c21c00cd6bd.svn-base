//
//  FriendsDetailTimeComponentView.h
//  ArtStar
//
//  Created by abc on 5/22/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FriendsDetailTimeComponentViewDelegate <NSObject>

- (void)shareAction;
- (void)collectionAction;
- (void)zansAction;
- (void)commentAction;

@end

@interface FriendsDetailTimeComponentView : UIView

@property (nonatomic,copy) NSString *timeStr;
@property (nonatomic,copy) NSString *locationStr;
@property (nonatomic,weak) id<FriendsDetailTimeComponentViewDelegate>delegate;

@end
