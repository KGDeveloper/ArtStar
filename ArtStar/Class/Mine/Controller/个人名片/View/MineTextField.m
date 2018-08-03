//
//  MineTextField.m
//  ArtStar
//
//  Created by abc on 2018/6/13.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineTextField.h"

@implementation MineTextField

- (CGRect)textRectForBounds:(CGRect)bounds{
    return CGRectMake(35, 0, bounds.size.width - 50,bounds.size.height);
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds{
    return CGRectMake(35, 0, bounds.size.width - 50,bounds.size.height);
}

- (CGRect)editingRectForBounds:(CGRect)bounds{
    return CGRectMake(35, 0, bounds.size.width - 50,bounds.size.height);
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds{
    return CGRectMake(10,(bounds.size.height - 15)/2, 13,15);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
