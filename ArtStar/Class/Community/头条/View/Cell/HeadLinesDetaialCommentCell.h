//
//  HeadLinesDetaialCommentCell.h
//  ArtStar
//
//  Created by abc on 5/25/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol HeadLinesDetaialCommentCellDelegate <NSObject>

- (void)zansCommentWithID:(NSInteger)ID withStyle:(NSString *)style;

@end

@interface HeadLinesDetaialCommentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UILabel *nikName;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *commentLab;
@property (weak, nonatomic) IBOutlet UIButton *zansBtu;
@property (nonatomic,assign) NSInteger cellID;
@property (weak, nonatomic) id<HeadLinesDetaialCommentCellDelegate>delegate;


@end
