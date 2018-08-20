//
//  HeadLinesTableViewCell.h
//  ArtStar
//
//  Created by abc on 5/24/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HeadLinesTableViewCell;
@protocol HeadLinesTableViewCellDelagate <NSObject>

- (void)deleteNewsWithIndex:(HeadLinesTableViewCell *)cell buttonOriginY:(CGFloat)y index:(NSInteger)index;
- (void)touchCellButtonWithTitle:(NSString *)title cellIndex:(NSInteger)cellIndex;

@end

@interface HeadLinesTableViewCell : UITableViewCell

@property (nonatomic,assign) CGFloat btuOriginY;
@property (nonatomic,assign) NSInteger cellIndex;
@property (nonatomic,weak) id<HeadLinesTableViewCellDelagate>delegate;
@property (nonatomic,copy) NSDictionary *dic;

@end
