//
//  KGSlider.m
//  ArtStar
//
//  Created by abc on 6/5/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "KGSlider.h"

@implementation KGSlider

- (CGRect)trackRectForBounds:(CGRect)bounds{
    return CGRectMake(0, 2.5, bounds.size.width, bounds.size.height - 5);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
