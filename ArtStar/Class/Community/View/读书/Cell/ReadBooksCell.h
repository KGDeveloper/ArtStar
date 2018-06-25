//
//  ReadBooksCell.h
//  ArtStar
//
//  Created by abc on 6/5/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReadBooksCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *bookImag;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *stareLab;
@property (weak, nonatomic) IBOutlet UIView *starView;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;


@end
