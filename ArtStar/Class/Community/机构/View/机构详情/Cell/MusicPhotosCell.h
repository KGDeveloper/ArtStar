//
//  MusicPhotosCell.h
//  ArtStar
//
//  Created by abc on 5/29/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MusicPhotosCellDelegate <NSObject>

- (void)tletePhoneAction;

@end

@interface MusicPhotosCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *countLab;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UILabel *adressLab;

@property (weak, nonatomic) IBOutlet UIButton *spaceLab;

@property (nonatomic,weak) id<MusicPhotosCellDelegate>delegate;

@property (nonatomic,copy) NSArray *imageArr;


@end
