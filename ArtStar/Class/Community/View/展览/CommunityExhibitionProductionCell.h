//
//  CommunityExhibitionProductionCell.h
//  ArtStar
//
//  Created by 文艺星球 on 2018/8/2.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommunityExhibitionProductionCell : UITableViewCell
/**
 作品介绍
 */
@property (weak, nonatomic) IBOutlet UILabel *productionLab;
/**
 作品展示区域
 */
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (void)addProductionToScrollViewWithArray:(NSArray *)arr;

@end
