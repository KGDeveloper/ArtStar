//
//  CommunityExhibitionDetailTimeAndAddressCell.h
//  ArtStar
//
//  Created by 文艺星球 on 2018/8/1.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CommunityExhibitionDetailTimeAndAddressCellDelegate <NSObject>

- (void)buyTicket;
- (void)editScore;

@end

@interface CommunityExhibitionDetailTimeAndAddressCell : UITableViewCell

/**
 标题标签
 */
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
/**
 第一个星星
 */
@property (weak, nonatomic) IBOutlet UIImageView *oneImage;
/**
 第二个星星
 */
@property (weak, nonatomic) IBOutlet UIImageView *twoImage;
/**
 第三个星星
 */
@property (weak, nonatomic) IBOutlet UIImageView *threeImage;
/**
 第四个星星
 */
@property (weak, nonatomic) IBOutlet UIImageView *fourImage;
/**
 第五个星星
 */
@property (weak, nonatomic) IBOutlet UIImageView *fiveImage;
/**
 评分标签
 */
@property (weak, nonatomic) IBOutlet UILabel *scoreLab;
/**
 评分按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *scoreBtu;
/**
 展览时间
 */
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
/**
 展览时间加载view的高
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timeViewHeight;
/**
 展览机构
 */
@property (weak, nonatomic) IBOutlet UILabel *orgzanizationLab;
/**
 展览地址
 */
@property (weak, nonatomic) IBOutlet UILabel *addressLab;
/**
 主办单位
 */
@property (weak, nonatomic) IBOutlet UILabel *hostUnitLab;
/**
 门票价格
 */
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
/**
 预定门票
 */
@property (weak, nonatomic) IBOutlet UIButton *buyBtu;
@property (weak ,nonatomic) id<CommunityExhibitionDetailTimeAndAddressCellDelegate>delegate;

/**
 根据评分加载变化星星颜色

 @param scroe 评分值
 */
- (void)changeImageWithScoreNumber:(double)scroe;

@end
