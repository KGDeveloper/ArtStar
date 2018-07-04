//
//  HeadlinesView.h
//  ArtStar
//
//  Created by abc on 5/24/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadlinesView : UIView

@property (nonatomic,copy) void(^pushViewController)(NSString *type);
@property (nonatomic,copy) void(^requestNewData)(NSString *type);
@property (nonatomic,copy) NSArray *dataArr;

- (void)showHeaderView;
- (void)hideHeaderView;

@end
