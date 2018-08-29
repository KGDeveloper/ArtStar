//
//  FriendsDetailVericalView.m
//  ArtStar
//
//  Created by abc on 5/22/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "FriendsDetailVericalView.h"

@interface FriendsDetailVericalView ()

@property (nonatomic,strong) YYTextView *textView;

@end

@implementation FriendsDetailVericalView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self setUI];
        
    }
    return self;
}

- (void)setUI{
    
    _textView = [YYTextView new];
    
    [self sd_addSubviews:@[_textView]];
    _textView.editable = NO;
    _textView.scrollEnabled = NO;
    _textView.sd_layout.leftSpaceToView(self, 0).rightSpaceToView(self, 0).topSpaceToView(self, 0).bottomSpaceToView(self, 0);
    
}

- (void)setIsVertical:(BOOL)isVertical{
    _isVertical = isVertical;
    if (isVertical == YES) {
        _textView.verticalForm = YES;
    }
}

- (void)setTextStr:(NSString *)textStr{
    _textStr = textStr;
    if (textStr.length > 0 && textStr != nil) {
        [self changeYYTextView:_textView text:textStr];
    }
}

- (void)setYyAlignment:(YYTextVerticalAlignment)yyAlignment{
    _yyAlignment = yyAlignment;
    _textView.textVerticalAlignment = yyAlignment;
}

- (void)setTextAlinment:(NSTextAlignment)textAlinment{
    _textAlinment = textAlinment;
    _textView.textAlignment = textAlinment;
}

- (YYTextView *)changeYYTextView:(YYTextView *)textView text:(NSString *)text{
    textView.font = FZFont(13);
    NSMutableParagraphStyle *paragrapStyle = [[NSMutableParagraphStyle alloc]init];
    paragrapStyle.lineSpacing = 7;
    NSDictionary *attributes = @{NSFontAttributeName:FZFont(13),NSParagraphStyleAttributeName:paragrapStyle};
    textView.attributedText = [[NSAttributedString alloc]initWithString:text attributes:attributes];
    return textView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
