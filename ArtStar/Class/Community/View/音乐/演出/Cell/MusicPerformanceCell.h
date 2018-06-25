//
//  MusicPerformanceCell.h
//  ArtStar
//
//  Created by abc on 5/28/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MusicPerformanceCellDelegate <NSObject>

- (void)hotClick:(NSInteger)index;
- (void)buyCLick:(NSInteger)index;

@end

@interface MusicPerformanceCell : UITableViewCell

- (void)willStarStatus;
- (void)willEndStatus;
- (void)normalStatus;

@end
