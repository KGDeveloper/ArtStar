//
//  CustomAnnotationView.m
//  ArtStar
//
//  Created by 文艺星球 on 2018/9/1.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "CustomAnnotationView.h"

#define kCalloutWidth       200.0
#define kCalloutHeight      70.0

@implementation CustomAnnotationView

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    if (self.selected == selected)
    {
        return;
    }
    
    if (selected)
    {
        if (self.calloutView == nil){
            self.calloutView = [[CustomCalloutView alloc]initWithFrame:CGRectMake(0, 0, kCalloutWidth, kCalloutHeight)];
            self.calloutView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f + self.calloutOffset.x,
                                                  -CGRectGetHeight(self.calloutView.bounds) / 2.f + self.calloutOffset.y);
        }
        
        self.calloutView.image = Image(@"地图测试数据");
        self.calloutView.userInteractionEnabled = YES;
        self.calloutView.title = [[self.annotation.title componentsSeparatedByString:@"-"] firstObject];
        self.calloutView.subtitle = self.annotation.subtitle;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MapSelect" object:[[self.annotation.title componentsSeparatedByString:@"-"] lastObject]];
        
        [self addSubview:self.calloutView];
    }
    else
    {
        [self.calloutView removeFromSuperview];
    }
    
    [super setSelected:selected animated:animated];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
