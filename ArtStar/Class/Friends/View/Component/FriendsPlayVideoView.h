//
//  FriendsPlayVideoView.h
//  ArtStar
//
//  Created by abc on 5/23/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FriendsPlayVideoViewdelegate <NSObject>

- (void)playModelVideo;

@end

@interface FriendsPlayVideoView : UIView

@property (nonatomic,strong) UIImage *videoIamge;
@property (nonatomic,weak) id<FriendsPlayVideoViewdelegate>delegate;

@end
