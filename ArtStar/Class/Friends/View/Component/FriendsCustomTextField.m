//
//  FriendsCustomTextField.m
//  ArtStar
//
//  Created by abc on 5/23/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "FriendsCustomTextField.h"

@implementation FriendsCustomTextField

- (CGRect)textRectForBounds:(CGRect)bounds{
    return CGRectMake(10, 0, bounds.size.width - 20, bounds.size.height);
}
- (CGRect)placeholderRectForBounds:(CGRect)bounds{
    return CGRectMake(10, 0, bounds.size.width - 20, bounds.size.height);
}
- (CGRect)editingRectForBounds:(CGRect)bounds{
    return CGRectMake(10, 0, bounds.size.width - 20, bounds.size.height);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
