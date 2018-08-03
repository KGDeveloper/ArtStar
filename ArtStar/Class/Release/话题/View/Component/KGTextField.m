//
//  KGTextField.m
//  ArtStar
//
//  Created by abc on 5/15/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "KGTextField.h"

@implementation KGTextField

- (void)deleteBackward{
    [super deleteBackward];
    if ([self.kgDelegate respondsToSelector:@selector(textFieldDeleteBackward:)]) {
        [self.kgDelegate textFieldDeleteBackward:self];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
