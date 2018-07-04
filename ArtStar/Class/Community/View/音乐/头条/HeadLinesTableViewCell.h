//
//  HeadLinesTableViewCell.h
//  ArtStar
//
//  Created by abc on 5/24/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommenityModel.h"

@class HeadLinesTableViewCell;
@protocol HeadLinesTableViewCellDelagate <NSObject>

- (void)deleteNewsWithIndex:(HeadLinesTableViewCell *)cell buttonOriginY:(CGFloat)y;

@end

@interface HeadLinesTableViewCell : UITableViewCell

@property (nonatomic,assign) CGFloat btuOriginY;
@property (nonatomic,assign) NSInteger cellIndex;
@property (nonatomic,weak) id<HeadLinesTableViewCellDelagate>delegate;
@property (nonatomic,strong) CommenityModel *model;

@end
