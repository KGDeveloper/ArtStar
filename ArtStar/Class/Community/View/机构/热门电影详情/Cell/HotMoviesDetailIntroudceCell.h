//
//  HotMoviesDetailIntroudceCell.h
//  ArtStar
//
//  Created by abc on 5/30/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotMoviesDetailIntroudceCell : UITableViewCell

@property (nonatomic,copy) NSString *introudceStr;

- (CGFloat)cellHeightWithModel:(NSString *)text;

@end
