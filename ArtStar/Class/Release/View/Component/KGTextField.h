//
//  KGTextField.h
//  ArtStar
//
//  Created by abc on 5/15/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KGTextField;
@protocol KGTextFieldDelegate <NSObject>

- (void)textFieldDeleteBackward:(KGTextField *)textField;

@end

@interface KGTextField : UITextField

@property (nonatomic,weak) id<KGTextFieldDelegate>kgDelegate;

@end
