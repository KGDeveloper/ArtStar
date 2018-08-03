//
//  CommunityExhibitionWorkerCell.h
//  ArtStar
//
//  Created by 文艺星球 on 2018/8/2.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommunityExhibitionWorkerCell : UITableViewCell
/**
 艺术家列表
 */
@property (weak, nonatomic) IBOutlet UIScrollView *topScrollView;
/**
 艺术家照片列表
 */
@property (weak, nonatomic) IBOutlet UIScrollView *centerScrollView;

- (void)changeScrollViewWithArray:(NSArray *)arr;

@end
