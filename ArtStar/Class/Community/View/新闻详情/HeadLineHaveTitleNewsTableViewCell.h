//
//  HeadLineHaveTitleNewsTableViewCell.h
//  ArtStar
//
//  Created by abc on 2018/6/27.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadLineHaveTitleNewsTableViewCell : UITableViewCell

@property (nonatomic,copy) NSString *titleStr;
@property (nonatomic,copy) NSString *detailStr;

- (CGFloat)tableViewCellRowHeight:(NSString *)string;

@end
