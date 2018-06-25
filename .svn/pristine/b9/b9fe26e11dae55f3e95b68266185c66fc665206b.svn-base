//
//  ChangeModelView.h
//  ArtStar
//
//  Created by abc on 5/7/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChangeModelViewDelegate <NSObject>

- (void)changeViewFrame:(CGRect)frame;
- (void)changeModelViewClick;
- (void)textFieldLenght;
- (void)sendStringToView:(NSString *)string index:(NSInteger)index;

@end

@interface ChangeModelView : UIView

@property (nonatomic,weak) id<ChangeModelViewDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame type:(NSInteger)type;

@end
