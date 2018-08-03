//
//  CustomTextField.m
//  ArtStar
//
//  Created by abc on 5/10/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "CustomTextField.h"

@implementation CustomTextField

- (CGRect)leftViewRectForBounds:(CGRect)bounds{
    return CGRectMake(6,6, 6, 9);
}
- (CGRect)rightViewRectForBounds:(CGRect)bounds{
    return CGRectMake(bounds.size.width - 12, 6, 6, 9);
}
//- (CGRect)textRectForBounds:(CGRect)bounds{
//    return CGRectMake(17, (bounds.size.height - 12)/2, bounds.size.width - 34, 12);
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
