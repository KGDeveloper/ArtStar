//
//  KGCommentTF.m
//  ArtStar
//
//  Created by abc on 5/25/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "KGCommentTF.h"

@implementation KGCommentTF

- (CGRect)placeholderRectForBounds:(CGRect)bounds{
    return CGRectMake(15, 0, bounds.size.width - 30, bounds.size.height);
}

- (CGRect)textRectForBounds:(CGRect)bounds{
    return CGRectMake(15, 0, bounds.size.width - 30, bounds.size.height);
}

- (CGRect)editingRectForBounds:(CGRect)bounds{
    return CGRectMake(15, 0, bounds.size.width - 30, bounds.size.height);
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
