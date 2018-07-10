//
//  CommunityShieldingView.h
//  ArtStar
//
//  Created by abc on 5/23/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CommunityShieldingViewDelegate <NSObject>

- (void)sendTitleArrToView:(NSArray *)selectArr index:(NSInteger)index;

@end

@interface CommunityShieldingView : UIView

@property (nonatomic,weak) id<CommunityShieldingViewDelegate>delegate;
@property (nonatomic,assign) CGFloat shieldingOrigin;
@property (nonatomic,assign) NSInteger index;

@end
